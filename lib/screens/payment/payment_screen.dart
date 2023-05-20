import 'package:flutter/material.dart';
import 'package:shopapp/screens/payment/components/body.dart';
import 'package:shopapp/size_config.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({Key? key}) : super(key: key);
  static String routeName='/payment';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F6F9),
      appBar: AppBar(
        title: Text("PAIEMENT SECURISE",style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: getProportionateScreenWidth(15),
          color: Colors.black,
        ),),
        centerTitle: true,
          leading: Icon(Icons.arrow_back_ios,weight: 100,)
      ),
        body: Body(),
    );
  }
}
