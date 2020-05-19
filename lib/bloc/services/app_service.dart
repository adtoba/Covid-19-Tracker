import 'dart:io';
import 'package:covid19/bloc/services/api_service.dart';
import 'package:covid19/bloc/services/locator.dart';
import 'package:dio/dio.dart';


const String BASE_URL = 'https://covid19.mathdro.id/api';



class AppService {
  AppService() : apiClient = _apiService.client;

  Dio apiClient;
  static final ApiService _apiService = locator<ApiService>();

  Dio client = Dio();



  Future<Response> fetchData() async {
    String url = '';
    return apiClient.get(url);
  }

  Future<Response> confirmedCases() async {
    String url = '/confirmed';
    return apiClient.get(url);
  }

  Future<Response> recoveredCases() async {
    String url = '/recovered';
    return apiClient.get(url);
  }

  Future<Response> searchData(String country) async {
    String url = '/countries/$country';
    return apiClient.get(url);
  }

  Future<Response> newsUpdates(String date, String page) async {
    // date format - 2020-05-31
    // page - integer 
    final String url = 'https://newsapi.org/v2/everything?q=COVID&from=&sortBy=publishedAt&apiKey=43e27de4326341ceb417d029ea5ff5fd&pageSize=10&page=$page';
    return client.get(url);
  }

}