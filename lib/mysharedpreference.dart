import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'model/user.dart';
class MySharedPreference {
  Future<User?> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userJson = prefs?.getString('user');
    if (userJson != null) {
      Map<String, dynamic> userMap = jsonDecode(userJson);
      User user = User.fromJson(userMap);
      return user;
    } else {
      return null;
    }
  }
}