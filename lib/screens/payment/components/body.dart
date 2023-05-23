import 'package:flutter/material.dart';
import 'package:shopapp/screens/payment/components/card_adresse.dart';
import 'package:shopapp/screens/payment/components/card_livraison.dart';
import 'package:shopapp/screens/payment/components/card_number.dart';
import 'package:shopapp/screens/payment/components/card_paiement.dart';
import 'package:shopapp/screens/payment/components/card_panier.dart';
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


