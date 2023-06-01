import 'package:flutter/material.dart';
import 'package:mydemomvvm/test/homePage.dart';
import 'package:mydemomvvm/utils/Constants.dart';
import 'package:mydemomvvm/utils/routes/routes_name.dart';
import 'package:mydemomvvm/view/home_screen.dart';
import 'package:mydemomvvm/view/login_view.dart';
import 'package:mydemomvvm/view/signup_view.dart';
import 'package:mydemomvvm/view/splash_screen.dart';

class Routes {

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splash:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SplashScreen());
      case RoutesName.login:
        return MaterialPageRoute(
            builder: (BuildContext context) => const LoginView());
      case RoutesName.home:
        return MaterialPageRoute(
            builder: (BuildContext context) => const HomeScreen());
      case RoutesName.homePage:
        return MaterialPageRoute(
            builder: (BuildContext context) => HomePage());
      case RoutesName.signup_screen:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SignupView());
      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text(Constants.NO_SCREEN_FOUND),
            ),
          );
        });
    }
  }
}
