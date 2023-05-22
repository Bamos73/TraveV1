import 'package:flutter/material.dart';
import 'package:shopapp/screens/payment/components/adresse_card.dart';
import 'package:shopapp/screens/payment/components/livraison_card.dart';
import 'package:shopapp/screens/payment/components/number_card.dart';
import 'package:shopapp/screens/payment/components/paiement_card.dart';
import 'package:shopapp/screens/payment/components/panier_card.dart';
import 'package:shopapp/size_config.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            PanierPayment(),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: getProportionateScreenHeight(10),
                    horizontal: getProportionateScreenWidth(20)
                  ),
                  child: Text("ETAPES DE PAIEMENT",style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: getProportionateScreenHeight(14),
                    color: Colors.black87,
                  ),),
                ),
              ],
            ),
            ListPaymentAdresse(),
            Divider(height: 1,thickness: 1,),
            ListPaymentLivraison(),
            Divider(height: 1,thickness: 1,),
            ListPaymentNumber(),
            Divider(height: 1,thickness: 1,),
            ListPaymentPaiement(),

          ],
        ),
      ),
    );
  }
}


