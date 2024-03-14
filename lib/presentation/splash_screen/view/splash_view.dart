import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'dart:async';

// Import the necessary packages for Bloc
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temp_house/presentation/splash_screen/view/widgets/splash_body.dart';

import '../../resources/strings_manager.dart';
import '../../resources/text_styles.dart';
import '../../selection_screen/selection_view.dart';


class SplashScreen extends StatelessWidget {
  static String routeName ='splashscreen';
  @override
  Widget build(BuildContext context) {
    return const Scaffold(

      body: SplashScreenBody(),
    );
  }
}