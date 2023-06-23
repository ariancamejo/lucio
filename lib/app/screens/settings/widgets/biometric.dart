import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screen_lock/flutter_screen_lock.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lucio/data/repositories/biometric/biometric_provider.dart';
import 'package:lucio/data/repositories/options_provider.dart';
import 'package:lucio/device/helpers/biometric/fingerprint.dart';

class BiometricOption extends ConsumerWidget {
  const BiometricOption({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    final value = ref.watch(biometricProvider);
    return ListTile(
      leading: const Icon(FontAwesomeIcons.fingerprint),
      title: const Text("Access pin"),
      subtitle: const Text("Add security to your app, require authorization to enter the application and other important functions"),
      trailing: Switch(
        activeColor: scheme.primary,
        value: value != null,
        onChanged: (value) {
          if (value) {
            screenLock(
              context: context,
              title: const Text("Enter unlock PIN"),
              confirmTitle: const Text("Please confirm the pin"),
              correctString: '',
              confirmation: true,
              cancelButton: const Text("Cancel", style: TextStyle(fontSize: 15)),
              didConfirmed: (matchedText) {
                //save pin
                ref.read(biometricProvider.notifier).pin(value: matchedText);
                Navigator.pop(context);
              },
            );
          } else {
            checkAuth(
              ref,
              obli: false,
              useBiometric: false,
              message: "Disable Auth required for actions",
              onSuccess: () {
                //remove pin
                ref.read(biometricProvider.notifier).pin(value: null);
              },
            );
          }
        },
      ),
    );
  }
}
