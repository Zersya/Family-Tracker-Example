// ignore_for_file: lines_longer_than_80_chars

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:trans_trackid_example/models/base_response.dart';
import 'package:trans_trackid_example/models/meta.dart';
import 'package:trans_trackid_example/utils/typedef.dart';

/// Base class for all the requests
class ApiServices {
  /// GET the data with the given parameters
  /// it can handle any of pre request that will always require for example
  /// get token from secure storage or get the logged in user id
  Future<ResponseOfRequestMap> get(String api,
      {MapString? queryParameters, MapString? headers}) async {
    final _dio = GetIt.I<Dio>();
    try {
      final currentHeaders = <String, dynamic>{};

      if (headers != null) {
        currentHeaders.addAll(headers);
      }

      /// Example of adding token to header
      // if (token != null) {
      //   currentHeaders['Authorization'] = 'Bearer $token';
      // }

      final response = await _dio.get<MapString>(
        api,
        queryParameters: queryParameters,
        options: Options(headers: currentHeaders),
      );

      final map = response.data!;

      return ResponseOfRequest(
        data: response.data,
        statusCode: response.statusCode,
        meta: Meta.fromJson(map),
      );
    } on DioError catch (e) {
      final response =
          e.response != null ? e.response?.data as MapString : null;

      return ResponseOfRequest(
        statusCode: e.response?.statusCode ?? -1,
        message: e.message,
        data: response,
      );
    }
  }

  // /// POST the data with the given parameters
  // /// it can handle any of pre request that will always require for example
  // /// get token from secure storage or get the logged in user id
  // Future<ResponseOfRequestMap> post(String api,
  //     {MapString? data, MapString? queryParameters, MapString? headers}) async {
  //   try {
  //     final currentHeaders = <String, dynamic>{};

  //     if (headers != null) {
  //       currentHeaders.addAll(headers);
  //     }

  //     /// Example of adding token to header
  //     // if (token != null) {
  //     //   currentHeaders['Authorization'] = 'Bearer $token';
  //     // }

  //     final response = await _dio.post<MapString>(
  //       api,
  //       data: data,
  //       queryParameters: queryParameters,
  //       options: Options(headers: currentHeaders),
  //     );

  //     final hasMessage = response.data?.containsKey('message') ?? false;

  //     return ResponseOfRequest(
  //       data: response.data,
  //       statusCode: response.statusCode,
  //       message: hasMessage ? response.data!['message'] as String : null,
  //     );
  //   } on DioError catch (e) {
  //     final response =
  //         e.response != null ? e.response?.data as MapString : null;

  //     return ResponseOfRequest(
  //       statusCode: e.response?.statusCode ?? -1,
  //       message: e.message,
  //       data: response,
  //     );
  //   }
  // }

  // /// PUT the data with the given parameters
  // /// it can handle any of pre request that will always require for example
  // /// get token from secure storage or get the logged in user id
  // Future<ResponseOfRequestMap> put(String api,
  //     {MapString? data, MapString? queryParameters, MapString? headers}) async {
  //   try {
  //     final currentHeaders = <String, dynamic>{};

  //     if (headers != null) {
  //       currentHeaders.addAll(headers);
  //     }

  //     /// Example of adding token to header
  //     // if (token != null) {
  //     //   currentHeaders['Authorization'] = 'Bearer $token';
  //     // }

  //     final response = await _dio.put<MapString>(
  //       api,
  //       data: data,
  //       queryParameters: queryParameters,
  //       options: Options(headers: currentHeaders),
  //     );

  //     final hasMessage = response.data?.containsKey('message') ?? false;

  //     return ResponseOfRequest(
  //       data: response.data,
  //       statusCode: response.statusCode,
  //       message: hasMessage ? response.data!['message'] as String : null,
  //     );
  //   } on DioError catch (e) {
  //     final response =
  //         e.response != null ? e.response?.data as MapString : null;

  //     return ResponseOfRequest(
  //       statusCode: e.response?.statusCode ?? -1,
  //       message: e.message,
  //       data: response,
  //     );
  //   }
  // }

  // /// DELETE the data with the given parameters
  // /// it can handle any of pre request that will always require for example
  // /// get token from secure storage or get the logged in user id
  // Future<ResponseOfRequestMap> delete(String api, {MapString? headers}) async {
  //   try {
  //     final currentHeaders = <String, dynamic>{};

  //     if (headers != null) {
  //       currentHeaders.addAll(headers);
  //     }

  //     /// Example of adding token to header
  //     // if (token != null) {
  //     //   currentHeaders['Authorization'] = 'Bearer $token';
  //     // }

  //     final response = await _dio.delete<MapString>(
  //       api,
  //       options: Options(headers: currentHeaders),
  //     );

  //     final hasMessage = response.data?.containsKey('message') ?? false;

  //     return ResponseOfRequest(
  //       data: response.data,
  //       statusCode: response.statusCode,
  //       message: hasMessage ? response.data!['message'] as String : null,
  //     );
  //   } on DioError catch (e) {
  //     final response =
  //         e.response != null ? e.response?.data as MapString : null;

  //     return ResponseOfRequest(
  //       statusCode: e.response?.statusCode ?? -1,
  //       message: e.message,
  //       data: response,
  //     );
  //   }
  // }
}
