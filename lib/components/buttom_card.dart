import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopapp/constants.dart';
import 'package:shopapp/screens/cart/cart_screen.dart';
import 'package:shopapp/size_config.dart';


class ButtomCard extends StatefulWidget {
  const ButtomCard({
    Key? key,
    required this.svgSrc,
    required this.height,
    required this.width,
    required this.padding,
  }) : super(key: key);

  final String svgSrc;
  final double height, width, padding;

  @override
  _ButtomCardState createState() => _ButtomCardState();
}

class _ButtomCardState extends State<ButtomCard> {
  Stream<int> _numOfItemsStream = FirebaseFirestore.instance
      .collection('Card')
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .collection(FirebaseAuth.instance.currentUser!.uid)
      .snapshots()
      .map((querySnapshot) => querySnapshot.size);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: _numOfItemsStream,
      builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
        if (!snapshot.hasData) {
          return CardButton(widget: widget, numOfItems: 0);
        }
        int numOfItems = snapshot.data!;
        return CardButton(widget: widget, numOfItems: numOfItems);
      },
    );
  }
}

class CardButton extends StatelessWidget {
  const CardButton({
    Key? key,
    required this.widget,
    required this.numOfItems,
  }) : super(key: key);

  final ButtomCard widget;
  final int numOfItems;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, CartScreen.routeName,
            arguments: {
          'NbreArticle': numOfItems,
        });
        UpdateLivraisonAndPaiement();
      },
      borderRadius: BorderRadius.circular(50),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: EdgeInsets.all(getProportionateScreenWidth(widget.padding)),
            height: widget.height,
            width: widget.width,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(widget.svgSrc,color: kPrimaryColor),
          ),
          if (numOfItems > 0)
            Positioned(
              top: -3,
              right: 0,
              child: Container(
                height: getProportionateScreenWidth(16),
                width: getProportionateScreenHeight(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFFF4848),
                  shape: BoxShape.circle,
                  border: Border.all(width: 1.5, color: Colors.white),
                ),
                child: Center(
                  child: Text(
                    "$numOfItems",
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(10),
                      height: 1,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
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

