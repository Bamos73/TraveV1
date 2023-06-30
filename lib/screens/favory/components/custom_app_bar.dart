import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopapp/components/button_retour.dart';
import 'package:shopapp/components/buttom_card.dart';
import 'package:shopapp/constants.dart';
import 'package:shopapp/models/Cart.dart';
import 'package:shopapp/screens/cart/cart_screen.dart';
import 'package:shopapp/components/buttom_bell.dart';
import 'package:shopapp/size_config.dart';

class CustomAppBar extends StatefulWidget {


  const CustomAppBar({Key? key}) : super(key: key);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10)),
      child: Column(
        children: [
          SizedBox(height: getProportionateScreenHeight(10)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ButtonRetourHome(),
              Text("LISTE"),
              ButtomCard(
                svgSrc: "assets/icons/shopping_bag.svg",
                height: 35,
                width: 35,
                padding: 5,
              ),
            ],
          ),
        ],
      ),
    );
  }

}


