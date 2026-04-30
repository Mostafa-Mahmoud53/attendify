import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends ValueNotifier<ThemeMode> {
  ThemeController({ThemeMode initialMode = ThemeMode.system}) : super(initialMode);

  static const String _storageKey = 'theme_mode';

  ThemeMode get mode => value;

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final storedValue = prefs.getString(_storageKey);
    if (storedValue == null) {
      return;
    }
    final parsed = _fromStorageValue(storedValue);
    if (parsed != null) {
      value = parsed;
    }
  }

  Future<void> setMode(ThemeMode mode) async {
    value = mode;
    await _persist(mode);
  }

  Future<void> toggle() async {
    switch (value) {
      case ThemeMode.system:
        await setMode(ThemeMode.light);
        break;
      case ThemeMode.light:
        await setMode(ThemeMode.dark);
        break;
      case ThemeMode.dark:
        await setMode(ThemeMode.system);
        break;
    }
  }

  Future<void> _persist(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_storageKey, _toStorageValue(mode));
  }

  String _toStorageValue(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.system:
        return 'system';
      case ThemeMode.light:
        return 'light';
      case ThemeMode.dark:
        return 'dark';
    }
  }

  ThemeMode? _fromStorageValue(String value) {
    switch (value) {
      case 'system':
        return ThemeMode.system;
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return null;
    }
  }
}
