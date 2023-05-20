import 'package:flutter/material.dart';
import 'package:shopapp/screens/payment/components/body.dart';
import 'package:shopapp/screens/payment/components/livraison_card.dart';
import 'package:shopapp/screens/payment/components/paiement_card.dart';
import 'package:shopapp/screens/payment/components/panier_card.dart';
import 'package:shopapp/size_config.dart';

import 'components/adresse_card.dart';

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
        leading: Icon(Icons.arrow_back_ios, weight: 100),
      ),
      body: Body(),
      bottomNavigationBar: Container(
        height: kBottomNavigationBarHeight,
        color: Colors.white,
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: getProportionateScreenHeight(10),
                    horizontal: getProportionateScreenWidth(20),
                  ),
                  child: Text(
                    "RESUME DE LA COMMANDE",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: getProportionateScreenHeight(14),
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
