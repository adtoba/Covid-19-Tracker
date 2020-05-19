import 'dart:convert';

import 'package:covid19/bloc/models/confirmed.dart';
import 'package:covid19/bloc/models/stats.dart';
import 'package:covid19/bloc/services/app_service.dart';
import 'package:covid19/bloc/services/locator.dart';
import 'package:covid19/bloc/viewmodels/base.dart';
import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

const String ERROR_MESSAGE = '😥 Something went wrong. Please try again later!';

class StatsViewModel extends BaseViewModel {
  List<ConfirmedCases> _cases;
  List<ConfirmedCases> get confirmedCases => _cases;

  OperationStatus _confirmedStatStatus;
  OperationStatus get confirmedStatStatus => _confirmedStatStatus;

  OperationStatus _statStatus;
  OperationStatus get statStatus => _statStatus;

  OperationStatus _searchStatus;
  OperationStatus get searchStatus => _searchStatus;

  String _searchMessage;
  String get searchMessage => _searchMessage;

  String _message;
  String get message => _message;

  String _getStatMessage;
  String get getStatMessage => _getStatMessage;

  // Data models
  Stats _stats;
  ConfirmedCases _confirmedCases;

  Stats get stat => _stats;

  Stats _searchStat;
  Stats get searchStat => _searchStat;
  
  void _gettingStats() {
    _statStatus = OperationStatus.LOADING;
    notifyListeners();
  }

  void _getStatFailed({String error = ERROR_MESSAGE}) {
    _statStatus = OperationStatus.FAILED;
    _getStatMessage = error;
    notifyListeners();
  }

  void _getStatSuccessful() {
    _statStatus = OperationStatus.SUCCESSFUL;
    notifyListeners();
  }

  void resetStats() {
    _statStatus = null;
    _getStatMessage = null;
    notifyListeners();
  }



  // Services
  AppService apiService = locator<AppService>();

  Future<void> getStats() async {
    _gettingStats();
    Response _response;
    try {
      _response = await apiService.fetchData();
      _stats = Stats.fromJson(_response.data);

      print(_response.data);

      if(_stats != null) {
        _getStatSuccessful();
      } else {
        _getStatFailed(error: ERROR_MESSAGE);
      }
    } on DioError catch (e) {
      final dynamic data = e.response?.data ?? {};
      _message = data['message'] ?? ERROR_MESSAGE;
      _getStatFailed(error: ERROR_MESSAGE);
    }

  }

  void _gettingConfirmedStats() {
    _confirmedStatStatus = OperationStatus.LOADING;
    notifyListeners();
  }

  void _getConfirmedStatSuccessful() {
    _confirmedStatStatus = OperationStatus.SUCCESSFUL;
    notifyListeners();
  }

  void _getConfirmedStatFailed({String error = ERROR_MESSAGE}){
    _confirmedStatStatus = OperationStatus.FAILED;
    _message = error;
    notifyListeners();
  }

  void resetConfirmedStats() {
    _confirmedStatStatus = null;
    _message = null;
    notifyListeners();
  }



  Future<void> getConfirmedStats() async {
    _gettingConfirmedStats();
    Response response;
    try {
      response = await apiService.confirmedCases();
      final List<dynamic> data = response.data;
      _cases = List<ConfirmedCases>.from(data.map((dynamic cases) => ConfirmedCases.fromJson(cases)));

      if(_cases.isNotEmpty) {
        _getConfirmedStatSuccessful();
      } else {
        _getConfirmedStatFailed();
      }
      
    } on DioError catch (e) {
      final dynamic data = e.response?.data ?? {};
      _message = data['message'] ?? ERROR_MESSAGE;
    }
  }

  void _searching() {
    _searchStatus = OperationStatus.LOADING;
    notifyListeners();
  }

  void _searchSuccessful() {
    _searchStatus = OperationStatus.SUCCESSFUL;
    notifyListeners();
  }

  void _searchFailed({String error = ERROR_MESSAGE}){
    _searchStatus = OperationStatus.FAILED;
    _searchMessage = error;
    notifyListeners();
  }

  void resetSearchStatus() {
    _searchStatus = null;
    _searchMessage = null;
    notifyListeners();
  }



  Future<void> searchCases(String country) async {
    _searching();
    Response response;
    try {
      response = await apiService.searchData(country);
      _searchStat = Stats.fromJson(response.data);

      print(response.toString());
      if(_searchStat != null) {
        _searchSuccessful();
      } else {
        _searchFailed();
      }
      
    } on DioError catch (e) {
      final dynamic data = e.response?.data ?? {};
      _searchMessage = data['message'] ?? ERROR_MESSAGE;
      _searchFailed();
    }
  }


  Future<void> getAllCases() async {
    await getStats();
    await getConfirmedStats();
  }
}
