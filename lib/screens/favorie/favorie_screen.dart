import 'package:flutter/material.dart';
import 'package:shopapp/screens/favorie/components/body.dart';

class FavorieScreen extends StatelessWidget {
  const FavorieScreen({super.key});

  static String routeName="favorie";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Body(),
    );
  }
}

