part of 'splash_cubit.dart';

@immutable
abstract class SplashState {}

class SplashInitial extends SplashState {}

class SplashLoading extends SplashState {}

class SplashSuccess extends SplashState {
  SplashSuccess(this.devices);

  final List<Device> devices;
}

class SplashFailure extends SplashState {
  SplashFailure({required this.error});

  final String error;
}
