import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temp_house/presentation/app/viewmodel/app_viewmodel.dart';
import 'package:temp_house/presentation/base/base_states.dart';

import '../../resources/routes_manager.dart';
import '../../resources/theme_manager.dart';

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppViewModel()..start(),
      child: BlocListener<AppViewModel, BaseStates>(
        listener: (context, state) {},
        child: MaterialApp(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          debugShowCheckedModeBanner: false,
          initialRoute: Routes.splashRoute,
          theme: getApplicationTheme(),
          onGenerateRoute: RouteGenerator.getRoute,
        ),
      ),
    );
  }
}
