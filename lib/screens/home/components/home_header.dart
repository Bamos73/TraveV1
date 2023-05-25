import 'package:flutter/material.dart';
import 'package:shopapp/components/buttom_card.dart';
import 'package:shopapp/constants.dart';
import 'package:shopapp/screens/cart/cart_screen.dart';
import 'package:shopapp/screens/cart/components/test.dart';
import 'package:shopapp/screens/home/components/search_field.dart';
import 'package:shopapp/components/buttom_bell.dart';
import 'package:shopapp/screens/profil/profil_screen.dart';
import 'package:shopapp/size_config.dart';

import '../../../models/Cart.dart';
class HomeHeader extends StatefulWidget {
  const HomeHeader({
    super.key,
  });

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SearchField(),
          ButtomCard(
            svgSrc: "assets/icons/shopping_bag.svg",
            press: () =>Navigator.pushNamed(context, CartScreen.routeName), height: 46, width: 46, padding: 10,
          ),
          ButtomBell(
            svgSrc: "assets/icons/notifications_active.svg",
            numOfItems: 3, // le nombre de Notification a parametrer après
            press: () {
                nextScreenReplace(context, MyApp());

            }, height: 46, width: 46, padding: 10,
          ),
        ],
      ),
    );
  }
}
