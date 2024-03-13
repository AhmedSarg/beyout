import 'package:flutter/material.dart';

import 'color_manager.dart';
import 'font_manager.dart';
import 'styles_manager.dart';

class AppTextStyles {
  AppTextStyles._();

  static TextStyle baseStatesMessageTextStyle(BuildContext? context) =>
      getBoldStyle(
        fontFamily: FontConstants.comfortaa,
        color: ColorManager.primary,
        fontSize: FontSize.s22,
      );

  static TextStyle baseStatesElevatedBtnTextStyle(BuildContext? context) =>
      getBoldStyle(
        fontFamily: FontConstants.comfortaa,
        color: ColorManager.white,
        fontSize: FontSize.s14,
      );

  static TextStyle SplashScreenTitleTextStyle(BuildContext? context) =>
      getBoldStyle(
        fontFamily: FontConstants.kreon,
        color: ColorManager.white,
        fontSize: FontSize.s32,

      );
  static TextStyle splashScreenSubTitleTextStyle(BuildContext? context) =>
      getLightStyle(
        fontFamily: FontConstants.kreon,
        color: ColorManager.offwhite.withOpacity(.5),
        fontSize: FontSize.s24,

      );
  static TextStyle getStartTextStyle(BuildContext? context, ) =>
      getBoldStyle(
        fontFamily: FontConstants.kreon,
        color: ColorManager.scafoldBG,
        fontSize: FontSize.s24,

      );



  // Auth Text Style
  static TextStyle authTextStyle(BuildContext? context) =>
      getBoldStyle(
        fontFamily: FontConstants.kurale,
        color: ColorManager.white,
        fontSize: FontSize.s24,

      );

  static TextStyle authHintTextTextStyle(BuildContext? context) =>
      getLightStyle(
        fontFamily: FontConstants.kreon,
        color: ColorManager.offwhite.withOpacity(.5),
        fontSize: FontSize.s16,

      );

  static TextStyle authBtnTextStyle(BuildContext? context) =>
      getBoldStyle(
        fontFamily: FontConstants.kreon,
        color: ColorManager.white.withOpacity(.3),
        fontSize: FontSize.s24,

      );

  static TextStyle authSocialTextStyle(BuildContext? context, ) =>
      getLightStyle(
        fontFamily: FontConstants.kreon,
        color: ColorManager.offwhite.withOpacity(.35),
        fontSize: FontSize.s20,

      );
}
