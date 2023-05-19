import 'package:flutter/material.dart';
import 'package:shopapp/screens/otp/components/body.dart';

class OTPScreen extends StatelessWidget {
  const OTPScreen({Key? key}) : super(key: key);
  static String routeName="/otp";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("OTP Verification"),
        centerTitle: true,
      ),
      body: Body(),
    );
  }
}
