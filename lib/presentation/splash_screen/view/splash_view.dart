import 'package:flutter/material.dart';
import 'dart:async';

// Import the necessary packages for Bloc
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temp_house/presentation/splash_screen/view/widgets/splash_body.dart';

import '../../selection_screen/selection_view.dart';


class SplashScreen extends StatelessWidget {
  static String routeName ='splashscreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SplashScreenBody(),
    );
  }
}