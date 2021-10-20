// ignore_for_file: lines_longer_than_80_chars

import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';
import 'package:trans_trackid_example/gen/assets.gen.dart';
import 'package:trans_trackid_example/models/device.dart';

part 'location_devices_state.dart';

class LocationDevicesCubit extends Cubit<LocationDevicesState> {
  LocationDevicesCubit(this.devices) : super(LocationDevicesInitial());

  final List<Device> devices;
  final double initialLat = -6.229728;
  final double initialLng = 106.6894307;

  Future<void> onMapCreated() async {
    try {
      emit(LocationDevicesLoading());

      if (devices.isEmpty) {
        final cameraPos = CameraPosition(
          target: LatLng(initialLat, initialLng),
        );

        emit(LocationDevicesSuccess(cameraPos, devices, null));
        return;
      }

      final lat = double.parse(devices.first.latitude);
      final lng = double.parse(devices.first.longitude);
      final cameraPos = CameraPosition(target: LatLng(lat, lng));
      final imageData =
          await rootBundle.load(Assets.images.personLocation.path);

      /// TODO: Using Avatar as marker for each device
      // for (final device in devices) {
      //   device.avatarBytes = (await NetworkAssetBundle(Uri.parse(device.avatar))
      //           .load(device.avatar))
      //       .buffer
      //       .asUint8List();
      // }

      emit(LocationDevicesSuccess(cameraPos, devices, imageData));
    } catch (e) {
      emit(LocationDevicesFailure(e.toString()));
    }
  }
}
