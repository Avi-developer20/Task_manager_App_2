import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:untitled/Data/Models/user_model.dart';

class AuthController {
  static UserModel? userModel;
  static String? accessToken;

  static const String _userDataKey = 'user_data';
  static const String _tokenKey = 'token';

  /// Save user data and token to SharedPreferences
  static Future<void> saveUserData(UserModel model, String token) async {
    SharedPreferences sharePreference = await SharedPreferences.getInstance();
    await sharePreference.setString(_userDataKey, jsonEncode(model.toJson()));
    await sharePreference.setString(_tokenKey, token);
    userModel = model;
    accessToken = token;
  }

  /// Update user model and token
  static Future<void> updateUserData(UserModel model, String token) async {
    SharedPreferences sharePreference = await SharedPreferences.getInstance();
    await sharePreference.setString(_userDataKey, jsonEncode(model.toJson()));
    await sharePreference.setString(_tokenKey, token);
    userModel = model;
    accessToken = token;
  }

  /// Get user data from SharedPreferences
  static Future<bool> getUserData() async {
    SharedPreferences sharePreference = await SharedPreferences.getInstance();
    String? userJson = sharePreference.getString(_userDataKey);
    String? token = sharePreference.getString(_tokenKey);

    if (userJson != null && token != null) {
      try {
        userModel = UserModel.fromJson(jsonDecode(userJson));
        accessToken = token;
        return true;
      } catch (e) {
        return false; // JSON parsing failed
      }
    }
    return false;
  }

  /// Check if user is logged in
  static Future<bool> isLoggedIn() async {
    return await getUserData();
  }

  /// Clear all saved data (logout)
  static Future<void> clearData() async {
    SharedPreferences sharePreference = await SharedPreferences.getInstance();
    await sharePreference.clear();
    accessToken = null;
    userModel = null;
  }
}
