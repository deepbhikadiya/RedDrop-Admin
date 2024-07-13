import 'package:shared_preferences/shared_preferences.dart';

class AppPref {
  //region AppPref setup
  Future? _isPreferenceInstanceReady;
  late SharedPreferences _preferences;

  static final AppPref _instance = AppPref._internal();

  factory AppPref() => _instance;

  AppPref._internal() {
    _isPreferenceInstanceReady = SharedPreferences.getInstance()
        .then((preferences) => _preferences = preferences);
  }

  Future? get isPreferenceReady => _isPreferenceInstanceReady;

  //endregion setup

  /// to find user token
  String get token => _preferences.getString('token') ?? '';

  set token(String value) => _preferences.setString('token', value);

  String get username => _preferences.getString('username') ?? '';

  set username(String value) => _preferences.setString('username', value);

  /// retrieve app current language
  String get languageCode => _preferences.getString('languageCode') ?? '';

  set languageCode(String value) =>
      _preferences.setString('languageCode', value);


  String get verificationId => _preferences.getString('verificationId') ?? '';

  set verificationId(String value) => _preferences.setString('verificationId', value);

  bool? get isLogin => _preferences.getBool('isLogin');

  set isLogin(bool? value) => _preferences.setBool('isLogin', value ?? false);



  bool? get isAdmin => _preferences.getBool('isAdmin');

  set isAdmin(bool? value) => _preferences.setBool('isAdmin', value ?? false);
  /// retrieve app mode light/dark
  bool? get isDark => _preferences.getBool('isDark');

  set isDark(bool? value) => _preferences.setBool('isDark', value ?? false);

  void clear() async {
    _preferences.remove("isBiometricEnable");
    _preferences.remove("isLogin");
    _preferences.remove("token");
    _preferences.remove("fcmToken");
    _preferences.remove("isGuest");
    _preferences.remove("loginUser");
  }
}
