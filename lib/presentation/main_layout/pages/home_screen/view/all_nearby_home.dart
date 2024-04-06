import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:temp_house/presentation/common/widget/main_app_bar.dart';
import 'package:temp_house/presentation/resources/strings_manager.dart';
import 'package:temp_house/presentation/resources/text_styles.dart';

import '../../../../resources/color_manager.dart';
import '../../../../resources/routes_manager.dart';
import '../../../../resources/values_manager.dart';
import 'widgets/near_by_home_item.dart';

class AllNearByHome extends StatelessWidget {
  const AllNearByHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.offwhite,
      appBar: buildMainAppBar(
        context,
        Text(
          AppStrings.allNearbyTitle.tr(),
          style: AppTextStyles.mainAppBarText(context),
        ),
        ColorManager.primary,
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, Routes.homeDetailsRoute);
            },
            child: const NearByHomeItem(),
          );
        },
      ),
    );
  }
}
