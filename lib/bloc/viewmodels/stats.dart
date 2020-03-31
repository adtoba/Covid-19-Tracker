import 'dart:convert';

import 'package:covid19/bloc/models/confirmed.dart';
import 'package:covid19/bloc/models/stats.dart';
import 'package:covid19/bloc/services/api_service.dart';
import 'package:covid19/bloc/services/locator.dart';
import 'package:covid19/bloc/viewmodels/base.dart';
import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

const ERROR_MESSAGE = "😥 Something went wrong. Please try again later!";

class StatsViewModel extends BaseViewModel {
  List<ConfirmedCases> _cases = [];

  Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  Position userLocation;
  List<Placemark> _placemark;
  int _currentIndex = 0;

  // Data models
  Stats _stats;
  ConfirmedCases _confirmedCases;

  String _message;
  ViewStatus _confirmedStatus;

  // Getters
  String get message => _message;
  Stats get stat => _stats;
  List<ConfirmedCases> get confirmedCases => _cases;
  List<Placemark> get userPlacemark => _placemark;
  ViewStatus get confirmedStatus => _confirmedStatus;
  int get currentIndex => _currentIndex;

  void setConfirmedStatus(ViewStatus status) {
    _confirmedStatus = status;
    notifyListeners();
  }

  void setCurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  // Services
  ApiService apiService = locator<ApiService>();

  Future<void> getStats() async {
    setStatus(ViewStatus.Loading);
    Response response;
    try {
      _message = 'null';
      response = await apiService.fetchData();
      _stats = Stats.fromJson(response.data);
    } on DioError catch (e) {
      final data = e.response?.data ?? {};
      _message = data['message'] ?? ERROR_MESSAGE;
      setStatus(ViewStatus.Ready);
    }

    setStatus(ViewStatus.Ready);
  }

  Future<void> getConfirmedStats() async {
    // setConfirmedStatus(ViewStatus.Loading);
    setStatus(ViewStatus.Loading);
    Response response;
    try {
      response = await apiService.confirmedCases();
      final List<dynamic> data = response.data;
      print(data);
      _cases = List<ConfirmedCases>.from(
          data.map((cases) => ConfirmedCases.fromJson(cases)));
    } on DioError catch (e) {
      final data = e.response?.data ?? {};
      _message = data['message'] ?? ERROR_MESSAGE;
      // setConfirmedStatus(ViewStatus.Ready);
    }
    setStatus(ViewStatus.Ready);
    // setConfirmedStatus(ViewStatus.Ready);
  }

  Future<void> getAllCases() async {
    await getStats();
    await getConfirmedStats();
  }
}
