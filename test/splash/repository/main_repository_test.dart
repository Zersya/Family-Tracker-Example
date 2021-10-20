import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:trans_trackid_example/repositories/main_repository.dart';

@GenerateMocks([Dio, MainRepository])
void main() {
  final dio = Dio();

  group('MainRepository', () {
    test('should verify that dio is setup', () async {
      final mainRepo = MainRepository('id', dio);
      // ignore: cascade_invocations
      mainRepo.initialize();

      expect(mainRepo.lang, 'id');
      expect(mainRepo.dio, dio);
    });
  });
}
