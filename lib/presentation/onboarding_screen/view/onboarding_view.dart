import 'package:flutter/material.dart';
import 'package:temp_house/presentation/onboarding_screen/view/widgets/onBoardingItems.dart';
import 'package:temp_house/presentation/resources/assets_manager.dart';

import 'widgets/onboarding_image.dart';
import 'widgets/onboarding_text.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final controller = OnBoardingItems();
  final pageControler = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        itemCount: controller.items.length,
        itemBuilder: (context, index) {
          return Stack(
            alignment: Alignment.bottomCenter,
            children: [
              OnboardingImage(
                onboardImage: controller.items[index].image,

              ),
              OnboardingText(
                btnName: controller.items[index].title,
                  title: controller.items[index].btnName,
              ),
            ],
          );
        },
      ),
    );
  }
}
