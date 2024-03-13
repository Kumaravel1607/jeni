import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefence {
  static late SharedPreferences _preferences;

  static const _keyUsername = 'email';
  static const _keymobile = 'mobile';
  static const _keytoken = 'token';
  static const _firstName = 'name';

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setUsername(String username) async =>
      await _preferences.setString(_keyUsername, username);

  static getUsername() => _preferences.getString(_keyUsername);

  static Future settoken(String token) async =>
      await _preferences.setString(_keytoken, token);

  static gettoken() => _preferences.getString(_keytoken);

  static Future setmobile(String mobile) async =>
      await _preferences.setString(_keymobile, mobile);

  static getmobile() => _preferences.getString(_keymobile);

  static Future setFirstname(String name) async =>
      await _preferences.setString(_firstName, name);

  static getFirstname() => _preferences.getString(_firstName);
}
