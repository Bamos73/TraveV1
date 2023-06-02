import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/components/buttom_card.dart';
import 'package:shopapp/constants.dart';
import 'package:shopapp/screens/cart/cart_screen.dart';
import 'package:shopapp/screens/cart/components/test.dart';
import 'package:shopapp/screens/home/components/search_field.dart';
import 'package:shopapp/components/buttom_bell.dart';
import 'package:shopapp/size_config.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader({
    super.key,
  });

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(20),
        vertical: getProportionateScreenHeight(10)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SearchField(),
          ButtomCard(
            svgSrc: "assets/icons/shopping_bag.svg",
            press: () {
              Navigator.pushNamed(context, CartScreen.routeName);
              UpdateLivraisonAndPaiement();
            },
            height: 46,
            width: 46,
            padding: 10,
          ),
          ButtomBell(
            svgSrc: "assets/icons/notifications_active.svg",
            numOfItems: 3, // le nombre de Notification a parametrer après
            press: () {
                nextScreenReplace(context, MyApp());
            },
            height: 46,
            width: 46,
            padding: 10,
          ),
        ],
      ),
    );
  }

  void UpdateLivraisonAndPaiement() async {

    //Ajouter le mode de livraison et le mode de paiement
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      final userCardRefLiv = FirebaseFirestore.instance.collection('Livraison').doc('Mode_Livraison');
      final userCardDocLiv = await userCardRefLiv.get();

      if (userCardDocLiv.exists) {
        final userCardData = userCardDocLiv.data();

        //Changement du mode de Livraison par defaut a Régulier
        final userCardRefMode = FirebaseFirestore.instance.collection('users').doc(userId);
        await userCardRefMode.set({
          'frais_de_livraison': userCardData!['Regulier'],
        }, SetOptions(merge: true));

        //Changement du mode de paiement par defaut a Expèces
        final userCardRefPaie = FirebaseFirestore.instance.collection('users').doc(userId);
        await userCardRefPaie.set({
          'mode_de_paiement': 'Espèces',
        }, SetOptions(merge: true));

      }
    }
  }

}
