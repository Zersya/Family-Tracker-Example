import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:trans_trackid_example/repositories/devices_repository.dart';

import 'package:trans_trackid_example/utils/constant.dart';
import 'package:trans_trackid_example/utils/enum.dart';

import '../../mock_response_data.dart';

void main() {
  final dio = Dio();
  final dioAdapter = DioAdapter(dio: dio);

  setUp(() {
    if (!GetIt.I.isRegistered(instance: dio)) {
      GetIt.I.registerSingleton<Dio>(dio);
    }
  });

  group('DevicesRepository', () {
    test('should return a list of devices [success]', () async {
      dioAdapter.onGet(ApiEndPoint.kApiDevices, (server) {
        server.reply(200, jsonDecode(mockedResponseData));
      });

      final devicesRepo = DevicesRepository();
      final result = await devicesRepo.getDevices();

      expect(result.status, ResponseStatus.success);
    });

    test('should return an empty devices [success]', () async {
      dioAdapter.onGet(ApiEndPoint.kApiDevices, (server) {
        server.reply(200, jsonDecode(mockedResponseEmptyData));
      });

      final devicesRepo = DevicesRepository();
      final result = await devicesRepo.getDevices();

      expect(result.status, ResponseStatus.success);
    });

    test('should return an empty devices [failed]', () async {
      dioAdapter.onGet(ApiEndPoint.kApiDevices, (server) {
        server.reply(400, jsonDecode(mockedResponseEmptyData));
      });

      final devicesRepo = DevicesRepository();
      final result = await devicesRepo.getDevices();

      expect(result.status, ResponseStatus.failed);
    });
  });
}
