import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ibm/Screens/Login/login_screen.dart';
import 'package:ibm/Screens/Registration/signup_screen.dart';
import 'get_current_location.dart';
import 'package:ibm/Victim Page.dart';

// void main() => runApp(const MyApp());


import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';


// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: MyLocation(),
//     );
//   }
// }
//
//
// void main() {
//   runApp(MyApp());
// }
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ASAP',
      debugShowCheckedModeBanner: false,
      initialRoute: LoginScreen.id,
      routes: {
        MyLocation.id:(context) => MyLocation(),
        SignUpScreen.id:(context) => SignUpScreen(),
        LoginScreen.id:(context) => LoginScreen(),


      },
    );
  }
}
