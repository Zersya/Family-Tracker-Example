part of 'location_devices_cubit.dart';

@immutable
abstract class LocationDevicesState {}

class LocationDevicesInitial extends LocationDevicesState {}

class LocationDevicesLoading extends LocationDevicesState {}

class LocationDevicesSuccess extends LocationDevicesState {
  LocationDevicesSuccess(this.cameraPosition, this.devices, this.imageData);
  final CameraPosition cameraPosition;
  final List<Device> devices;
  final ByteData? imageData;
}

class LocationDevicesFailure extends LocationDevicesState {
  LocationDevicesFailure(this.message);

  final String message;
}
