import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:temp_house/presentation/main_layout/pages/home_screen/view/widgets/popular_row.dart';

import '../../../../../common/widget/main_seach_field.dart';
import '../../../../../resources/assets_manager.dart';
import '../../../../../resources/color_manager.dart';
import '../../../../../resources/strings_manager.dart';
import '../../../../../resources/values_manager.dart';
import 'home_page_app_bar.dart';

class HomePageBody extends StatelessWidget {
  const HomePageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: AppSize.s16,
          ),

          const HomePageAppBar(),
          const SizedBox(
            height: AppSize.s20,
          ),

          MainSearch(hintText: AppStrings.searchTextHint.tr(), leadingIcon: Icons.search_rounded, trailingIcon: Icons.tune,),
          const SizedBox(
            height: AppSize.s20,
          ),

          PopularRow(startedText: AppStrings.popularStartedTextRow.tr(),endedText: AppStrings.popularEndedTextRow.tr(),),
          // const SizedBox(
          //   height: AppSize.s250,
          // ),
          const SizedBox(
            height: AppSize.s20,
          ),
          
          Container(
            height: AppSize.s500,
            decoration: const BoxDecoration(
              color: ColorManager.offwhite,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(AppSize.s50),
                topLeft: Radius.circular(AppSize.s50),
              ),
            ),
            padding: const EdgeInsets.all(AppPadding.p80),
            child: Lottie.asset(LottieAssets.underConstruction),
          )
        ],
      ),
    );
  }
}
