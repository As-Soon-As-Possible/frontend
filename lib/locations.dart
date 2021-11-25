import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:ibm/victim_page.dart';
import 'http_get_model.dart';
import 'package:ibm/network.dart';

class Location {
  final LatLng coordinates;
  final String name;

  Location(this.coordinates, this.name);
}



List<Location> locations = [
  Location(LatLng(9.931233, 76.267303), "Sandeep"),
  Location(LatLng(9.93123300000, 76.26730300), "Kavya"),
  Location(LatLng( 9.9644000000, 76.2874000), "Alan"),
  Location(LatLng(10.0327000000, 76.331900), "Arjun")
];

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('test'),
      // ),
      body: FutureBuilder<List<Vicmap>>(
        future: VicMapRepository().getVics(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            showDialog(
              context: context,
              builder: (context){return AlertDialog(
                title: Text("Error"),
                content: Text(snapshot.error.toString()),
              );}
            );
          } else if (snapshot.hasData) {
            // final List<Location> locations = snapshot.data;
            // return ListView.builder(
            //   itemCount: snapshot.data.length,
            //   itemBuilder: (context, index) => ListTile(
            //     title: Text(snapshot.data[index].name),
            //     subtitle: Text(
            //       snapshot.data[index].additionalInfo,
            //       softWrap: false,
            //       overflow: TextOverflow.ellipsis,
            //     ),
            //   ),
            // );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}