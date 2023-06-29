import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopapp/components/button_retour.dart';
import 'package:shopapp/components/buttom_card.dart';
import 'package:shopapp/constants.dart';
import 'package:shopapp/models/Cart.dart';
import 'package:shopapp/screens/cart/cart_screen.dart';
import 'package:shopapp/components/buttom_bell.dart';
import 'package:shopapp/size_config.dart';

class CustomAppBar extends StatefulWidget {
  final DocumentSnapshot<Map<String, dynamic>>? product;

  const CustomAppBar({Key? key, required this.product}) : super(key: key);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10)),
      child: Column(
        children: [
          SizedBox(height: getProportionateScreenHeight(10)),
          Row(
            children: [
              ButtonRetour(),
              const Spacer(),
              ButtomCard(
                svgSrc: "assets/icons/shopping_bag.svg",
                height: 35,
                width: 35,
                padding: 5,
              ),
              const SizedBox(width: 10),
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    Text(
                      "${widget.product?.data()?['rating'] ?? ''}",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 5),
                    SvgPicture.asset("assets/icons/Star Icon.svg"),
                  ],
                ),
              )
            ],
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
          'mode_de_livraison': 'Regulier',
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
