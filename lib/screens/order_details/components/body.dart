import 'package:flutter/material.dart';
import 'package:shopapp/screens/ORDER/components/custom_app_bar.dart';
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
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(height: getProportionateScreenHeight(60),),
              ],
            ),
            CustomAppBar(),
          ],
        )
    );
  }
}
