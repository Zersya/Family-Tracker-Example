import 'package:dio/dio.dart';
import 'package:trans_trackid_example/utils/constant.dart';
import 'package:trans_trackid_example/utils/get_it.dart';

/// Handle initial app launching
/// It will handle the following:
/// - Initial Dependencies Injection
/// - Setup DIO http client
class MainRepository {
  /// Called when the app is launched on splash screen
  void initialize() {
    final dio = _setupDio('id');
    initializeDI(dio);
  }

  Dio _setupDio(String lang) {
    final headers = {
      'accept': 'application/json',
      'X-Localization': lang,
    };
    final options = BaseOptions(
      baseUrl: kBaseUrl,
      connectTimeout: 8000,
      receiveTimeout: 8000,
      sendTimeout: 8000,
      headers: headers,
    );

    final dio = Dio(options);

    dio.interceptors.add(LogInterceptor(responseBody: true));

    return dio;
  }
}
