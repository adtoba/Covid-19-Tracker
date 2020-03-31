import 'dart:ffi';

import 'package:meta/meta.dart';

class ConfirmedCases {

  ConfirmedCases({
    @required this.provinceState,
    @required this.countryRegion,
    @required this.lastUpdate,
    @required this.lat,
    @required this.long,
    @required this.confirmed,
    @required this.recovered,
    @required this.deaths,
    @required this.active,
    
  });

  final String provinceState;
  final String countryRegion;
  final int lastUpdate;
  final double lat;
  final double long;
  final int confirmed;
  final int recovered;
  final int deaths;
  final int active;


  factory ConfirmedCases.fromJson(Map<String, dynamic> json) {
    return ConfirmedCases(
      provinceState: json['provinceState'],
      countryRegion: json['countryRegion'],
      lastUpdate: json['lastUpdate'],
      lat: json['lat'].toDouble(),
      long: json['long'].toDouble(),
      confirmed: json['confirmed'],
      recovered: json['recovered'],
      deaths: json['deaths'],
      active: json['active']
    );  
  }
}
