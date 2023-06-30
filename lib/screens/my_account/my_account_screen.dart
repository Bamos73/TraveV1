import 'package:flutter/material.dart';
import 'package:shopapp/screens/my_account/compenenents/body.dart';

import '../../service/internet_check.dart';

class MyAccountScreen extends StatefulWidget {
  const MyAccountScreen({Key? key}) : super(key: key);

  static String routeName="/my_account";

  @override
  State<MyAccountScreen> createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {

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
        title: Text("Mon compte"),
        centerTitle: true,
      ),
      body: Body(),
    );
  }
}
