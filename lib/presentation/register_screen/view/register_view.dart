import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../base/base_states.dart';
import '../../base/cubit_builder.dart';
import '../../base/cubit_listener.dart';
import '../../common/widget/main_app_bar.dart';
import '../../resources/strings_manager.dart';
import '../../resources/text_styles.dart';
import '../viewmodel/register_viewmodel.dart';
import 'widgets/register_body_widget.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildMainAppBar(
        context,
        Text(
          AppStrings.registerScreenTitle.tr(),
          style: AppTextStyles.registerTitleTextStyle(context),
        ),
      ),
      body: BlocProvider(
        create: (_) => RegisterViewModel()..start(),
        child: BlocConsumer<RegisterViewModel, BaseStates>(
          listener: (context, state) {
            baseListener(context, state);
          },
          builder: (context, state) {
            return baseBuilder(context, state, RegisterBody(viewModel: RegisterViewModel(),));
          },
        ),
      ),
    );
  }
}
