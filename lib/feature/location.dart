import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kapal_api_group_tech_test/mysharedpreference.dart';
import 'package:location/location.dart';

class LocationPage extends StatefulWidget {
  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  // LatLng position = LatLng(-37.3159, 81.1496);
  late LatLng position;
  bool showMap = false;

//"lat": "-37.3159",
//"lng": "81.1496"

  //lat": "-43.9509",
  //"lng": "-34.4618"
  @override
  void initState() {
    super.initState();
    checkPermission();
    MySharedPreference().getUserData().then((value) {
      setState(() {
        showMap = true;
        position = LatLng(double.parse(value?.address?.geo.lat ?? "0"),
            double.parse(value?.address?.geo.lng ?? "0"));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Location Page'),
        ),
        body: showMap
            ? GoogleMap(
                myLocationEnabled: true,
                initialCameraPosition: CameraPosition(
                  target: position,
                  zoom: 14.0,
                ),
                markers: {
                    Marker(
                      markerId: MarkerId(position.toString()),
                      position: position,
                      infoWindow: InfoWindow(
                        title: '$position',
                      ),
                    ),
                  })
            : null);
  }

  Future<void> checkPermission() async {
    var location = Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
  }
}
