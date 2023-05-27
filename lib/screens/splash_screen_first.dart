import 'dart:async';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/constants.dart';
import 'package:shopapp/provider/sign_in_provider.dart';
import 'package:shopapp/screens/home/home_screen.dart';
import 'package:shopapp/screens/splash_screen.dart';
import 'package:shopapp/size_config.dart';


class SplashScreenFirst extends StatefulWidget {
  const SplashScreenFirst({Key? key}) : super(key: key);
  static String routeName = "/splash";

  @override
  State<SplashScreenFirst> createState() => _SplashScreenFirstState();
}

class _SplashScreenFirstState extends State<SplashScreenFirst> {
  @override
  void initState() {
    final sp=context.read<SignInProvider>();
    super.initState();

    Timer(const Duration(seconds :2) ,(){
      sp.isSignedIn==false
          ? nextScreenReplace(context,SplashScreen())
          :nextScreenReplace(context, HomeScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return AnimatedSplashScreen(
      splash: SvgPicture.asset("assets/logo/logo_svg_purple.svg"),
      backgroundColor: Color(0xFF7e55f2),
      splashIconSize: 200,
      duration: 3000,
      nextScreen: SplashScreen(),
    );
  }
}


