import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:temp_house/presentation/common/widget/main-divider.dart';
import 'package:temp_house/presentation/main_layout/pages/home_screen/view/widgets/home_listView_iItem.dart';

import '../../../../common/widget/main_app_bar.dart';
import '../../../../resources/strings_manager.dart';
import '../../../../resources/text_styles.dart';

class AllPopularHome extends StatelessWidget {
  const AllPopularHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildMainAppBar(
        context,
        Text(
          AppStrings.popularStartedTextRow.tr(),
          style: AppTextStyles.loginTitleTextStyle(context),
        ),
      ),
      body: ListView.separated(
        itemCount: 10,
        itemBuilder: (context, index) {
          return const buildCarouselItem(
            color: Colors.white,
            text: '',
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Divider(
            indent: 22,
            thickness: .5,
            endIndent: 22,
            color: Colors.grey,
          );
        },
      ),
    );
  }
}
