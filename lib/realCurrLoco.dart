// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';
// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:location/location.dart';
// import 'package:geocoder/geocoder.dart';
// import 'package:intl/intl.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//
//
//   LocationData _currentPosition;
//   String _address,_dateTime;
//   GoogleMapController mapController;
//   Marker marker;
//   LatLng _initialcameraposition = LatLng(20.5937, 78.9629);
//   GoogleMapController _controller;
//   Location _location = Location();
//
//     @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     getLoc();
//
//   }
//
//
//   void _onMapCreated(GoogleMapController _cntlr)
//   {
//     _controller = _cntlr;
//     _location.onLocationChanged.listen((l) {
//       _controller.animateCamera(
//         CameraUpdate.newCameraPosition(
//           CameraPosition(target: LatLng(l.latitude, l.longitude),zoom: 10),
//         ),
//       );
//
//     });
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     if (_currentPosition != null){
//       print("hiiiii");
//       // print("Latitude: ${_currentPosition.latitude}");
//
//     }
//     Future<List<Address>> _getAddress(double lat, double lang) async {
//       final coordinates = new Coordinates(lat, lang);
//       List<Address> add =
//       await Geocoder.local.findAddressesFromCoordinates(coordinates);
//       return add;
//     }
//     getLoc() async{
//       bool _serviceEnabled;
//       PermissionStatus _permissionGranted;
//
//       _serviceEnabled = await _location.serviceEnabled();
//       if (!_serviceEnabled) {
//         _serviceEnabled = await _location.requestService();
//         if (!_serviceEnabled) {
//           return;
//         }
//       }
//
//       _permissionGranted = await _location.hasPermission();
//       if (_permissionGranted == PermissionStatus.denied) {
//         _permissionGranted = await _location.requestPermission();
//         if (_permissionGranted != PermissionStatus.granted) {
//           return;
//         }
//       }
//
//       _currentPosition = await _location.getLocation();
//       _initialcameraposition = LatLng(_currentPosition.latitude,_currentPosition.longitude);
//       _location.onLocationChanged.listen((LocationData currentLocation) {
//         print("${currentLocation.longitude} : ${currentLocation.longitude}");
//         setState(() {
//           _currentPosition = currentLocation;
//           _initialcameraposition = LatLng(_currentPosition.latitude,_currentPosition.longitude);
//
//           DateTime now = DateTime.now();
//           _dateTime = DateFormat('EEE d MMM kk:mm:ss ').format(now);
//           _getAddress(_currentPosition.latitude, _currentPosition.longitude)
//               .then((value) {
//             setState(() {
//               _address = "${value.first.addressLine}";
//             });
//           });
//         });
//       });
//     }
//
//     return Scaffold(
//       body: Container(
//         height: MediaQuery.of(context).size.height,
//         width: MediaQuery.of(context).size.width,
//         child: Stack(
//           children: [
//             GoogleMap(
//               initialCameraPosition: CameraPosition(target: _initialcameraposition),
//               mapType: MapType.normal,
//               onMapCreated: _onMapCreated,
//
//               myLocationEnabled: true,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
