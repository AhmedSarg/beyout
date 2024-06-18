import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temp_house/presentation/base/base_states.dart';
import 'package:temp_house/presentation/base/cubit_builder.dart';
import 'package:temp_house/presentation/base/cubit_listener.dart';
import 'package:temp_house/presentation/offers_screen/states/offers_states.dart';
import 'package:temp_house/presentation/offers_screen/view/offers_body.dart';
import 'package:temp_house/presentation/offers_screen/view/offers_empty.dart';
import 'package:temp_house/presentation/offers_screen/viewmodel/offers_viewmodel.dart';
import 'package:temp_house/presentation/resources/color_manager.dart';

import '../../common/widget/main_app_bar.dart';
import '../../resources/font_manager.dart';
import '../../resources/strings_manager.dart';
import '../../resources/text_styles.dart';

class OffersScreen extends StatelessWidget {
  const OffersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.offwhite,
      appBar: buildMainAppBar(
        context,
        Text(
          AppStrings.offerScreenTitle.tr(),
          style: AppTextStyles.homeGeneralTextStyle(
              context, ColorManager.white, FontSize.f24),
        ),
        ColorManager.primary,
      ),
      body: BlocProvider(
        create: (context) => OffersViewModel()..start(),
        child: BlocConsumer<OffersViewModel, BaseStates>(
          listener: (context, state) {
            if (state is ErrorState ||
                state is OfferAcceptedState ||
                state is OfferDeclinedState) {
              Navigator.pop(context);
            }
            baseListener(context, state);
          },
          builder: (context, state) {
            if (state is EmptyState) {
              return const OffersEmpty();
            }
            return baseBuilder(context, state, const OffersBody());
          },
        ),
      ),
    );
  }
}
