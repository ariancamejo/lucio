import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucio/device/helpers/storage/secure.dart';

enum THEMES { system, dark, light }

class ThemeNotifier extends StateNotifier<ThemeMode> {
  String theme = THEMES.system.name;
  StateNotifierProviderRef? ref;

  ThemeNotifier({required this.ref}) : super(ThemeMode.system) {
    _init();
  }

  set({required ThemeMode themeMode}) {
    theme = themeMode.name;
    SecureStorage.set('theme', value: theme);
    state = themeMode;
  }

  toogle() {
    ThemeMode themeMode = state;

    if (state.name == THEMES.dark.name) {
      themeMode = ThemeMode.light;
    }

    if (state.name == THEMES.light.name) {
      themeMode = ThemeMode.dark;
    }
    if (state.name == THEMES.system.name) {
      themeMode = ThemeMode.dark;
    }
    theme = themeMode.name;
    SecureStorage.set('theme', value: theme);
    state = themeMode;
  }

  _init() async {
    await Future.microtask(() async {
      theme = (await SecureStorage.read('theme')) ?? THEMES.system.name;
    });
    if (theme == THEMES.dark.name) {
      state = ThemeMode.dark;
    }

    if (theme == THEMES.light.name) {
      state = ThemeMode.light;
    }
    if (theme == THEMES.system.name) {
      state = ThemeMode.system;
    }
  }
}

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>((ref) {
  return ThemeNotifier(ref: ref);
});
