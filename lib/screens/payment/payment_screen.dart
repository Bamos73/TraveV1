import 'package:flutter/material.dart';
import 'package:shopapp/constants.dart';
import 'package:shopapp/screens/cart/cart_screen.dart';
import 'package:shopapp/screens/payment/components/body.dart';
import 'package:shopapp/screens/payment/components/custom_nav_bar_payment.dart';
import 'package:shopapp/size_config.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  static String routeName = '/payment';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F6F9),
      appBar: AppBar(
        title: Text(
          "PAIEMENT SECURISE",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: getProportionateScreenWidth(15),
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            nextScreenReplace(context, CartScreen()) ;
          },
        ),
      ),
      body: Body(),
      bottomNavigationBar: CustomNavBarPayment(),
    );
  }
}