import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:trans_trackid_example/models/base_response.dart';
import 'package:trans_trackid_example/models/device.dart';
import 'package:trans_trackid_example/repositories/devices_repository.dart';

import 'package:trans_trackid_example/utils/constant.dart';

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
    test('should return a list of devices', () async {
      dioAdapter.onGet(ApiEndPoint.kApiDevices, (server) {
        server.reply(200, mockedResponseData);
      });

      final devicesRepo = DevicesRepository();
      final result = await devicesRepo.getDevices();

      expect(result, isA<BaseResponse<List<Device>>>());
    });

    test('should return an empty devices', () async {
      dioAdapter.onGet(ApiEndPoint.kApiDevices, (server) {
        server.reply(200, mockedResponseEmptyData);
      });

      final devicesRepo = DevicesRepository();
      final result = await devicesRepo.getDevices();

      expect(result, isA<BaseResponse<List<Device>>>());
    });
  });
}
