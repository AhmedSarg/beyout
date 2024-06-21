import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temp_house/presentation/main_layout/pages/profile_screen/view/widgets/profile_body.dart';

import '../../../../../app/sl.dart';
import '../../../../base/base_states.dart';
import '../../../../base/cubit_builder.dart';
import '../../../../base/cubit_listener.dart';
import '../../../../login_screen/viewmodel/login_viewmodel.dart';
import '../../../../resources/routes_manager.dart';
import '../viewmodel/stats.dart';
import '../viewmodel/viewmodel.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => ProfileViewModel(sl())..start(),
        child: BlocConsumer<ProfileViewModel, BaseStates>(
          listener: (context, state) {
            if (state is LogoutState) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                Routes.loginRoute,
                ModalRoute.withName('/'),
              );
            }
            baseListener(context, state);
          },
          builder: (context, state) {
            return baseBuilder(
              context,
              state,
              ProfileBody(
                viewModel: ProfileViewModel.get(context),
              ),
            );
          },

        ),
      ),
    );
  }

}
