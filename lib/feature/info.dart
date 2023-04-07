import 'package:flutter/material.dart';
import 'package:kapal_api_group_tech_test/model/address.dart';
import 'package:kapal_api_group_tech_test/model/company.dart';
import 'package:kapal_api_group_tech_test/model/geo.dart';
import 'package:kapal_api_group_tech_test/model/user.dart';
import 'package:kapal_api_group_tech_test/mysharedpreference.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InfoPage extends StatefulWidget {
  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  late String name = "",
      username = "",
      email = "",
      street = "",
      suite = "",
      city = "",
      zipcode = "",
      lat = "",
      lng = "",
      phone = "",
      website = "",
      companyName = "",
      catchPhrase = "",
      bs = "";
  late Address address;
  late Geo geo;
  late Company company;

  @override
  void initState() {
    super.initState();
    MySharedPreference().getUserData().then((value) => setInfoData(value));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Info Page'),
      ),
      body: SafeArea(
        child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Container(
              width: double.infinity,
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("$name ($username)"),
                      Text("$email"),
                      Text("$street, $suite, $city"),
                      Text("$zipcode"),
                      Text("$phone"),
                      Text("$website"),
                      SizedBox(height: 8,),
                      Text("$companyName ($catchPhrase)"),
                    ],
                  ),
                ),
              ),
            )),
      ),
    );
  }

  void setInfoData(User? user) {
    setState(() {
      name = user?.name ?? "";
      username = user?.username ?? "";
      email = user?.email ?? "";
      street = user?.address.street ?? "";
      city = user?.address.city ?? "";
      suite = user?.address.suite ?? "";
      zipcode = user?.address.zipcode ?? "";
      phone = user?.phone ?? "";
      website = user?.website ?? "";
      companyName = user?.company.name ?? "";
      bs = user?.company.bs ?? "";
      catchPhrase = user?.company.catchPhrase ?? "";
    });
  }
}
