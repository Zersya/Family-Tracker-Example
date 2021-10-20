import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:trans_trackid_example/models/device.dart';
import 'package:trans_trackid_example/repositories/devices_repository.dart';
import 'package:trans_trackid_example/repositories/main_repository.dart';
import 'package:trans_trackid_example/utils/enum.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit(this.mainRepo) : super(SplashInitial());

  final MainRepository mainRepo;

  Future<void> initialize() async {
    emit(SplashLoading());
    mainRepo.initialize();
    await getDevices();
  }

  Future<void> getDevices() async {
    final _devicesRepo = DevicesRepository();

    emit(SplashLoading());
    final response = await _devicesRepo.getDevices();

    if (response.status == ResponseStatus.success) {
      emit(SplashSuccess(response.data!));
    } else {
      emit(SplashFailure(error: response.message ?? ' - '));
    }
  }
}
