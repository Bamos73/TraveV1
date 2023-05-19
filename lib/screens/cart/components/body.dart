import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopapp/constants.dart';
import 'package:shopapp/screens/cart/components/cart_empty.dart';
import 'package:shopapp/screens/cart/components/cart_item_card.dart';
import 'package:shopapp/screens/cart/components/header_cart.dart';
import 'package:shopapp/size_config.dart';
import '../../../components/shimmer_box.dart';

class Body extends StatefulWidget {
  Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(15)),
        child: Column(
          children: [
            HeaderCart(),
            Divider(thickness: 1, height: 1),
            StreamBuilder(
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
                  return EmptyCart();
                }
                final cardDataList =
                snapshot.data!.docs.map((doc) => doc.data()).toList();
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
                          cardCodes: cardData['code'],
                          cardPrices: cardData['price'], documentId: cardData['code'],
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

