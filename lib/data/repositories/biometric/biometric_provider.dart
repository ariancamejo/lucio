import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucio/device/helpers/storage/secure.dart';

class BiometricNotifier extends StateNotifier<String?> {
  BiometricNotifier() : super(null) {
    _init();
  }

  _init() async {
    state = await SecureStorage.read('pin');
  }

  pin({String? value}) {
    if (value == null) {
      SecureStorage.delete('pin');
    } else {
      SecureStorage.set('pin', value: value);
    }
    state = value;
  }
}

final biometricProvider = StateNotifierProvider<BiometricNotifier, String?>((ref) {
  return BiometricNotifier();
});
