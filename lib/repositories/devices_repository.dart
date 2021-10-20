import 'package:trans_trackid_example/models/base_response.dart';
import 'package:trans_trackid_example/models/device.dart';
import 'package:trans_trackid_example/services/api_services.dart';
import 'package:trans_trackid_example/utils/constant.dart';
import 'package:trans_trackid_example/utils/typedef.dart';

/// Handle API request for devices
class DevicesRepository extends ApiServices {
  /// Get List of devices from server
  Future<BaseResponse<List<Device>>> getDevices() async {
    final response = await get(ApiEndPoint.kApiDevices);

    if (response.statusCode == 200) {
      final devices = List<MapString>.from(response.data!['data'] as List)
          .map((e) => Device.fromJson(e))
          .toList();

      return BaseResponse<List<Device>>.success(devices, meta: response.meta);
    } else {
      return BaseResponse<List<Device>>.failure(response.message);
    }
  }
}
