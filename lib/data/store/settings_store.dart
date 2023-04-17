import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsStore with ChangeNotifier {
  static const String dictionaryTagKey = "KEY_DICTIONARY_TAG";

  SettingsStore._();

  static final SettingsStore _instance = SettingsStore._();

  static SettingsStore get instance => _instance;

  String _dictionaryTag = 'en';

  Future<String> get dictionaryTag async {
    await _ensureLoadPreferences();
    return _dictionaryTag;
  }

  Future<bool> setDictionaryTag(String tag) async {
    final prefs = await SharedPreferences.getInstance();
    final result = await prefs.setString(dictionaryTagKey, tag);
    notifyListeners();
    return result;
  }

  Future<void> _ensureLoadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final dictionaryTag = prefs.getString(dictionaryTagKey);

    if (dictionaryTag != null) {
      _dictionaryTag = dictionaryTag;
    }
  }
}
