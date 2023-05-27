
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopapp/screens/splash_screen.dart';

class SplashScreenFirst extends StatelessWidget {
  const SplashScreenFirst({Key? key}) : super(key: key);
  static String routeName = "/splash";
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        splash: Column(
          children: [
            SvgPicture.asset("assets/logo/LOGO Trave SVG SANS BG/logo_svg_purple.svg"),
          ],
        ),
        backgroundColor: Color(0xFF7e55f2),
        nextScreen: SplashScreen());
  }
}
