import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kapal_api_group_tech_test/feature/album.dart';
import 'package:kapal_api_group_tech_test/feature/info.dart';
import 'package:kapal_api_group_tech_test/feature/location.dart';
import 'package:kapal_api_group_tech_test/model/user.dart';
import 'package:kapal_api_group_tech_test/mysharedpreference.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SharedPreferences? prefs;
  User? user;

  @override
  void initState() {
    super.initState();
    MySharedPreference().getUserData().then((value) => user = value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton.icon(
                icon: Icon(Icons.person),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => InfoPage()),
                  );
                },
                label: Text('Info User'),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton.icon(
                icon: Icon(Icons.photo),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AlbumPage()),
                  );
                },
                label: Text('Album'),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton.icon(
                icon: Icon(Icons.location_pin),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LocationPage()),
                  );
                },
                label: Text('Location'),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
