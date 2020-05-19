import 'package:covid19/bloc/services/app_service.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';


class ApiService {

  ApiService() {
    client = Dio();
    client.options.baseUrl = BASE_URL;
  }
   Dio client;
}