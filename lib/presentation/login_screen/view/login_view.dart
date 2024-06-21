import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:temp_house/presentation/login_screen/viewmodel/states/login_states.dart';
import 'package:temp_house/presentation/resources/assets_manager.dart';
import 'package:temp_house/presentation/resources/color_manager.dart';

import '../../../app/sl.dart';
import '../../base/base_states.dart';
import '../../base/cubit_builder.dart';
import '../../base/cubit_listener.dart';
import '../../common/widget/main_app_bar.dart';
import '../../resources/routes_manager.dart';
import '../../resources/strings_manager.dart';
import '../../resources/text_styles.dart';
import '../viewmodel/login_viewmodel.dart';
import 'widgets/login_body.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildMainAppBar(
        context,
        Text(
          AppStrings.loginScreenTitle.tr(),
          style: AppTextStyles.loginTitleTextStyle(context),
        ),
      ),
      body: BlocProvider(
        create: (_) => LoginViewModel(sl(), sl(), sl())..start(),
        child: BlocConsumer<LoginViewModel, BaseStates>(
          listener: (context, state) {
            if (state is ErrorState) {
              Navigator.pop(context);
            } else if (state is SuccessState) {
              Navigator.pop(context);
              Navigator.pushNamedAndRemoveUntil(
                context,
                Routes.mainLayoutRoute,
                ModalRoute.withName('/'),
              );
            } else if (state is SocialLoginState) {
              Navigator.pushNamed(context, Routes.registerRoute);
            } else if (state is ResetPasswordState) {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Column(
                      children: [
                        Lottie.asset(LottieAssets.success),
                        Text(
                          'password reset link sent! check your email',
                          style: AppTextStyles.baseStatesMessageTextStyle(
                              context, ColorManager.white),
                        ),
                      ],
                    ),
                  );
                },
              );
            }
            baseListener(context, state);
          },
          builder: (context, state) {
            return baseBuilder(
              context,
              state,
              LoginBody(
                viewModel: LoginViewModel.get(context),
              ),
            );
          },
        ),
      ),
    );
  }
}
