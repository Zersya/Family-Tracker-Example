import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

/// Container for DI
void initializeDI(Dio dio) {
  GetIt.I.registerSingleton<Dio>(dio);
}
