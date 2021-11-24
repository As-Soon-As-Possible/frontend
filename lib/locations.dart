import 'package:google_maps_flutter/google_maps_flutter.dart';

class Location {
  final LatLng coordinates;
  final String name;

  Location(this.coordinates, this.name);
}

List<Location> locations = [
  Location(LatLng(10.0153513738, 76.3645675), "KFC"),
  Location(LatLng(10.0274696, 76.3313293), "McDonald's"),
  Location(LatLng( 8.488204052, 76.95222365), "Subway"),
  Location(LatLng(12.68635, 74.9039), "Starbucks")
];
