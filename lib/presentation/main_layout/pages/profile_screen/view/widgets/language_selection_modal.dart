import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:temp_house/presentation/resources/color_manager.dart';
import 'package:temp_house/presentation/resources/text_styles.dart';

import '../../../../../resources/langauge_manager.dart';
import '../../../../../resources/strings_manager.dart';
import '../../../../../resources/values_manager.dart';

class LanguageSelectionModal {
  void show(BuildContext context, Function(String) onSelect) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return _buildLanguageSelectionModal(context, onSelect);
      },
    );
  }

  Widget _buildLanguageSelectionModal(BuildContext context, Function(String) onSelect) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppPadding.p22),
      height: MediaQuery.of(context).size.height * 0.3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(height: AppSize.s4,width: AppPadding.p40,
            decoration: BoxDecoration(
              color: ColorManager.grey,
              borderRadius: BorderRadius.circular(AppSize.s20)
            ),
            ),
          ),
          Text(AppStrings.profileLanguage.tr(),style: AppTextStyles.profileSettingTextStyle()),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppPadding.p16),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    onSelect(AppStrings.profileLanguageEnglish.tr());
                    AppLanguages.toggleLocal(context);
                    Navigator.pop(context);
                  },
                  child: Text(AppStrings.profileLanguageEnglish.tr(),style: AppTextStyles.profileSettingInfoTextStyle()),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppPadding.p16),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    onSelect(AppStrings.profileLanguageArabic.tr());
                    AppLanguages.toggleLocal(context);
                    Navigator.pop(context);
                  },
                  child: Text(AppStrings.profileLanguageArabic.tr(),style: AppTextStyles.profileSettingInfoTextStyle(),),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
