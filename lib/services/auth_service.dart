import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  late String _token;
  late String _userId;
  late String _fcmToken;
  String get token => _token;
  String get userId => _userId;
  String get fcmToken => _fcmToken;

  void setFcmToken(String token) {
    this._fcmToken = token;
  }

  Future<void> getTokenAndUserId() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    this._token = sharedPreferences.getString("token")!;
    this._userId = sharedPreferences.getString("userId")!;
    log("SharedPreference token: $token, user id: $userId");
  }

  Future<void> setToken(String token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString("token", token);
    this._token = token;
  }

  Future<void> setUserId(String userId) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString("userId", userId);
    this._userId = userId;
  }

  void removeTokenAndUserId() {
    _token = "";
    _userId = "";
    _fcmToken = "";
  }

  Future<void> clearSharedPreferencesData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
  }
}
