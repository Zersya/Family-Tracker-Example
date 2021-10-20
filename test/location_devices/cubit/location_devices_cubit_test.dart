// ignore_for_file: lines_longer_than_80_chars

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trans_trackid_example/models/device.dart';
import 'package:trans_trackid_example/modules/location_devices/cubit/location_devices_cubit.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group(
    'LocationDevicesCubit',
    () {
      test('should emit initial state', () {
        final cubit = LocationDevicesCubit([]);

        expect(cubit.state, isA<LocationDevicesInitial>());
      });

      blocTest<LocationDevicesCubit, LocationDevicesState>(
        'should emit [LocationDevicesLoading] [LocationDevicesSuccess] when [onMapCreated] is called success with empty data',
        build: () {
          return LocationDevicesCubit([]);
        },
        act: (cubit) => cubit.onMapCreated(),
        expect: () => [
          isA<LocationDevicesLoading>(),
          isA<LocationDevicesSuccess>(),
        ],
      );

      blocTest<LocationDevicesCubit, LocationDevicesState>(
        'should emit [LocationDevicesLoading] [LocationDevicesSuccess] when [onMapCreated] is called success with one data',
        build: () {
          return LocationDevicesCubit([
            Device('id', 'name', 'avatar', '1.0', '1.0', ''),
          ]);
        },
        act: (cubit) => cubit.onMapCreated(),
        expect: () => [
          isA<LocationDevicesLoading>(),
          isA<LocationDevicesSuccess>(),
        ],
      );

      blocTest<LocationDevicesCubit, LocationDevicesState>(
        'should emit [LocationDevicesLoading] [LocationDevicesFailure] when [onMapCreated] is called failure with wrong parsed lat',
        build: () {
          return LocationDevicesCubit([
            Device('id', 'name', 'avatar', 'qq', '1.0', ''),
          ]);
        },
        act: (cubit) => cubit.onMapCreated(),
        expect: () => [
          isA<LocationDevicesLoading>(),
          isA<LocationDevicesFailure>(),
        ],
      );
    },
  );
}
