import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:convert';

const jsonData = '{ "location": "123123213", "city": "Kochi" , "state":"Kerala", "Latitude":"37.773972" ,"Longitude":"122.431297" }';

class Victim {
String location;
String city;
String state;
String latitude;
String longitude;

Victim({this.location, this.city, this.state, this.latitude, this.longitude});

Victim.fromJson(Map<String, dynamic> json) {
location = json['location'];
city = json['city'];
state = json['state'];
latitude = json['Latitude'];
longitude = json['Longitude'];
}

Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['location'] = this.location;
  data['city'] = this.city;
  data['state'] = this.state;
  data['Latitude'] = this.latitude;
  data['Longitude'] = this.longitude;
  return data;
}
}


class VictimMap extends StatefulWidget {
  static final String id = 'victim_map';
  const VictimMap({Key key}) : super(key: key);

  @override
  _VictimMapState createState() => _VictimMapState();
}

class _VictimMapState extends State<VictimMap> {
  static const _initialCameraPosition = CameraPosition(
    target: LatLng(37.773972, -122.431297),
    zoom: 11.5,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
            height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,

        // decoration: BoxDecoration(
      //     borderRadius: BorderRadius.circular(15.0),
      //     border: Border.all(
      //         color: Colors.green,
      //         width: 2.0
      //     ),
          child: GoogleMap(
      //     myLocationButtonEnabled: false,
      //     zoomControlsEnabled: false,
      //     initialCameraPosition: _initialCameraPosition,
      //   ),
      // ),
          ),
      ),
    );
  }
}
