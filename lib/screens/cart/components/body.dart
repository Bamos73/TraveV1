import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopapp/constants.dart';
import 'package:shopapp/screens/cart/components/cart_card.dart';
import 'package:shopapp/screens/cart/components/cart_empty.dart';
import 'package:shopapp/screens/cart/components/cart_item_card.dart';
import 'package:shopapp/screens/cart/components/header_cart.dart';
import 'package:shopapp/size_config.dart';
import '../../../components/shimmer_box.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(15)),
        child: Column(
          children: [
            SizedBox(height: getProportionateScreenHeight(5),),
            HeaderCart(),
            SizedBox(height: getProportionateScreenHeight(5),),
            Divider(thickness: 1, height: 1),
            CardCart(),
          ],
        ),
      ),
    );
  }
}

