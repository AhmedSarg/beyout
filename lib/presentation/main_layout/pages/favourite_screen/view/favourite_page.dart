import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:temp_house/presentation/main_layout/pages/favourite_screen/view/widgets/favourite_body.dart';

import '../../../../common/widget/main_app_bar.dart';
import '../../../../resources/color_manager.dart';
import '../../../../resources/strings_manager.dart';
import '../../../../resources/text_styles.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: MainAppBar(
      //   title: Text(
      //     StringsManager.favouraiteScreenTitle.tr(),
      //     style: TextStyles.notificationsScreenTitleTextStyle(context),
      //   ),
      // ),
      backgroundColor: ColorManager.offwhite,
      body: FavouriteBody(),
    );
  }
}
