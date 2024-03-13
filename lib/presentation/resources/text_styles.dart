import 'package:flutter/material.dart';

import 'color_manager.dart';
import 'font_manager.dart';
import 'styles_manager.dart';

class AppTextStyles {
  AppTextStyles._();

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
  static TextStyle getStartTextStyle(BuildContext? context) =>
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

  static TextStyle authTextTextStyle(BuildContext? context) =>
      getLightStyle(
        fontFamily: FontConstants.kreon,
        color: ColorManager.lightBlue.withOpacity(.8),
        fontSize: FontSize.s20,

      );





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

  static TextStyle onBoardingButtonTextStyle(BuildContext? context) =>
      getBoldStyle(
        fontFamily: FontConstants.comfortaa,
        color: ColorManager.primary,
        fontSize: FontSize.s24,
      );

  static TextStyle textFieldLabelTextStyle(BuildContext? context) =>
      getMediumStyle(
        fontFamily: FontConstants.comfortaa,
        color: ColorManager.black,
        fontSize: FontSize.s20,
      );

  static TextStyle textFieldValueTextStyle(BuildContext? context) =>
      getLightStyle(
        fontFamily: FontConstants.poppins,
        color: ColorManager.black,
        fontSize: FontSize.s17,
      );

  static TextStyle textFieldErrorTextStyle(BuildContext? context) =>
      getMediumStyle(
        fontFamily: FontConstants.comfortaa,
        color: ColorManager.error,
        fontSize: FontSize.s14,
      );

  static TextStyle loginButtonTextStyle(BuildContext? context) => getBoldStyle(
    fontFamily: FontConstants.comfortaa,
    color: ColorManager.white,
    fontSize: FontSize.s24,
  );
  static TextStyle logintitleTextStyle(BuildContext? context) => getBoldStyle(
    fontFamily: FontConstants.kreon,
    color: ColorManager.white,
    fontSize: FontSize.s24,
  );

  static TextStyle homeSectionTitleTextStyle(BuildContext? context) =>
      getSemiBoldStyle(
        fontFamily: FontConstants.inter,
        color: ColorManager.black,
        fontSize: FontSize.s24,
      );

  static TextStyle homeSectionSeeAllTextStyle(BuildContext? context) =>
      getRegularStyle(
        fontFamily: FontConstants.inter,
        color: ColorManager.black,
        fontSize: FontSize.s14,
      );

  static TextStyle homeSectionItemTextStyle(BuildContext? context) =>
      getSemiBoldStyle(
        fontFamily: FontConstants.inter,
        color: ColorManager.white,
        fontSize: FontSize.s22,
      );

  static TextStyle homeScreenEventTitleTextStyle(BuildContext? context) =>
      getBoldStyle(
        fontFamily: FontConstants.poppins,
        color: ColorManager.white,
        fontSize: FontSize.s16,
      );

  static TextStyle homeScreenEventDescriptionTextStyle(BuildContext? context) =>
      getMediumStyle(
        fontFamily: FontConstants.poppins,
        color: ColorManager.white,
        fontSize: FontSize.s12,
      );

  static TextStyle homeScreenEventMonthTextStyle(BuildContext? context) =>
      getMediumStyle(
        fontFamily: FontConstants.inter,
        color: ColorManager.black,
        fontSize: FontSize.s14,
      );

  static TextStyle homeScreenEventDayTextStyle(BuildContext? context) =>
      getMediumStyle(
          fontFamily: FontConstants.inter,
          color: ColorManager.white,
          fontSize: FontSize.s14);

  static TextStyle drawerItemTextStyle(BuildContext? context) =>
      getSemiBoldStyle(
        fontFamily: FontConstants.poppins,
        color: ColorManager.white,
        fontSize: FontSize.s17,
      );

  static TextStyle tracksScreenNameTextStyle(BuildContext? context) =>
      getSemiBoldStyle(
        fontFamily: FontConstants.inter,
        color: ColorManager.white,
        fontSize: FontSize.s20,
      );

  static TextStyle tracksScreenComitteeTextStyle(BuildContext? context) =>
      getSemiBoldStyle(
        fontFamily: FontConstants.inter,
        color: ColorManager.secondaryWithOpacity85,
        fontSize: FontSize.s14,
      );

  static TextStyle tracksScreenTitleTextStyle(BuildContext? context) =>
      getBoldStyle(
        fontFamily: FontConstants.comfortaa,
        color: ColorManager.black,
        fontSize: FontSize.s22,
      );

  static TextStyle boardScreenTitleTextStyle(BuildContext? context) =>
      getBoldStyle(
        fontFamily: FontConstants.comfortaa,
        color: ColorManager.black,
        fontSize: FontSize.s22,
      );

  static TextStyle boardScreenNameTextStyle(BuildContext? context) =>
      getMediumStyle(
        fontFamily: FontConstants.inter,
        color: ColorManager.white,
        fontSize: FontSize.s22,
        shadows: [
          const Shadow(
            color: Color.fromRGBO(0, 0, 0, 0.25),
            blurRadius: 1,
            offset: Offset(2, 2),
          )
        ],
      );

  static TextStyle boardScreenPositionTextStyle(BuildContext? context) =>
      getRegularStyle(
        fontFamily: FontConstants.inter,
        color: ColorManager.secondaryWithOpacity85,
        fontSize: FontSize.s14,
        shadows: [
          const Shadow(
            color: Color.fromRGBO(0, 0, 0, 0.25),
            blurRadius: 2,
            offset: Offset(2, 2),
          )
        ],
      );

  static TextStyle noInternetTitleTextStyle(BuildContext? context) =>
      getMediumStyle(
        fontFamily: FontConstants.poppins,
        color: ColorManager.black,
        fontSize: FontSize.s28,
      );

  static TextStyle noInternetDescriptionTextStyle(BuildContext? context) =>
      getMediumStyle(
        fontFamily: FontConstants.poppins,
        color: ColorManager.darkGrey,
        fontSize: FontSize.s15,
      );

  static TextStyle tryAgainButtonTextStyle(BuildContext? context) =>
      getBoldStyle(
        fontFamily: FontConstants.comfortaa,
        color: ColorManager.white,
        fontSize: FontSize.s22,
      );

  static TextStyle aNewEraBeginsTextStyle(BuildContext? context) =>
      getBoldStyle(
        fontFamily: FontConstants.mvboli,
        color: ColorManager.white,
        fontSize: FontSize.s32,
      );

  static TextStyle btnNavBarUnselectedLabelTextStyle(BuildContext? context) =>
      //todo add text shadows
      getMediumStyle(
        fontSize: FontSize.s12,
        color: ColorManager.white,
        fontFamily: FontConstants.comfortaa,
      );

  static TextStyle btnNavBarSelectedLabelTextStyle(BuildContext? context) =>
      //todo add text shadows
      getMediumStyle(
        fontSize: FontSize.s14,
        color: ColorManager.white,
        fontFamily: FontConstants.comfortaa,
      );

  static TextStyle trackDetailsCommitteNameTextStyle(BuildContext? context) =>
      //todo add text shadows
      getSemiBoldStyle(
        fontSize: FontSize.s24,
        color: ColorManager.black,
        fontFamily: FontConstants.comfortaa,
      );

  static TextStyle trackDetailsCommitteDetailsTextStyle(
          BuildContext? context) =>
      //todo add text shadows
      getMediumStyle(
        fontSize: FontSize.s16,
        color: ColorManager.grey,
        fontFamily: FontConstants.poppins,
      );

  static TextStyle trackDetailsBoardTitleTextStyle(BuildContext? context) =>
      //todo add text shadows
      getSemiBoldStyle(
        fontSize: FontSize.s24,
        color: ColorManager.white,
        fontFamily: FontConstants.comfortaa,
      );

  static TextStyle eventsScreenTitleTextStyle(BuildContext? context) =>
      getBoldStyle(
        fontFamily: FontConstants.comfortaa,
        color: ColorManager.black,
        fontSize: FontSize.s22,
      );

  static TextStyle eventsScreenHeaderTextStyle(BuildContext? context) =>
      //todo add text shadows
      getSemiBoldStyle(
        fontSize: FontSize.s24,
        color: ColorManager.black,
        fontFamily: FontConstants.inter,
      );

  static TextStyle eventsScreenSeeAllTextStyle(BuildContext? context) =>
      //todo add text shadows
      getRegularStyle(
        fontSize: FontSize.s14,
        color: ColorManager.black,
        fontFamily: FontConstants.inter,
      );

  static TextStyle eventsScreenNextEventTextStyle(BuildContext? context) =>
      //todo add text shadows
      getBoldStyle(
        fontSize: FontSize.s16,
        color: ColorManager.white,
        fontFamily: FontConstants.comfortaa,
      );

  static TextStyle onGoingEventScreenTitleTextStyle(BuildContext? context) =>
      //todo add text shadows
      getSemiBoldStyle(
        fontSize: FontSize.s24,
        color: ColorManager.black,
        fontFamily: FontConstants.inter,
      );

  static TextStyle onGoingEventScreenDescriptionTextStyle(
          BuildContext? context) =>
      //todo add text shadows
      getMediumStyle(
        fontSize: FontSize.s20,
        color: ColorManager.grey,
        fontFamily: FontConstants.poppins,
      );

  static TextStyle newsScreenTitleTextStyle(BuildContext? context) =>
      getBoldStyle(
        fontFamily: FontConstants.comfortaa,
        color: ColorManager.black,
        fontSize: FontSize.s22,
      );

  static TextStyle newsScreenNewsTitleTextStyle(BuildContext? context) =>
      getBoldStyle(
        fontSize: FontSize.s16,
        color: ColorManager.black,
        fontFamily: FontConstants.comfortaa,
      );

  static TextStyle newsScreenNewsDescriptionTextStyle(BuildContext? context) =>
      getRegularStyle(
        fontSize: FontSize.s14,
        color: ColorManager.black,
        fontFamily: FontConstants.poppins,
      );

  static TextStyle newsDetailsScreenTitleTextStyle(BuildContext? context) =>
      getBoldStyle(
        fontSize: FontSize.s24,
        color: ColorManager.black,
        fontFamily: FontConstants.comfortaa,
      );

  static TextStyle newsDetailsScreenBodyTextStyle(BuildContext? context) =>
      getRegularStyle(
        fontSize: FontSize.s16,
        color: ColorManager.grey,
        fontFamily: FontConstants.poppins,
      );

  static TextStyle boardDialogTitleTextStyle(BuildContext? context) =>
      getSemiBoldStyle(
        fontSize: FontSize.s24,
        color: ColorManager.white,
        fontFamily: FontConstants.comfortaa,
      );

  static TextStyle boardDialogDescTextStyle(BuildContext? context) =>
      getRegularStyle(
        fontSize: FontSize.s16,
        color: ColorManager.secondary,
        fontFamily: FontConstants.poppins,
      );

  static TextStyle boardDialogBioTextStyle(BuildContext? context) =>
      getRegularStyle(
        fontSize: FontSize.s14,
        color: ColorManager.white,
        fontFamily: FontConstants.poppins,
      );

  static TextStyle agendaScreenTimeTextStyle(BuildContext? context) =>
      getRegularStyle(
        fontSize: FontSize.s14,
        color: ColorManager.white,
        fontFamily: FontConstants.comfortaa,
      );

  static TextStyle agendaScreenUnBoundedTitleTextStyle(BuildContext? context) =>
      getBoldStyle(
        fontSize: FontSize.s14,
        color: ColorManager.primary,
        fontFamily: FontConstants.comfortaa,
      );

  static TextStyle agendaScreenBoundedTitleTextStyle(BuildContext? context) =>
      getBoldStyle(
        fontSize: FontSize.s14,
        color: ColorManager.white,
        fontFamily: FontConstants.comfortaa,
      );

  static TextStyle navBarItemTextStyle(BuildContext? context) => getMediumStyle(
        fontSize: FontSize.s10,
        color: ColorManager.white,
        fontFamily: FontConstants.comfortaa,
      );

  static TextStyle ticketPageTextFormTitleTextStyle(BuildContext? context) =>
      getSemiBoldStyle(
        fontSize: FontSize.s15,
        color: ColorManager.black,
        fontFamily: FontConstants.comfortaa,
      );

  static TextStyle ticketPageTitleTextStyle(BuildContext? context) =>
      getBoldStyle(
        fontSize: FontSize.s22,
        color: ColorManager.black,
        fontFamily: FontConstants.comfortaa,
      );

  static TextStyle ticketPageButtonTextStyle(BuildContext? context) =>
      getBoldStyle(
        fontFamily: FontConstants.comfortaa,
        color: ColorManager.white,
        fontSize: FontSize.s24,
      );

  static TextStyle awardsScreenTitleTextStyle(BuildContext? context) =>
      getBoldStyle(
        fontFamily: FontConstants.comfortaa,
        color: ColorManager.black,
        fontSize: FontSize.s22,
      );

  static TextStyle awardsPageAwardTitleTextStyle(BuildContext? context) =>
      getBoldStyle(
        fontSize: FontSize.s16,
        color: ColorManager.black,
        fontFamily: FontConstants.comfortaa,
      );

  static TextStyle awardsPageAwardDescriptionTextStyle(BuildContext? context) =>
      getRegularStyle(
        fontSize: FontSize.s14,
        color: ColorManager.black,
        fontFamily: FontConstants.poppins,
      );

  static TextStyle restaurantScreenTitleTextStyle(BuildContext? context) =>
      getBoldStyle(
        fontFamily: FontConstants.comfortaa,
        color: ColorManager.black,
        fontSize: FontSize.s22,
      );

  static TextStyle orderScreenTitleTextStyle(BuildContext? context) =>
      getBoldStyle(
        fontFamily: FontConstants.comfortaa,
        color: ColorManager.black,
        fontSize: FontSize.s22,
      );

  static TextStyle orderScreenDescriptionTextStyle(BuildContext? context) =>
      getRegularStyle(
        fontFamily: FontConstants.inter,
        color: ColorManager.grey,
        fontSize: FontSize.s14,
      );

  static TextStyle orderScreenButtonTextStyle(BuildContext? context) =>
      getBoldStyle(
        fontFamily: FontConstants.comfortaa,
        color: ColorManager.white,
        fontSize: FontSize.s24,
      );

  static TextStyle scanPageTitleTextStyle(BuildContext? context) =>
      getBoldStyle(
        fontSize: FontSize.s22,
        color: ColorManager.black,
        fontFamily: FontConstants.comfortaa,
      );

  static TextStyle scanPageScannedTextTextStyle(BuildContext? context) =>
      getBoldStyle(
        fontSize: FontSize.s22,
        color: ColorManager.black,
        fontFamily: FontConstants.comfortaa,
      );

  static TextStyle ticketPagedDialogTitleTextStyle(BuildContext? context) =>
      getBoldStyle(
        fontSize: FontSize.s18,
        color: ColorManager.black,
        fontFamily: FontConstants.comfortaa,
      );

  static TextStyle ticketPagedDialogBodyTextStyle(BuildContext? context) =>
      getRegularStyle(
        fontSize: FontSize.s14,
        color: ColorManager.black,
        fontFamily: FontConstants.comfortaa,
      );
}
