import 'package:flutter/material.dart';
import 'package:shopapp/screens/sign_up/components/body.dart';

import '../../service/internet_check.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);
  static String routeName="/sign_up";

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  InternetCheck internetCheck = InternetCheck();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    internetCheck.startStreaming(context); // Passer le contexte
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sign up',
          textAlign: TextAlign.center,
        ),
        centerTitle: true, // Permet de centrer automatiquement le titre dans l'AppBar
      ),
      body: Body(),
    );
  }
}
