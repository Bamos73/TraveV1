import 'package:flutter/material.dart';
import 'package:shopapp/screens/Term_And_Condition/components/body.dart';

class TermAndConditionScreen extends StatelessWidget {
  const TermAndConditionScreen({Key? key}) : super(key: key);
  static String routeName = "/Term_And_Condition";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Termes et conditions"),
        centerTitle: true,
      ),
      body: Body(),
    );
  }
}
