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
        fontSize: FontSize.s18,
      );

  ///onBoarding Text Styles

  static TextStyle onBoardingTextStyle(BuildContext? context) => getLightStyle(
        fontFamily: FontConstants.kreon,
        color: ColorManager.offwhite.withOpacity(.6),
        fontSize: FontSize.s24,
      );

  static TextStyle onBoardingButtonTextStyle(BuildContext? context) =>
      getBoldStyle(
        fontFamily: FontConstants.kreon,
        color: ColorManager.primary,
        fontSize: FontSize.s30,
      );

  ///Selection Text Styles

  static TextStyle selectionTitleTextStyle(BuildContext? context) =>
      getBoldStyle(
        fontFamily: FontConstants.kreon,
        color: ColorManager.lightGrey,
        fontSize: FontSize.s35,
      );

  static TextStyle selectionSubTitleTextStyle(BuildContext? context) =>
      getLightStyle(
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

  static TextStyle authErrorTextStyle(BuildContext? context) => getRegularStyle(
        fontFamily: FontConstants.kreon,
        color: ColorManager.error,
        fontSize: FontSize.s14,
      );

  ///Login Text Styles

  static TextStyle loginTitleTextStyle(BuildContext? context) => getBoldStyle(
        fontFamily: FontConstants.kreon,
        color: ColorManager.lightGrey,
        fontSize: FontSize.s24,
      );

  ///Login Text Styles

  static TextStyle registerTitleTextStyle(BuildContext? context) =>
      getBoldStyle(
        fontFamily: FontConstants.kreon,
        color: ColorManager.lightGrey,
        fontSize: FontSize.s24,
      );

  ///Forgot Password Text Styles

  static TextStyle forgotPasswordTitleTextStyle(BuildContext? context) =>
      getBoldStyle(
        fontFamily: FontConstants.kreon,
        color: ColorManager.primary,
        fontSize: FontSize.s24,
      );

  static TextStyle forgotPasswordEmailValueTextStyle(BuildContext? context) =>
      getLightStyle(
        fontFamily: FontConstants.kreon,
        color: ColorManager.primary.withOpacity(.3),
        fontSize: FontSize.s20,
      );

  static TextStyle forgotPasswordSendCodeTextStyle(BuildContext? context) =>
      getBoldStyle(
        fontFamily: FontConstants.kreon,
        color: ColorManager.white,
        fontSize: FontSize.s30,
      );

  ///Reset Password Text Styles

  static TextStyle resetPasswordTitleTextStyle(BuildContext? context) =>
      getBoldStyle(
        fontFamily: FontConstants.kreon,
        color: ColorManager.primary,
        fontSize: FontSize.s24,
      );

  static TextStyle resetPasswordEmailValueTextStyle(BuildContext? context) =>
      getLightStyle(
        fontFamily: FontConstants.kreon,
        color: ColorManager.primary.withOpacity(.3),
        fontSize: FontSize.s20,
      );

  static TextStyle resetPasswordPasswordLabelTextStyle(BuildContext? context) =>
      getLightStyle(
        fontFamily: FontConstants.kurale,
        color: ColorManager.primary,
        fontSize: FontSize.s24,
      );

  static TextStyle resetPasswordPasswordHintTextStyle(BuildContext? context) =>
      getLightStyle(
        fontFamily: FontConstants.kreon,
        color: ColorManager.primary.withOpacity(.3),
        fontSize: FontSize.s20,
      );

  static TextStyle resetPasswordChangeTextStyle(BuildContext? context) =>
      getBoldStyle(
        fontFamily: FontConstants.kreon,
        color: ColorManager.white,
        fontSize: FontSize.s30,
      );

  ///Notifications Screen Text Styles

  static TextStyle notificationsScreenTitleTextStyle(BuildContext? context) =>
      getBoldStyle(
        fontFamily: FontConstants.kreon,
        color: ColorManager.white,
        fontSize: FontSize.s24,
      );

  static TextStyle notificationsScreenSectionHeaderTextStyle(
          BuildContext? context) =>
      getRegularStyle(
        fontFamily: FontConstants.kurale,
        color: ColorManager.white,
        fontSize: FontSize.s20,
      );

  static TextStyle notificationsScreenPersonNameTextStyle(
          BuildContext? context) =>
      getBoldStyle(
        fontFamily: FontConstants.kurale,
        color: ColorManager.white,
        fontSize: FontSize.s20,
      );

  static TextStyle notificationsScreenItemBodyTextStyle(
          BuildContext? context) =>
      getLightStyle(
        fontFamily: FontConstants.kreon,
        color: ColorManager.white,
        fontSize: FontSize.s18,
      );

  static TextStyle notificationsScreenOptionTextStyle(BuildContext? context) =>
      getBoldStyle(
        fontFamily: FontConstants.kreon,
        color: ColorManager.primary,
        fontSize: FontSize.s15,
      );

  static TextStyle notificationsScreenDateTextStyle(BuildContext? context) =>
      getLightStyle(
        fontFamily: FontConstants.kreon,
        color: ColorManager.offwhite.withOpacity(.6),
        fontSize: FontSize.s14,
      );

  // Chat Text Styles

  static TextStyle personNameTextStyle(BuildContext? context) => getBoldStyle(
        fontFamily: FontConstants.kreon,
        color: ColorManager.secondary,
        fontSize: FontSize.s19,
      );

  static TextStyle chatDateTextStyle(BuildContext? context) => getLightStyle(
        fontFamily: FontConstants.kreon,
        color: ColorManager.secondary,
        fontSize: FontSize.s14,
      );

  static TextStyle messageTextStyle(BuildContext? context) => getLightStyle(
        fontFamily: FontConstants.kreon,
        color: ColorManager.secondary,
        fontSize: FontSize.s17,
      );
}
