import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
import 'package:temp_house/presentation/main_layout/pages/profile_screen/view/widgets/profile_image.dart';
import 'package:temp_house/presentation/resources/color_manager.dart';
import 'package:temp_house/presentation/resources/routes_manager.dart';
import 'package:temp_house/presentation/resources/text_styles.dart';

import '../../../../../resources/strings_manager.dart';
import '../../../../../resources/values_manager.dart';
import '../../../home_screen/view/widgets/feed_back.dart';
import 'bottom_sheet_item.dart';
import 'country_selection_modal.dart';
import 'language_selection_modal.dart';
import 'measurement_selection_modal.dart';

class ProfileBody extends StatefulWidget {
  ProfileBody({super.key});

  @override
  State<ProfileBody> createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  String selectedLanguage = 'English';
  String selectedMeasurement = 'Metric (m^2 , Km)';
  String selectedCountry = 'Egypt';

  void _showLanguageSelectionModal(BuildContext context) {
    LanguageSelectionModal().show(context, (selectedLanguage) {
      setState(() {
        this.selectedLanguage = selectedLanguage;
      });
    });
  }

  void _showMeasurementSelectionModal(BuildContext context) {
    MeasurementSelectionModal().show(context, (selectedMeasurement) {
      setState(() {
        this.selectedMeasurement = selectedMeasurement;
      });
    });
  }

  void _showCountrySelectionModal(BuildContext context) {
    CountrySelectionModal().show(context, (selectedCountry) {
      setState(() {
        this.selectedCountry = selectedCountry;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, Routes.personalInfoRoute);
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: AppPadding.p20),
                child: ProfileImage(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p32),
              child: Text(
                AppStrings.profileSetting.tr(),
                style: AppTextStyles.profileSettingTextStyle(),
              ),
            ),
            ModelSheetItem(
              subTitle: selectedLanguage,
              onTap: () => _showLanguageSelectionModal(context),
              title: AppStrings.profileLanguage.tr(),
            ),
            ModelSheetItem(
              subTitle: selectedCountry,
              onTap: () => _showCountrySelectionModal(context),
              title: AppStrings.profileCountry.tr(),
            ),
            ModelSheetItem(
              subTitle: selectedMeasurement,
              onTap: () => _showMeasurementSelectionModal(context),
              title: AppStrings.profileMeasurement.tr(),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: AppPadding.p30, right: AppPadding.p40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(AppStrings.paymentDetailsScreen.tr(),
                      style: AppTextStyles.profileSettingInfoTextStyle()),
                  const Icon(Icons.arrow_forward_ios)
                ],
              ),
            ),
            const Divider(color: ColorManager.grey),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p32),
              child: Text(AppStrings.profilePropertyFinder.tr(),
                  style: AppTextStyles.profileSettingTextStyle()),
            ),
            AppSettingItem(
              text: AppStrings.profileAbout.tr(),
              onTap: () {
                Navigator.pushNamed(context, Routes.aboutScreenRoute);
              },
            ),
            AppSettingItem(
              text: AppStrings.rateUsScreenName.tr(),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return RatingDialog();
                  },
                );
              },
            ),
            AppSettingItem(
              text: AppStrings.needHelpScreenName.tr(),
              onTap: () {
                Navigator.pushNamed(context, Routes.needHelpScreenRoute);
              },
            ),
          ],
        ),
      ),
    );
  }
}
