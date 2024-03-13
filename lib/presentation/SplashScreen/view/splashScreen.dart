import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temp_house/presentation/SplashScreen/view/widgets/SplashScreenBody.dart';

import '../../base/cubit_listener.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SplashScreenbody(),
    );
  }
  }

