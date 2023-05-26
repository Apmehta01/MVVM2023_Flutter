import 'package:flutter/material.dart';
import 'package:mydemomvvm/utils/Constants.dart';
import 'package:mydemomvvm/utils/routes/routes_name.dart';
import 'package:mydemomvvm/view/home_screen.dart';
import 'package:mydemomvvm/view/login_screen.dart';

class Routes {

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.login:
        return MaterialPageRoute(
            builder: (BuildContext context) => const LoginScreen());
      case RoutesName.home:
        return MaterialPageRoute(
            builder: (BuildContext context) => const HomeScreen());
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
