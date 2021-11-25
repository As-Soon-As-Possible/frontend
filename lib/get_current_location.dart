import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:ibm/locations.dart';
import 'package:ibm/map_marker.dart';
import 'package:ibm/victim_page.dart';
import 'package:location/location.dart' as Location;
import 'package:geocoder/geocoder.dart';
import 'package:intl/intl.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'marker_generator.dart';


class MyLocation extends StatefulWidget {
  static final String id = 'my_location';
  const MyLocation({Key key}) : super(key: key);

  @override
  _MyLocationState createState() => _MyLocationState();
}


class _MyLocationState extends State<MyLocation> {

  BitmapDescriptor sourceIcon;
  BitmapDescriptor destinationIcon;

  List<MapMarker> mapMarkers = [];
  List<Marker> customMarkers = [];
  List<Marker> mapBitmapsToMarkers(List<Uint8List> bitmaps) {
    bitmaps.asMap().forEach((i, bmp) {
      customMarkers.add(Marker(
        markerId: MarkerId("$i"),
        position: locations[i].coordinates,
        icon: BitmapDescriptor.fromBytes(bmp),
      ));
    });
  }


  Location.LocationData _currentPosition;
  String _address,_dateTime;
  GoogleMapController mapController;
  Marker marker;
  Location.Location location = Location.Location();

  GoogleMapController _controller;
  Marker _origin;
  Marker _destination;
  LatLng _initialcameraposition = LatLng(0.5937, 0.9629);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLoc();
    MarkerGenerator(markerWidgets(), (bitmaps) {
      setState(() {
        mapBitmapsToMarkers(bitmaps);
      });
    }).generate(context);

  }

  void _onMapCreated(GoogleMapController _cntlr)
  {
    _controller = _cntlr;
    location.onLocationChanged.listen((l) {
      _controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(l.latitude, l.longitude),zoom: 10),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height:  MediaQuery.of(context).size.height/1.19,
                  width: MediaQuery.of(context).size.width,
                  child:GoogleMap(

                    // markers: {
                    //   if(_origin!=null) _origin,
                    //   if(_destination!=null) _destination,
                    //
                    // },
                    // onLongPress: _addMarker,
                    markers: customMarkers.toSet(),
                    myLocationButtonEnabled: true,
                    // zoomControlsEnabled: false,
                    initialCameraPosition: CameraPosition(target: _initialcameraposition),
                    mapType: MapType.normal,
                    onMapCreated: _onMapCreated,


                    myLocationEnabled: true,
                  ),
                ),
                // SizedBox(
                //   height: 3,
                // ),
                // if (_dateTime != null)
                //   Text(
                //     "Date/Time: $_dateTime",
                //     style: TextStyle(
                //       fontSize: 15,
                //       color: Colors.white,
                //     ),
                //   ),

                // SizedBox(
                //   height: 3,
                // ),

                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: Colors.blueGrey.withOpacity(.8),
                      // border: Border.all(
                      //     color: Colors.green,
                          // width: 2.0
                      // ),
                    ),
                    // color:
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 8.0),
                      child: Column(
                        children: [
                          if (_currentPosition != null)
                            Text(
                              "Latitude: ${_currentPosition.latitude}, Longitude: ${_currentPosition.longitude}",
                              style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          if (_address != null)
                            Text(
                              "Address: $_address",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                Padding(
                  padding:  EdgeInsets.only(bottom: 8.0,top: 5),
                  child: Container(
                    width: 400.0,
                    child: FloatingActionButton.extended(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return VictimMap();
                            },
                          ),
                        );
                      },
                      icon: Icon(Icons.account_circle),
                      label: Text("Find nearest victim"),
                    ),
                  ),
                ),
                // SizedBox(
                //   height: 3,
                // ),

                // SizedBox(
                //   height: 3,
                // ),
              ],
            ),
          ),
        ),
      ),

    );
  }


  getLoc() async{
    bool _serviceEnabled;
    Location.PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == Location.PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != Location.PermissionStatus.granted) {
        return;
      }
    }

    _currentPosition = await location.getLocation();
    _initialcameraposition = LatLng(_currentPosition.latitude,_currentPosition.longitude);
    location.onLocationChanged.listen((Location.LocationData currentLocation) {
      print("${currentLocation.longitude} : ${currentLocation.longitude}");
      setState(() {
        _currentPosition = currentLocation;
        _initialcameraposition = LatLng(_currentPosition.latitude,_currentPosition.longitude);

        DateTime now = DateTime.now();
        _dateTime = DateFormat('EEE d MMM kk:mm:ss ').format(now);
        _getAddress(_currentPosition.latitude, _currentPosition.longitude)
            .then((value) {
          setState(() {
            _address = "${value.first.addressLine}";
          });
        });
      });
    });
  }


  Future<List<Address>> _getAddress(double lat, double lang) async {
    final coordinates = new Coordinates(lat, lang);
    List<Address> add =
    await Geocoder.local.findAddressesFromCoordinates(coordinates);
    return add;
  }

  List<Widget> markerWidgets() {
    return locations.map((l) => MapMarker(l)).toList();
  }

  void _addMarker(LatLng pos)
  {
    if(_origin==null || (_origin != null && _destination != null))
      {
        setState(() {
          _origin = Marker(
            markerId: const MarkerId('origin'),
            infoWindow: const InfoWindow(title: 'Origin'),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
            position: pos,
          );
          _destination = null;
        });
      }else
        {

          setState(() {
            _destination = Marker(
              markerId: const MarkerId('destination'),
              infoWindow: const InfoWindow(title: 'Destination'),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
              position: pos,
            );
            // _destination = null;
          });

        }
  }
}