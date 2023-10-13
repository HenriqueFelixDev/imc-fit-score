import 'package:shared_preferences/shared_preferences.dart';

class SettingsStorage {
  final SharedPreferences _preferences;
  static const _hideOnboardingKey = 'hide_onboarding';
  
  const SettingsStorage({
    required SharedPreferences preferences,
  }) : _preferences = preferences;

  Future<bool> setHideOnboarding(bool value) async {
    return _preferences.setBool(_hideOnboardingKey, value);
  }

  bool get hideOnboarding => _preferences.getBool(_hideOnboardingKey) ?? false;
}