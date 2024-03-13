import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../common/widget/main_button.dart';
import '../../../resources/routes_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/text_styles.dart';

class SelectionBody extends StatelessWidget {
  const SelectionBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            AppStrings.selectionScreenTitle.tr(),
            style: AppTextStyles.splashScreenTitleTextStyle(context),
          ),
          Text(AppStrings.selectionScreenSubTitle.tr(),
              style: AppTextStyles.splashScreenSubTitleTextStyle(context)),
          const SizedBox(
            height: 80,
          ),
          MainButton(
            onTap: () {
              Navigator.pushReplacementNamed(context, Routes.loginRoute);
            },
            text: AppStrings.selectionScreenOwner.tr(),
            textStyle: AppTextStyles.selectionOptionTextStyle(context),
          ),
          const SizedBox(
            height: 30,
          ),
          MainButton(
            onTap: () {
              Navigator.pushReplacementNamed(context, Routes.loginRoute);
            },
            text: AppStrings.selectionScreenTenant.tr(),
            textStyle: AppTextStyles.selectionOptionTextStyle(context),
          )
        ],
      ),
    );
  }
}
