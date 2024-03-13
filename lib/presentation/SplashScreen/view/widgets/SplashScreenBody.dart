import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:temp_house/presentation/onboarding_screen/view/onboardingScreen.dart';
import 'package:temp_house/presentation/resources/strings_manager.dart';
import 'package:temp_house/presentation/resources/text_styles.dart';

import '../../../resources/color_manager.dart';

class SplashScreenbody extends StatelessWidget {
  const SplashScreenbody({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      nextScreen: OnboardingScreen(),
      splashIconSize: 4000,
      backgroundColor:  ColorManager.scafoldBG,
      splash: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppStrings.splashScreenTitle.tr(),
              style: AppTextStyles.SplashScreenTitleTextStyle(context),
            ),
            Text(AppStrings.splashScreenSubTitle.tr(),
                style: AppTextStyles.splashScreenSubTitleTextStyle(context)),
            const SizedBox(
              height: 80,
            )
          ],
        ),
      ),
    );
  }
}
