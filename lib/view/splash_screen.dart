
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mydemomvvm/res/appColors.dart';
import 'package:mydemomvvm/services/splash_services.dart';
import '../animations/FadeAnimation.dart';
import '../res/components/gradientText.dart';
import '../utils/Constants.dart';
import '../utils/routes/routes_name.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashServices splashServices = SplashServices();

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      splashServices.checkPreference(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: <Widget>[
        headerDesign(),
        Padding(
      padding: const EdgeInsets.all(30.0),
      child: Stack(children: <Widget>[
        Positioned(
            child: FadeAnimation(
          1.6,
          Container(
            margin: const EdgeInsets.only(top: 50),
            child: Center(
              child: GradientText(
                text: Constants.STR_MVVMDEMO,
                gradient: LinearGradient(
                  colors: [
                    AppColors.COLORS_PRIMARY_ONE,
                    AppColors.COLORS_PRIMARY_TWO
                  ],
                ),
                style: const TextStyle(
                    fontSize: 50, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ))
      ]),
        )
      ]),
    );
  }

  Widget headerDesign() {
    return Container(
      height: 400,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/background.png'),
              fit: BoxFit.fill)),
    );
  }
}
