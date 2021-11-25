import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Victim> fetchVictim() async {
  final response = await http
      .get(Uri.parse('http://127.0.0.1:8000/api/findVictim'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Victim.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class Victim {
  String name;
  String mobileNo;
  String location;
  String latitude;
  String longitude;
  String additionalInfo;

  Victim(
      {this.name,
        this.mobileNo,
        this.location,
        this.latitude,
        this.longitude,
        this.additionalInfo});

  Victim.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    mobileNo = json['mobile_no'];
    location = json['location'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    additionalInfo = json['additional_info'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['mobile_no'] = this.mobileNo;
    data['location'] = this.location;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['additional_info'] = this.additionalInfo;
    return data;
  }
}


class VictimMap extends StatefulWidget {
  static final String id = 'victom_map';
  const VictimMap({Key key}) : super(key: key);

  @override
  _VictimMapState createState() => _VictimMapState();
}

class _VictimMapState extends State<VictimMap> {
  Future<Victim> futureVictim;
  static const _initialCameraPosition = CameraPosition(
    target: LatLng(37.773972, -122.431297),
    zoom: 11.5,
  );

  @override
  void initState() {
    super.initState();
    futureVictim = fetchVictim();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(
                        color: Colors.green,
                        width: 2.0
                    )),
                width: 300.0,
                height: 400.0,
                child: GoogleMap(
                  myLocationButtonEnabled: false,
                  zoomControlsEnabled: false,
                  initialCameraPosition: _initialCameraPosition,
                ),
              ),
              FutureBuilder<Victim>(
                future: futureVictim,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(snapshot.data.name);
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }

                  // By default, show a loading spinner.
                  return const CircularProgressIndicator();
                },
              ),
            ],
          ),
        ) //SizedBox
    );
  }
}