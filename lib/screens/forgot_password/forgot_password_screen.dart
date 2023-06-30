import 'package:flutter/material.dart';

import 'package:shopapp/screens/forgot_password/components/body.dart';
import 'package:shopapp/service/internet_check.dart';


class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);
  static String routeName= "/forgot_password";

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {

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
        title: Text("",
        textAlign: TextAlign.center,),
        centerTitle: true,
      ),
      body: Body(),
    );

  }
}
