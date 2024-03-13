import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../common/widget/main_btn_white.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/routes_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/text_styles.dart';

class GetStartingBody extends StatelessWidget {
  const GetStartingBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            AppStrings.splashScreenTitle.tr(),
            style: AppTextStyles.SplashScreenTitleTextStyle(context),
          ),
          Text(AppStrings.getStartRoleTitle.tr(),
              style: AppTextStyles.splashScreenSubTitleTextStyle(context)),
          const SizedBox(
            height: 80,
          ),
          CommonBtn(
            onTap: () {
              Navigator.pushReplacementNamed(context, Routes.loginRoute);
            },
            title: AppStrings.getStartTitle.tr(),
          ),
          const SizedBox(
            height: 30,
          ),
          CommonBtn(
            onTap: () {
              Navigator.pushReplacementNamed(context, Routes.loginRoute);
            },
            title: AppStrings.getStartSubTitle.tr(),
          )
        ],
      ),
    );
  }
}
