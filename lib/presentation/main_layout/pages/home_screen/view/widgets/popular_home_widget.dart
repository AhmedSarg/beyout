import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:temp_house/presentation/main_layout/pages/home_screen/view/widgets/popular_row.dart';

import '../../../../../resources/color_manager.dart';
import '../../../../../resources/strings_manager.dart';
import '../../../../../resources/values_manager.dart';
import 'home_listView.dart';
import 'near_by_home_list.dart';

class PopularHomeWidget extends StatelessWidget {
  const PopularHomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(

        margin: const EdgeInsets.only(top: AppMargin.m150),
        decoration: const BoxDecoration(
          color: ColorManager.offwhite,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(AppSize.s50),
            topLeft: Radius.circular(AppSize.s50),
          ),
        ),
        padding: const EdgeInsets.all(AppPadding.p20),
        child:const NearByHomeList()
      ),
      const HomeSlider()
    ]);
  }
}
