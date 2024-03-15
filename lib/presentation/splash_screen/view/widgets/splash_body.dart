import 'dart:async';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../onboarding_screen/view/onboarding_view.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/routes_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/text_styles.dart';
import '../../../selection_screen/selection_view.dart';
import '../splash_view.dart';

class SplashScreenBody extends StatefulWidget {
  const SplashScreenBody({super.key});

  @override
  State<SplashScreenBody> createState() => _SplashScreenBodyState();
}

class _SplashScreenBodyState extends State<SplashScreenBody>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);

    _controller.forward();

    // Timer(Duration(seconds: 3), () {
    //
    //     Navigator.pushReplacementNamed(context, Routes.onboardingRoute);
    //
    // });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(


      child: Center(
        child: AnimatedBuilder(
          animation: _animation,
          builder: (BuildContext context, Widget? child) {
            return Transform.scale(
              scale: _animation.value,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.7,
                height: MediaQuery.of(context).size.height * 0.22,
                decoration: BoxDecoration(
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
