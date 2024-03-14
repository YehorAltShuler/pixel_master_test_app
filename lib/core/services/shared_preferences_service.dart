import 'package:shared_preferences/shared_preferences.dart';

// Global private constants
const String _kUsernameKey = 'userName';
const String _kUserEmailKey = 'userEmail';
const String _kIsUserLogedInKey = 'isUserLogedIn';
const String _kIsOnboardingCompleteKey = 'IsOnboardingComplete';
const String _kThemeTypeKey = 'themeType';

class SharedPreferencesService {
  static SharedPreferencesService? _instance;
  static late SharedPreferences _preferences;

  SharedPreferencesService._();

  // Using a singleton pattern
  static Future<SharedPreferencesService> getInstance() async {
    _instance ??= SharedPreferencesService._();

    _preferences = await SharedPreferences.getInstance();

    return _instance!;
  }

  // Persist and retrieve username
  String get userName => _getData(_kUsernameKey) ?? '';
  set userName(String value) => _saveData(_kUsernameKey, value);

  // Persist and retrieve userEmail
  String get userEmail => _getData(_kUserEmailKey) ?? '';
  set userEmail(String value) => _saveData(_kUserEmailKey, value);

  // Persist and retrieve isUserLoggedIn
  bool get isUserLoggedIn => _getData(_kIsUserLogedInKey) ?? false;
  set isUserLoggedIn(bool value) => _saveData(_kIsUserLogedInKey, value);

  // Persist and retrieve themeType
  String get themeType => _getData(_kThemeTypeKey) ?? 'system';
  set themeType(String value) => _saveData(_kThemeTypeKey, value);

  // Persist and retrieve isOnboardingComplete
  bool get isOnboardingComplete => _getData(_kIsOnboardingCompleteKey) ?? false;
  set isOnboardingComplete(bool value) =>
      _saveData(_kIsOnboardingCompleteKey, value);

  // Private generic method for retrieving data from shared preferences
  dynamic _getData(String key) {
    // Retrieve data from shared preferences
    var value = _preferences.get(key);

    // Easily log the data that we retrieve from shared preferences
    print('Retrieved $key: $value');

    if (value is List<Object?>) {
      List<String> stringList = value.map((obj) => obj.toString()).toList();
      return stringList;
    } else {
      // Return the data that we retrieve from shared preferences
      return value;
    }
  }

// Private method for saving data to shared preferences
  void _saveData(String key, dynamic value) {
    // Easily log the data that we save to shared preferences
    print('Saving $key: $value');

    // Save data to shared preferences
    if (value is String) {
      _preferences.setString(key, value);
    } else if (value is int) {
      _preferences.setInt(key, value);
    } else if (value is double) {
      _preferences.setDouble(key, value);
    } else if (value is bool) {
      _preferences.setBool(key, value);
    } else if (value is List<String>) {
      _preferences.setStringList(key, value);
    } else {
      throw Exception(
          'This type of data cannot be saved to shared preferences');
    }
  }
}
