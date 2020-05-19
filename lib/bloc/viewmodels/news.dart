import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';
import 'package:covid19/bloc/viewmodels/base.dart';
import 'package:covid19/bloc/services/app_service.dart';
import 'package:covid19/bloc/services/locator.dart';
import 'package:dio/dio.dart';
import 'package:covid19/models/news.dart';


class NewsViewModel extends ChangeNotifier {
  
  OperationStatus _newsStatus; 
  String _message;
  NewsModel _newsModel;
  List<NewsModel> _newsList;

  OperationStatus get newsStatus => _newsStatus;
  String get message => _message;
  NewsModel get newsModel => _newsModel;
  List<NewsModel> get newsList => _newsList;

  final AppService _appService = locator<AppService>();

  void _fetchingNews() {
    _newsStatus = OperationStatus.LOADING;
    notifyListeners();
  }

  void _fetchSuccessful() {
    _newsStatus = OperationStatus.SUCCESSFUL;
    notifyListeners();
  }

  void _fetchFailed({String errorMessage = 'FAILED TO GET NEWS UPDATES'}) {
    _newsStatus = OperationStatus.FAILED;
    _message = errorMessage;
    notifyListeners();
  }

  void resetNewsStatus() {
    _newsStatus = null;
    _message = null;
    notifyListeners();
  }

  Future<void> newsUpdates(String date, String page) async {
    _fetchingNews();
    Response _response;
    int _page = int.parse(page);

    try {

      if(_page >= 9) {
        _page = 1;
      }
      _response = await _appService.newsUpdates(date, _page.toString());
      final List<dynamic> dynamicData = _response.data['articles'];

      print(_response.statusCode);
      print(dynamicData);

      _newsList = List<NewsModel>.from(dynamicData.map((dynamic e) => NewsModel.fromJson(e)));

      if(_response.statusCode >= 200 && _response.statusCode <=300) {
        _fetchSuccessful();
        notifyListeners();
      } else {
        _fetchFailed();
      }
    } on DioError catch (e) {
      _fetchFailed();
      print('${e.response}');
    }

    notifyListeners();
  }
}