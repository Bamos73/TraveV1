import 'package:flutter/material.dart';
import 'package:shopapp/constants.dart';
import 'package:shopapp/screens/cart/cart_screen.dart';
import 'package:shopapp/screens/payment/components/body.dart';
import 'package:shopapp/screens/payment/components/custom_nav_bar_payment.dart';
import 'package:shopapp/service/internet_check.dart';
import 'package:shopapp/size_config.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  static String routeName = '/payment';

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {

  InternetCheck internetCheck = InternetCheck();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    internetCheck.startStreaming(context); // Passer le contexte
  }

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
            Navigator.pushNamed(context, CartScreen.routeName);
          },
        ),
      ),
      body: Body(),
      bottomNavigationBar: CustomNavBarPayment(),
    );
  }
}
