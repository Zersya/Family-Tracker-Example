import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:trans_trackid_example/modules/splash/cubit/splash_cubit.dart';
import 'package:trans_trackid_example/repositories/main_repository.dart';
import 'package:trans_trackid_example/utils/get_it.dart';

import 'splash_cubit_test.mocks.dart';

@GenerateMocks([MainRepository, Dio])
void main() {
  late MockMainRepository mainRepo;

  setUp(() {
    final mockDio = MockDio();
    initializeDI(mockDio);
    mainRepo = MockMainRepository();
  });

  group('SplashCubit', () {
    test('should emit initial state', () {
      final cubit = SplashCubit(mainRepo);

      expect(cubit.state, SplashInitial());
    });

    // test('should emit loading state', () {
    //   cubit.loadData();
    //   expect(cubit.state, SplashState.loading());
    // });

    // test('should emit success state', () {
    //   cubit.loadData();
    //   cubit.loadDataSuccess();
    //   expect(cubit.state, SplashState.success());
    // });

    // test('should emit error state', () {
    //   cubit.loadData();
    //   cubit.loadDataError();
    //   expect(cubit.state, SplashState.error());
    // });
  });
}
