import 'package:flutter/material.dart';
import 'package:shopapp/screens/my_account/compenenents/body.dart';

class MyAccountScreen extends StatelessWidget {
  const MyAccountScreen({Key? key}) : super(key: key);

  static String routeName="/my_account";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mon compte"),
        centerTitle: true,
      ),
      body: Body(),
    );
  }
}
