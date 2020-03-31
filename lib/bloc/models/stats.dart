import 'package:meta/meta.dart';


class Stats {

  Stats({
    this.confirmed,
    this.recovered,
    this.deaths,
    this.lastUpdated,
    this.imageUrl
  });

  Confirmed confirmed;
  Recovered recovered;
  Deaths deaths;
  final String lastUpdated;
  final String imageUrl;


  factory Stats.fromJson(Map<String, dynamic> json) {
    return Stats(
      confirmed: Confirmed.fromJson(json['confirmed']),
      recovered: Recovered.fromJson(json['recovered']),
      deaths: Deaths.fromJson(json['deaths']),
      lastUpdated: json['lastUpdate'],
      imageUrl: json['image']
    );
  }

}

class Confirmed {
  Confirmed({
    this.value,
    this.detail
  });

  final int value;
  final String detail;

  factory Confirmed.fromJson(Map<String, dynamic> json) {
    return Confirmed(
      value : json['value'],
      detail: json['detail']
    );
  }


}

class Recovered {
  Recovered({
    this.value,
    this.detail
  });

  final int value;
  final String detail;
  
  factory Recovered.fromJson(Map<String, dynamic> json) {
    return Recovered(
      value : json['value'],
      detail: json['detail']
    );
  }


}

class Deaths {
  Deaths({
    this.value,
    this.detail
  });

  final int value;
  final String detail;
  
  factory Deaths.fromJson(Map<String, dynamic> json) {
    return Deaths(
      value : json['value'],
      detail: json['detail']
    );
  }


}

