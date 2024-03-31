import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:temp_house/presentation/main_layout/pages/favourite_screen/view/widgets/favourite_body.dart';

import '../../../../common/widget/main_app_bar.dart';
import '../../../../resources/color_manager.dart';
import '../../../../resources/strings_manager.dart';
import '../../../../resources/text_styles.dart';
import '../../../../resources/values_manager.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        toolbarHeight: AppSize.s80,
        scrolledUnderElevation: AppSize.s0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(AppSize.s1_4),
          child: Container(
            color: ColorManager.lightGrey,
            height: AppSize.s1_4,
          ),
        ),

        title:  Text(
          AppStrings.favouraiteScreenTitle.tr(),
          style: AppTextStyles.notificationsScreenTitleTextStyle(context),
        ),
      ),
      backgroundColor: ColorManager.offwhite,
      body: const FavouriteBody(),
    );
  }
}
