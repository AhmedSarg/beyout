import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:temp_house/presentation/login_screen/view/loginScreen.dart';
import 'package:temp_house/presentation/onboarding_screen/view/onboardingScreen.dart';

import '../../app/sl.dart';
import '../SplashScreen/view/splashScreen.dart';
import '../getStart_screen/view/getStartScreen.dart';
import 'strings_manager.dart';

class Routes {
  Routes._();

  static const String splashRoute = "/";
  static const String onboardingRoute = "/onboardingRoute";
  static const String getStartingRoute = "/getStart";
  static const String loginRoute = "/login";

}

class RouteGenerator {
  RouteGenerator._();

  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
         return MaterialPageRoute(builder: (_) => const SplashScreen());
      case Routes.onboardingRoute:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());

        case Routes.getStartingRoute:
      return MaterialPageRoute(builder: (_) => const GetStartScreen());
      case Routes.loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: Text(AppStrings.noRouteFound.tr()),
        ),
        body: Center(child: Text(AppStrings.noRouteFound.tr())),
      ),
    );
  }
}
