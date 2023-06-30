// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shopapp/screens/plus/components/body.dart';
import 'package:shopapp/service/internet_check.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  static String routeName = "/profil";

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

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
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            "PLUS",
          ),
          centerTitle: true,
        ),
        body: Body(),
      ),
    );
  }
}
