import 'package:flutter/material.dart';

import 'widgets/onboarding_image.dart';
import 'widgets/onboarding_text.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            OnboardingImage(),
            OnboardingText()
      ]),
    );
  }
}
