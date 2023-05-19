// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shopapp/components/default_button.dart';
import 'package:shopapp/constants.dart';
import 'package:shopapp/models/cart.dart';
import 'package:shopapp/screens/cart/components/body.dart';
import 'package:shopapp/screens/cart/components/custom_nav_bar.dart';
import 'package:shopapp/size_config.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);
  static String routeName = "/cart";

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
      bottomNavigationBar: CheckOurCard(),
    );
  }
}



