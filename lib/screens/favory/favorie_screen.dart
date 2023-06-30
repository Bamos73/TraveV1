import 'package:flutter/material.dart';
import 'package:shopapp/screens/favory/components/body.dart';
import 'package:shopapp/service/internet_check.dart';

class FavorieScreen extends StatefulWidget {
  const FavorieScreen({super.key});

  static String routeName="favorie";

  @override
  State<FavorieScreen> createState() => _FavorieScreenState();
}

class _FavorieScreenState extends State<FavorieScreen> {

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
        body: Body(),
    );
  }
}

