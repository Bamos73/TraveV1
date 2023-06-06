import 'package:flutter/material.dart';
import 'package:shopapp/screens/Privacy_Policy/components/body.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);
  static String routeName = "/Privacy_Policy";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Politique de confidentialité"),
        centerTitle: true,
      ),
      body: Body(),
    );
  }
}
