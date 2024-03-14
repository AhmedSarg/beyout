import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:temp_house/presentation/common/widget/main_app_bar.dart';

import '../../resources/strings_manager.dart';
import '../../resources/text_styles.dart';
import 'widgets/login_body.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildMainAppBar(context,Text(
          AppStrings.loginScreenTitle.tr(),
          style: AppTextStyles.loginTitleTextStyle(context),
        ),),
      body: const LoginBody(),
    );
  }
}
