// ignore_for_file: lines_longer_than_80_chars

import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:trans_trackid_example/models/base_response.dart';
import 'package:trans_trackid_example/models/device.dart';
import 'package:trans_trackid_example/modules/splash/cubit/splash_cubit.dart';
import 'package:trans_trackid_example/repositories/devices_repository.dart';
import 'package:trans_trackid_example/repositories/main_repository.dart';
import 'package:trans_trackid_example/utils/enum.dart';

import 'splash_cubit_test.mocks.dart';

@GenerateMocks([MainRepository, DevicesRepository, Dio])
void main() {
  late MainRepository mainRepo;
  late DevicesRepository deviceRepo;

  setUp(() {
    mainRepo = MockMainRepository();
    deviceRepo = MockDevicesRepository();
  });

  group('SplashCubit', () {
    test('should emit initial state', () {
      final cubit = SplashCubit(mainRepo, deviceRepo);

      expect(cubit.state, isA<SplashInitial>());
    });

    blocTest<SplashCubit, SplashState>(
      'should emit [SplashLoading] [SplashLoading] [SplashSuccess] when [initialize] is called success',
      build: () {
        when(deviceRepo.getDevices()).thenAnswer(
          (_) async => BaseResponse<List<Device>>(
              data: [], status: ResponseStatus.success),
        );
        return SplashCubit(mainRepo, deviceRepo);
      },
      act: (SplashCubit cubit) async => cubit.initialize(),
      expect: () => [
        isA<SplashLoading>(),
        isA<SplashLoading>(),
        isA<SplashSuccess>(),
      ],
    );

    blocTest<SplashCubit, SplashState>(
      'should emit [SplashLoading] [SplashLoading] [SplashFailure] when [initialize] is called failed',
      build: () {
        when(deviceRepo.getDevices()).thenAnswer(
          (_) async =>
              BaseResponse<List<Device>>(status: ResponseStatus.failed),
        );
        return SplashCubit(mainRepo, deviceRepo);
      },
      act: (SplashCubit cubit) async => cubit.initialize(),
      expect: () => [
        isA<SplashLoading>(),
        isA<SplashLoading>(),
        isA<SplashFailure>(),
      ],
    );

    blocTest<SplashCubit, SplashState>(
      'should emit [SplashLoading] [SplashSuccess] when [getDevices] is called success',
      build: () {
        when(deviceRepo.getDevices()).thenAnswer(
          (_) async => BaseResponse<List<Device>>(
              data: [], status: ResponseStatus.success),
        );
        return SplashCubit(mainRepo, deviceRepo);
      },
      act: (SplashCubit cubit) async => cubit.getDevices(),
      expect: () => [
        isA<SplashLoading>(),
        isA<SplashSuccess>(),
      ],
    );

    blocTest<SplashCubit, SplashState>(
      'should emit [SplashLoading] [SplashSuccess] when [getDevices] is called failed',
      build: () {
        when(deviceRepo.getDevices()).thenAnswer(
          (_) async =>
              BaseResponse<List<Device>>(status: ResponseStatus.failed),
        );
        return SplashCubit(mainRepo, deviceRepo);
      },
      act: (SplashCubit cubit) async => cubit.getDevices(),
      expect: () => [
        isA<SplashLoading>(),
        isA<SplashFailure>(),
      ],
    );
  });
}
