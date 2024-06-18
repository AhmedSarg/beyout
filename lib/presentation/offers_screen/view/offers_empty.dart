import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:temp_house/app/extensions.dart';

import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';

class OffersEmpty extends StatelessWidget {
  const OffersEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p40),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              LottieAssets.noContent,
              repeat: false,
              width: context.width() * .6,
            ),
            const SizedBox(height: AppSize.s10),
            Text(
              'You Don\'t Have any Offers',
              style: getSemiBoldStyle(
                color: ColorManager.black,
                fontSize: FontSize.f16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
