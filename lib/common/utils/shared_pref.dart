import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:youtube_app_bloc/common/model/user.dart';

class SharedPref {
  static final String _isFirstTime = "firstTime";
  static final String _user = "user";

  static void setFirstTime(bool status) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(_isFirstTime, status);
  }

  Future<bool> getFirstTime() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final _res = sharedPreferences.getBool(_isFirstTime);
    return _res ?? true;
  }

  static void setUser(User user) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final _encodedData = json.encode(user.toJson());
    sharedPreferences.setString(_user, _encodedData);
  }

  static Future<User?> getUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final _res = sharedPreferences.getString(_user);
    if (_res != null) {
      final _decodedData = Map<String, dynamic>.from(json.decode(_res));
      final _user = User.fromJson(_decodedData);
      return _user;
    } else {
      return null;
    }
  }

  static void removeUser(User user) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.remove(_user);
  }
}
