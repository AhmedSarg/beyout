import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'dart:async';

// Import the necessary packages for Bloc
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../resources/strings_manager.dart';
import '../../resources/text_styles.dart';
import '../../selection_screen/selection_view.dart';


class SplashScreen extends StatefulWidget {
  static String routeName ='splashscreen';

  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);

    _controller.forward();

    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          transitionDuration: const Duration(seconds: 1),
          pageBuilder: (_, __, ___) => const SelectionScreen(),
          transitionsBuilder: (_, animation, __, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: AnimatedBuilder(
          animation: _animation,
          builder: (BuildContext context, Widget? child) {
            return Transform.scale(
              scale: _animation.value,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.7,
                height: MediaQuery.of(context).size.height * 0.22,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Column(
                  children: [
                    Text(
                      AppStrings.splashScreenTitle.tr(),
                      style: AppTextStyles.splashScreenTitleTextStyle(context),
                    ),
                    Text(
                      AppStrings.splashScreenSubTitle.tr(),
                      style: AppTextStyles.splashScreenSubTitleTextStyle(context),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}