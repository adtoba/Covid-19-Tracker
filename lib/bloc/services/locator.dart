import 'package:covid19/bloc/services/api_service.dart';
import 'package:covid19/bloc/services/app_service.dart';
import 'package:get_it/get_it.dart';


GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => AppService());
  locator.registerLazySingleton(() => ApiService());
}