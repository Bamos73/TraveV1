// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shopapp/screens/complete_profile/components/body.dart';

class CompleteProfileScreen extends StatelessWidget {
  const CompleteProfileScreen({Key? key}) : super(key: key);
  static String routeName = "/complete_profile";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Sign Up",
        ),
        centerTitle: true,
      ),
      body: Body(),
    );
  }
}
