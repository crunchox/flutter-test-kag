import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kapal_api_group_tech_test/home.dart';
import 'package:kapal_api_group_tech_test/model/user.dart';
import 'package:kapal_api_group_tech_test/myapiservice.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter your email';
                  }
                  _email = value ?? "";
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
                obscureText: true,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter your password';
                  }
                  _password = value ?? "";
                  return null;
                },
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState?.validate() ?? true) {
                      if (await checkUser()) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('User not found or incorrect password'),
                        ));
                      }
                    }
                  },
                  child: Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> checkUser() async {
    var listUsers = await MyApiService().getUser();
    //Sincere@april.biz
    //Gwenborough
    if (listUsers != null) {
      // cari user
      try {
        User user = listUsers.firstWhere((user) => user.email == _email);
        if (user.address.city != _password) {
          return false;
        }
        saveUser(user);
        return true;
      } catch (e) {
        return false;
      }
    } else {
      return false;
    }
  }

  Future<void> saveUser(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userJson = jsonEncode(user.toJson());
    prefs.setString('user', userJson);
  }
}
