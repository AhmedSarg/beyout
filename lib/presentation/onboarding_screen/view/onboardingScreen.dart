import 'package:flutter/material.dart';
import 'package:temp_house/presentation/onboarding_screen/view/widgets/onBoardingImageWidget.dart';
import 'package:temp_house/presentation/onboarding_screen/view/widgets/onBoardingTextWidget.dart';
import 'package:temp_house/presentation/resources/assets_manager.dart';
import 'package:temp_house/presentation/resources/color_manager.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            OnBoardingImageWidget(),
            OnBoardingTextWidget()
      ]),
    );
  }
}
