import 'package:flutter/material.dart';
import 'package:shopapp/screens/Privacy_Policy/components/body.dart';

import '../../service/internet_check.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);
  static String routeName = "/Privacy_Policy";

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {

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
