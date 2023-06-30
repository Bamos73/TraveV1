import 'package:flutter/material.dart';
import 'package:shopapp/screens/favory/components/card_favorie.dart';
import 'package:shopapp/screens/home/components/home_header.dart';
import 'package:shopapp/size_config.dart';
import 'package:shopapp/screens/favory/components/custom_app_bar.dart';

class Body extends StatelessWidget {
  const Body({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(height: getProportionateScreenHeight(60),),
                CardFavorie(),
              ],
            ),
            CustomAppBar(),
          ],

        )
    );
  }
}
