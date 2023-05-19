import 'package:flutter/material.dart';
import 'package:shopapp/models/cart.dart';
import 'package:shopapp/screens/cart/components/body.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);
 static String routeName="/cart";

  @override
  State<CartScreen> createState() => _CartScreenState();
}
class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Body(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Column(
        children: [
          Text("Your Cart",
            style: TextStyle(
              color:Colors.black,
            ),
          ),
          Text("${demoCarts.length} items",style: Theme.of(context).textTheme.caption,)
        ],
      ),
      centerTitle: true,
    );
  }
}
