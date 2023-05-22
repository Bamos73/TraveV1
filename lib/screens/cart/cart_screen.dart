
import 'package:flutter/material.dart';
import 'package:shopapp/screens/cart/components/body.dart';
import 'package:shopapp/screens/cart/components/custom_nav_bar.dart';

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



