import 'package:flutter/material.dart';

import 'package:shopapp/screens/forgot_password/components/body.dart';


class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);
  static String routeName= "/forgot_password";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forgot Password",
        textAlign: TextAlign.center,),
        centerTitle: true,
      ),
      body: Body(),
    );

  }
}
