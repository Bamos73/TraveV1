import 'package:flutter/material.dart';
import 'package:shopapp/screens/favory/components/card_favorie.dart';
import 'package:shopapp/screens/home/components/home_header.dart';
import 'package:shopapp/size_config.dart';

class Body extends StatelessWidget {
  const Body({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
          children: [
            HomeHeader(),
            SizedBox(height: getProportionateScreenHeight(10),),
            CardFavorie(),
          ],
        )
    );
  }
}
