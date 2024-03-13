import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../onboarding_screen/view/onboarding_view.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/text_styles.dart';

class SplashScreenBody extends StatelessWidget {
  const SplashScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      nextScreen: const OnboardingScreen(),
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
