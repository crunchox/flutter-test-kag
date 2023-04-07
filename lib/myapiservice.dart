import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kapal_api_group_tech_test/model/photo.dart';

import 'model/user.dart';
class MyApiService {
  Future<List<User>?> getUser() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

    if (response.statusCode == 200) {
      print(response.body);
      List<dynamic> jsonResponse = jsonDecode(response.body);
      List<User> listUser = jsonResponse.map((json) => User.fromJson(json)).toList();
      return listUser;
    } else {
      print('Failed to load data: ${response.statusCode}');
    }
    return null;
  }

  Future<List<Photo>?> getPhoto() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));

    if (response.statusCode == 200) {
      print(response.body);
      List<dynamic> jsonResponse = jsonDecode(response.body);
      List<Photo> listPhoto = jsonResponse.map((json) => Photo.fromJson(json)).toList();
      return listPhoto;
    } else {
      print('Failed to load data: ${response.statusCode}');
    }
    return null;
  }
}