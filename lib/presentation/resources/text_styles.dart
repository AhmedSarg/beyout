import 'package:flutter/material.dart';

import 'color_manager.dart';
import 'font_manager.dart';
import 'styles_manager.dart';

class AppTextStyles {
  AppTextStyles._();

  static TextStyle baseStatesMessageTextStyle(BuildContext? context) =>
      getBoldStyle(
        fontFamily: FontConstants.kreon,
        color: ColorManager.primary,
        fontSize: FontSize.s22,
      );

  static TextStyle baseStatesElevatedBtnTextStyle(BuildContext? context) =>
      getBoldStyle(
        fontFamily: FontConstants.kreon,
        color: ColorManager.white,
        fontSize: FontSize.s14,
      );

  ///Splash Text Styles

  static TextStyle splashScreenTitleTextStyle(BuildContext? context) =>
      getBoldStyle(
        fontFamily: FontConstants.kreon,
        color: ColorManager.lightGrey,
        fontSize: FontSize.s32,
      );

  static TextStyle splashScreenSubTitleTextStyle(BuildContext? context) =>
      getLightStyle(
        fontFamily: FontConstants.kreon,
        color: ColorManager.offwhite.withOpacity(.6),
        fontSize: FontSize.s24,
      );

  ///onBoarding Text Styles

  static TextStyle onBoardingTextStyle(
    BuildContext? context,
  ) =>
      getBoldStyle(
        fontFamily: FontConstants.kreon,
        color: ColorManager.primary,
        fontSize: FontSize.s24,
      );

  ///Selection Text Styles

  static TextStyle selectionTitleTextStyle(BuildContext? context) =>
      getBoldStyle(
        fontFamily: FontConstants.kreon,
        color: ColorManager.lightGrey,
        fontSize: FontSize.s35,
      );

  static TextStyle selectionSubTitleTextStyle(BuildContext? context) =>
      getBoldStyle(
        fontFamily: FontConstants.kreon,
        color: ColorManager.offwhite.withOpacity(.6),
        fontSize: FontSize.s24,
      );

  static TextStyle selectionOptionTextStyle(BuildContext? context) =>
      getBoldStyle(
        fontFamily: FontConstants.kreon,
        color: ColorManager.primary,
        fontSize: FontSize.s30,
      );

  /// Auth Text Style

  static TextStyle authLabelTextStyle(BuildContext? context) => getRegularStyle(
        fontFamily: FontConstants.kurale,
        color: ColorManager.lightGrey,
        fontSize: FontSize.s24,
      );

  static TextStyle authHintTextStyle(BuildContext? context) => getLightStyle(
        fontFamily: FontConstants.kreon,
        color: ColorManager.offwhite.withOpacity(.6),
        fontSize: FontSize.s20,
      );

  static TextStyle authButtonTextStyle(BuildContext? context) => getBoldStyle(
        fontFamily: FontConstants.kreon,
        color: ColorManager.primary,
        fontSize: FontSize.s30,
      );

  static TextStyle authSocialTextStyle(BuildContext? context) => getLightStyle(
        fontFamily: FontConstants.kreon,
        color: ColorManager.offwhite.withOpacity(.6),
        fontSize: FontSize.s20,
      );

  static TextStyle authActionsTextStyle(BuildContext? context) => getLightStyle(
        fontFamily: FontConstants.kreon,
        color: ColorManager.tertiary.withOpacity(.4),
        fontSize: FontSize.s20,
      );

  ///Login Text Styles

  static TextStyle loginTitleTextStyle(BuildContext? context) => getBoldStyle(
        fontFamily: FontConstants.kreon,
        color: ColorManager.lightGrey,
        fontSize: FontSize.s24,
      );

  ///Forgot Password Text Styles

  static TextStyle forgotPasswordTitleTextStyle(BuildContext? context) => getBoldStyle(
    fontFamily: FontConstants.kreon,
    color: ColorManager.primary,
    fontSize: FontSize.s24,
  );

  static TextStyle forgotPasswordEmailValueTextStyle(BuildContext? context) => getLightStyle(
    fontFamily: FontConstants.kreon,
    color: ColorManager.primary.withOpacity(.3),
    fontSize: FontSize.s20,
  );

  static TextStyle forgotPasswordSendCodeTextStyle(BuildContext? context) => getBoldStyle(
    fontFamily: FontConstants.kreon,
    color: ColorManager.white,
    fontSize: FontSize.s30,
  );
}
