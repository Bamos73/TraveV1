import 'package:flutter/material.dart';
import 'package:shopapp/screens/Privacy_Policy/components/body.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);
  static String routeName = "/Privacy_Policy";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("politique de confidentialité"),
        centerTitle: true,
      ),
      body: Body(),
    );
  }
}
