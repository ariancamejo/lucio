import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screen_lock/flutter_screen_lock.dart';
import 'package:local_auth/local_auth.dart';
import 'package:lucio/data/repositories/options_provider.dart';
import 'package:lucio/device/device.dart';
import 'package:lucio/device/helpers/storage/secure.dart';

abstract class BiometricInfo {
  Future<bool> get hasFingerprint;
}

class BiometricInfoImpl implements BiometricInfo {
  final _localAuth = LocalAuthentication();

  @override
  Future<bool> get hasFingerprint async {
    List<BiometricType> availableBiometrics = await _localAuth.getAvailableBiometrics();
    if (availableBiometrics.contains(BiometricType.strong) || availableBiometrics.contains(BiometricType.face)) {
      return true;
    }

    return false;
  }
}

Future<void> localAuth(BuildContext context, Function() onSuccess, {String? message}) async {
  final localAuth = LocalAuthentication();
  bool didAuthenticate = false;

  didAuthenticate = await localAuth.authenticate(
    localizedReason: message ?? "Authenticate to continue",
    options: const AuthenticationOptions(
      useErrorDialogs: true,
      stickyAuth: true,
      biometricOnly: true,
    ),
  );

  if (didAuthenticate) {
    onSuccess.call();
  }
}

_authOff(WidgetRef ref, {Duration? duration}) => Future.delayed(duration ?? const Duration(milliseconds: 100), () => ref.read(optionsP.notifier).checkAuth = false);

Future<void> checkAuth(
  WidgetRef ref, {
  String? message,
  bool useBiometric = true,
  Function()? onSuccess,
  bool obli = false,
}) async {
  bool finger = await BiometricInfoImpl().hasFingerprint;
  if (useBiometric && !finger) {
    useBiometric = false;
  }
  BuildContext? context = Utils.currentContext(ref.read(optionsP.notifier).ref);
  if (context == null) return;

  String? pin = await SecureStorage.read('pin');
  bool checkAuth = ref.read(optionsP).checkAuth;
  if (checkAuth) return;

  if (pin != null && context.mounted) {
    return screenLock(
      context: context,
      title: Text(message ?? "Enter unlock PIN"),
      correctString: pin,
      canCancel: !obli,
      customizedButtonChild: useBiometric ? const Icon(Icons.fingerprint) : null,
      customizedButtonTap: useBiometric
          ? () async {
              ref.read(optionsP.notifier).checkAuth = true;
              await localAuth(
                context,
                message: message,
                () {
                  Navigator.pop(context);
                  onSuccess?.call();
                },
              ).then(
                (value) => _authOff(
                  ref,
                  duration: const Duration(seconds: 1),
                ),
              );
            }
          : null,
      cancelButton: const Text("Cancel", style: TextStyle(fontSize: 16)),
      didOpened: () async {
        if (useBiometric) {
          await Future.delayed(const Duration(milliseconds: 200));
          ref.read(optionsP.notifier).checkAuth = true;
          Future.microtask(
            () => localAuth(
              context,
              message: message,
              () {
                Navigator.pop(context);
                onSuccess?.call();
              },
            ).then(
              (value) => _authOff(
                ref,
                duration: const Duration(seconds: 1),
              ),
            ),
          );
        }
      },
      didUnlocked: () {
        Navigator.pop(context);

        onSuccess?.call();
      },
    ).then((value) {
      print("Finish dialog");
      if (!useBiometric) _authOff(ref);
    });
  } else {
    if (!obli) {
      onSuccess?.call();
    }
  }
}
