import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temp_house/app/extensions.dart';
import 'package:temp_house/domain/models/domain.dart';
import 'package:temp_house/presentation/base/base_states.dart';
import 'package:temp_house/presentation/base/cubit_builder.dart';
import 'package:temp_house/presentation/base/cubit_listener.dart';
import 'package:temp_house/presentation/homes_map_screen/view/homes_map_body.dart';
import 'package:temp_house/presentation/homes_map_screen/view/widgets/home_details.dart';
import 'package:temp_house/presentation/homes_map_screen/viewmodel/homes_map_viewmodel.dart';
import 'package:temp_house/presentation/homes_map_screen/viewmodel/states/homes_map_states.dart';
import 'package:temp_house/presentation/resources/color_manager.dart';
import 'package:temp_house/presentation/resources/values_manager.dart';

class HomesMapScreen extends StatelessWidget {
  const HomesMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: BlocProvider(
        create: (context) => HomesMapViewModel()..start(),
        child: BlocConsumer<HomesMapViewModel, BaseStates>(
          listener: (context, state) {
            if (state is HomeClickedState) {
              showHomeDetails(context, state.home);
            }
            baseListener(context, state);
          },
          builder: (context, state) {
            return baseBuilder(context, state, HomesMapBody());
          },
        ),
      ),
    );
  }

  showHomeDetails(BuildContext context, HomeModel home) {
    showModalBottomSheet(
      showDragHandle: true,
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      barrierColor: ColorManager.black.withOpacity(.2),
      constraints: BoxConstraints(
        maxHeight: context.height() * .8,
        minWidth: AppSize.infinity,
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: AppSize.s0_5,
        maxChildSize: AppSize.s1,
        minChildSize: AppSize.s0_5,
        expand: false,
        builder: (context, controller) {
          return HomeDetails(
            controller: controller,
            home: home,
          );
        },
      ),
    );
  }
}
