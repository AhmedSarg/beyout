import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/values_manager.dart';

AppBar buildMainAppBar(BuildContext context, Widget? title, ) {
  return AppBar(
    toolbarHeight: AppSize.s80,
    backgroundColor: ColorManager.transparent,
    centerTitle: false,
    title: title,
    scrolledUnderElevation: AppSize.s0,
    bottom:  PreferredSize(
      preferredSize: const Size.fromHeight(AppSize.s1_4),
      child: Container(
        color: ColorManager.lightGrey,
        height: AppSize.s1_4,
      ),
    ),
    elevation: AppSize.s0,
    shadowColor: const Color.fromRGBO(0, 0, 0, 0.25),
  );
}

