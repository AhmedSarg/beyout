import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temp_house/presentation/app/viewmodel/app_viewmodel.dart';
import 'package:temp_house/presentation/base/base_states.dart';

import '../../../app/sl.dart';
import '../../resources/routes_manager.dart';
import '../../resources/theme_manager.dart';

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    initGetOffersStreamUseCase();
    initGetOffersUseCase();
    return BlocProvider(
      create: (context) => AppViewModel()..start(),
      child: BlocBuilder<AppViewModel, BaseStates>(
        builder: (context, state) {
          AppViewModel viewModel = AppViewModel.get(context);
          return MaterialApp(
            navigatorKey: viewModel.getNavigatorKey,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            debugShowCheckedModeBanner: false,
            initialRoute: Routes.splashRoute,
            theme: getApplicationTheme(),
            onGenerateRoute: RouteGenerator.getRoute,
          );
        },
      ),
    );
  }
}
