import 'package:flutter/material.dart';
import 'package:plinko/views/home/home_screen.dart';
import 'package:plinko/views/splash/splash_screen.dart';
import 'constants/string_constants.dart';

class Router {
  Router();

  Route<dynamic>? routes(RouteSettings settings) {
    switch (settings.name) {
      case StringConstants.SPLASH_PAGE:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
          settings: settings,
        );
      case StringConstants.HOME_PAGE:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
          settings: settings,
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
          settings: settings,
        );
    }
  }
}
