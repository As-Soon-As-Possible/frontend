// To parse this JSON data, do
//
//     final vicmap = vicmapFromJson(jsonString);

import 'dart:convert';

List<Vicmap> vicmapFromJson(String str) => List<Vicmap>.from(json.decode(str).map((x) => Vicmap.fromJson(x)));

String vicmapToJson(List<Vicmap> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Vicmap {
  Vicmap({
    this.name,
    this.mobileNo,
    this.location,
    this.latitude,
    this.longitude,
    this.additionalInfo,
  });

  String name;
  String mobileNo;
  String location;
  String latitude;
  String longitude;
  String additionalInfo;

  factory Vicmap.fromJson(Map<String, dynamic> json) => Vicmap(
    name: json["name"],
    mobileNo: json["mobile_no"],
    location: json["location"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    additionalInfo: json["additional_info"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "mobile_no": mobileNo,
    "location": location,
    "latitude": latitude,
    "longitude": longitude,
    "additional_info": additionalInfo,
  };
}
