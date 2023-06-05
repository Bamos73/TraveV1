import 'package:flutter/material.dart';
import 'package:shopapp/screens/home/components/home_header.dart';
import 'package:shopapp/size_config.dart';

class Body extends StatefulWidget {
  const Body({
    super.key,
  });

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
          children: [
            HomeHeader(),
            SizedBox(height: getProportionateScreenHeight(10),),
          ],
        )
    );
  }
}