import 'package:flutter/material.dart';
import 'package:shopapp/screens/sign_in/components/Body.dart';
import 'package:shopapp/screens/splash_screen.dart';
import 'package:shopapp/service/internet_check.dart';

class SignInScreen extends StatefulWidget {
  static String routeName = "/sign_in";

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
final GlobalKey _scaffoldKey=GlobalKey<ScaffoldState>();

InternetCheck internetCheck = InternetCheck();

@override
void initState() {
  // TODO: implement initState
  super.initState();
  internetCheck.startStreaming(context); // Passer le contexte
}

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        // rediriger l'utilisateur vers la page spécifique ici
        Navigator.pushReplacement(context,
          MaterialPageRoute(
            builder: (BuildContext context) => SplashScreen(),
          ),
        );
        return Future.value(false);
      },
      child: Scaffold(
        key: _scaffoldKey,

        body: Body(),
      ),
    );
  }
}