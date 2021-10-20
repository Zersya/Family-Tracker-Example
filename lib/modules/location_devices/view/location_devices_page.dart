import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:trans_trackid_example/models/device.dart';
import 'package:trans_trackid_example/modules/location_devices/cubit/location_devices_cubit.dart';

class LocationDevicesPage extends StatelessWidget {
  const LocationDevicesPage({Key? key, required this.devices})
      : super(key: key);

  final List<Device> devices;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: BlocProvider(
          create: (context) => LocationDevicesCubit(devices)..onMapCreated(),
          child: BlocBuilder<LocationDevicesCubit, LocationDevicesState>(
            builder: (context, state) {
              if (state is LocationDevicesSuccess) {
                final markers = devices.map((device) {
                  final lat = double.parse(device.latitude);
                  final lng = double.parse(device.longitude);

                  return Marker(
                      markerId: MarkerId(device.id),
                      position: LatLng(lat, lng),
                      infoWindow: InfoWindow(title: device.name),
                      icon: state.imageData != null
                          ? BitmapDescriptor.fromBytes(
                              state.imageData!.buffer.asUint8List())
                          : BitmapDescriptor.defaultMarker,
                      onTap: () {
                        showCupertinoModalBottomSheet<void>(
                          context: context,
                          builder: (context) => Material(
                            child: ListTile(
                              leading: Image.network(device.avatar),
                              title: Text(device.name),
                              subtitle: Text(
                                '${device.latitude} ${device.longitude}',
                              ),
                            ),
                          ),
                        );
                      });
                }).toList();

                return GoogleMap(
                  initialCameraPosition: state.cameraPosition,
                  mapType: MapType.hybrid,
                  markers: markers.toSet(),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }
}
