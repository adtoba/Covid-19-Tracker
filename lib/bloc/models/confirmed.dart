import 'dart:ffi';

import 'package:meta/meta.dart';

class ConfirmedCases {
  ConfirmedCases({
    @required this.provinceState,
    @required this.countryRegion,
    @required this.lastUpdate,
    this.lat,
    this.long,
    @required this.confirmed,
    @required this.recovered,
    @required this.deaths,
    @required this.active,
    
  });

  final String provinceState;
  final String countryRegion;
  final int lastUpdate;
  double lat;
  double long;
  final int confirmed;
  final int recovered;
  final int deaths;
  final int active;


  factory ConfirmedCases.fromJson(Map<String, dynamic> json) {
    return ConfirmedCases(
      provinceState: json['provinceState'],
      countryRegion: json['countryRegion'],
      lastUpdate: json['lastUpdate'],
      lat: json['lat'] != null ? json["lat"].toDouble() : 0.0,
      long: json['long'] != null ? json["long"].toDouble() : 0.0,
      confirmed: json['confirmed'],
      recovered: json['recovered'],
      deaths: json['deaths'],
      active: json['active']
    );  
  }
}
