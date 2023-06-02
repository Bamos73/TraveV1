import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopapp/components/shimmer_box.dart';
import 'package:shopapp/constants.dart';
import 'package:shopapp/screens/cart/components/cart_item_card.dart';

class CardCart extends StatefulWidget {
   const CardCart({Key? key}) : super(key: key);

  @override
  State<CardCart> createState() => _CardCartState();
}

class _CardCartState extends State<CardCart> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('Card')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .collection(FirebaseAuth.instance.currentUser!.uid)
          .snapshots(),
      builder: (BuildContext context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (!snapshot.hasData) {
          return Expanded(
            child: ShimmerCard(),
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Expanded(
            child: ShimmerCard(),
          );
        } else if (snapshot.data!.docs.isEmpty) {
          return Expanded(
            child: Container(),
          );
        }
        final cardDataList = snapshot.data!.docs.map((doc) => doc.data()).toList();
        return Expanded(
          child: ListView.builder(
            itemCount: cardDataList.length,
            itemBuilder: (BuildContext context, int index) {
              final cardData = cardDataList[index];
              return Dismissible(
                key: Key(cardData['code'].toString()),
                direction: DismissDirection.endToStart,
                background: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    gradient: kSecondaryGradientColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      Spacer(),
                      SvgPicture.asset("assets/icons/Trash.svg"),
                    ],
                  ),
                ),
                onDismissed: (direction) {
                  // Supprimer le document correspondant ici
                  FirebaseFirestore.instance
                      .collection('Card')
                      .doc(FirebaseAuth.instance.currentUser?.uid)
                      .collection(FirebaseAuth.instance.currentUser!.uid)
                      .where('code', isEqualTo: cardData['code']) // Filtrez par le champ 'code'
                      .get()
                      .then((querySnapshot) {
                    querySnapshot.docs.forEach((document) {
                      document.reference.delete(); // Supprimez le document correspondant
                    });
                  });
                },
                child: CardProduct(
                  cardImages: cardData['image'],
                  cardTitles: cardData['title'],
                  cardStyles: cardData['style'],
                  cardColors: cardData['color'],
                  cardTailles: cardData['taille'],
                  cardQuantites: cardData['quantite'],
                  cardQuantitesMax: cardData['quantite_Max'],
                  cardCodes: cardData['code'],
                  cardPrices: cardData['price'],
                  documentId: cardData['code'],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
