import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temp_house/presentation/share_post_screen/view/widgets/share_screen_body.dart';
import 'package:temp_house/presentation/share_post_screen/viewmodel/share_view_model.dart';

import '../../base/base_states.dart';
import '../../base/cubit_builder.dart';
import '../../base/cubit_listener.dart';
import '../../common/widget/main_app_bar.dart';
import '../../resources/strings_manager.dart';
import '../../resources/text_styles.dart';

class SharePostScreen extends StatelessWidget {
  const SharePostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildMainAppBar(
        context,
        Text(
          AppStrings.publishHomeAppBarTextRow.tr(),
          style: AppTextStyles.loginTitleTextStyle(context),
        ),
      ),
      body: BlocProvider(
        create: (context) => ShareViewModel()..start(),
        child: BlocConsumer<ShareViewModel, BaseStates>(
          listener: (context, state) {
            baseListener(context, state);
          },
          builder: (context, state) {
            // UserRole? userRole = DataIntent.getUserRole();
            return baseBuilder(
              context,
              state,
               SharePostScreenBody(viewModel: ShareViewModel(),),
            );
          },
        ),
      ),
    );
  }
}
