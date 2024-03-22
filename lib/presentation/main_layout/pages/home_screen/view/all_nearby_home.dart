import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:temp_house/presentation/common/widget/main-divider.dart';
import 'package:temp_house/presentation/main_layout/pages/home_screen/view/widgets/home_listView_iItem.dart';
import 'package:temp_house/presentation/main_layout/pages/home_screen/view/widgets/near_by_home_item.dart';
import 'package:temp_house/presentation/resources/color_manager.dart';
import 'package:temp_house/presentation/resources/values_manager.dart';

import '../../../../common/widget/main_app_bar.dart';
import '../../../../resources/strings_manager.dart';
import '../../../../resources/text_styles.dart';

class AllNearByHome extends StatelessWidget {
  const AllNearByHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.offwhite,

      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return const Padding(
            padding: EdgeInsets.all(AppPadding.p8),
            child: NearByHomeItem(

            ),
          );
        },
      ),
    );
  }
}
