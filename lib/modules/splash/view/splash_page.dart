import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trans_trackid_example/modules/location_devices/view/location_devices_page.dart';
import 'package:trans_trackid_example/modules/splash/cubit/splash_cubit.dart';
import 'package:trans_trackid_example/repositories/devices_repository.dart';
import 'package:trans_trackid_example/repositories/main_repository.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocProvider(
          create: (context) =>
              SplashCubit(MainRepository(), DevicesRepository())..initialize(),
          child: const _SplashBody(),
        ),
      ),
    );
  }
}

class _SplashBody extends StatelessWidget {
  const _SplashBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SplashCubit, SplashState>(
      listener: (context, state) {
        if (state is SplashSuccess) {
          /// TODO: Create helper router to easy manage navigation
          Navigator.of(context).push(CupertinoPageRoute<void>(
            builder: (context) {
              return LocationDevicesPage(devices: state.devices);
            },
          ));
        }
      },
      builder: (context, state) {
        if (state is SplashLoading) {
          return const CircularProgressIndicator();
        } else if (state is SplashSuccess) {
          return const Text('Loaded');
        } else if (state is SplashFailure) {
          return _ErrorWidget(error: state.error);
        } else {
          return _ErrorWidget(error: 'Unknown state ${state.toString()}');
        }
      },
    );
  }
}

class _ErrorWidget extends StatelessWidget {
  const _ErrorWidget({Key? key, required this.error}) : super(key: key);

  final String error;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<SplashCubit>().getDevices();
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(error),
          const Text('Tap to refresh'),
        ],
      ),
    );
  }
}
