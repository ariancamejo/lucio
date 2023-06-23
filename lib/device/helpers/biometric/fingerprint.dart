import 'package:flutter/material.dart';
import 'package:flutter_screen_lock/flutter_screen_lock.dart';
import 'package:local_auth/local_auth.dart';
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

Future<void> localAuth(BuildContext context, Function() onSuccess) async {
  final localAuth = LocalAuthentication();
  bool didAuthenticate = false;

  didAuthenticate = await localAuth.authenticate(
    localizedReason: "Authenticate to continue",
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

Future<void> checkAuth(
  BuildContext context, {
  bool useBiometric = false,
  required Function() onSuccess,
  bool obli = true,
}) async {
  bool finger = await BiometricInfoImpl().hasFingerprint;
  if (useBiometric && !finger) {
    useBiometric = false;
  }

  String? pin = await SecureStorage.read('pin');

  if (pin != null && context.mounted) {
    return screenLock(
      context: context,
      title: const Text("Enter unlock PIN"),
      correctString: pin,
      canCancel: !obli,
      customizedButtonChild: useBiometric
          ? const Icon(
              Icons.fingerprint,
            )
          : null,
      customizedButtonTap: useBiometric
          ? () async {
              await localAuth(
                context,
                () {
                  Navigator.pop(context);
                  onSuccess.call();
                },
              );
            }
          : null,
      cancelButton: const Text("Cancel", style: TextStyle(fontSize: 16)),
      didOpened: () async {
        if (useBiometric) {
          await Future.delayed(const Duration(milliseconds: 200));
          Future.microtask(
            () => localAuth(
              context,
              () {
                Navigator.pop(context);
                onSuccess.call();
              },
            ),
          );
        }
      },
      didUnlocked: () {
        Navigator.pop(context);
        onSuccess.call();
      },
    );
  } else {
    if (!obli) onSuccess.call();
  }
}
