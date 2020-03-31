import 'dart:io';
import 'package:dio/dio.dart';


const BASE_URL = 'https://covid19.mathdro.id/api';


class ApiService {

  Dio apiClient = Dio();

  // Base url
  static const BASE_URL = "https://covid19.mathdro.id/api";
  
  Future<Response> fetchData() async {
    return apiClient.get('$BASE_URL');
  }

  Future<Response> confirmedCases() async {
    return apiClient.get('$BASE_URL/confirmed');
  }

  Future<Response> recoveredCases() async {
    return apiClient.get('$BASE_URL/recovered');
  }

}