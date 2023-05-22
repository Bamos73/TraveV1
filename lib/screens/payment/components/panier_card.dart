import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/constants.dart';
import 'package:shopapp/size_config.dart';

class PanierPayment extends StatefulWidget {
  const PanierPayment({Key? key}) : super(key: key);

  @override
  _PanierPaymentState createState() => _PanierPaymentState();
}

class _PanierPaymentState extends State<PanierPayment> {
  bool _isListViewVisible = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.white,
          height: getProportionateScreenHeight(40),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        "PANIER",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: getProportionateScreenHeight(14),
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(width: getProportionateScreenWidth(20)),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _isListViewVisible = !_isListViewVisible;
                          });
                        },
                        child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('Card')
                              .doc(FirebaseAuth.instance.currentUser?.uid)
                              .collection(FirebaseAuth.instance.currentUser!.uid)
                              .snapshots(),
                          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasData) {
                              final cardDataList = snapshot.data!.docs.map((doc) => doc.data()).toList();
                              return Text(
                                "${cardDataList.length} ${cardDataList.length > 1
                                    ? 'ARTICLES'
                                    : 'ARTICLE'}",
                                style: TextStyle(
                                  color: kTextColor,
                                  fontSize: getProportionateScreenHeight(14),
                                ),
                              );
                            } else {
                              return Text(
                                "0 ARTICLE",
                                style: TextStyle(
                                  color: kTextColor,
                                  fontSize: getProportionateScreenHeight(14),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _isListViewVisible = !_isListViewVisible;
                      });
                    },
                    child: Icon(
                      _isListViewVisible == false ? Icons.add : Icons.remove,
                      size: getProportionateScreenWidth(15),
                      weight: 100,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Visibility(
          visible: _isListViewVisible,
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('Card')
                .doc(FirebaseAuth.instance.currentUser?.uid)
                .collection(FirebaseAuth.instance.currentUser!.uid)
                .snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (snapshot.hasData) {
                final cardDataList = snapshot.data!.docs.map((doc) => doc.data()).toList();
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: cardDataList.length,
                  itemBuilder: (BuildContext context, int index) {
                    final cardData = cardDataList[index];
                    return Column(
                      children: [
                        Divider(
                          height: 1,
                          thickness: 1,
                        ),
                        Container(
                          height: getProportionateScreenHeight(95),
                          width: double.infinity,
                          color: Colors.white,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
                            child: Row(
                              children: [
                                Container(
                                  height: getProportionateScreenHeight(75),
                                  width: getProportionateScreenWidth(48.75),
                                  child: Image.network(
                                    cardData['image'], // Replace with your image path
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
                                  child: Container(
                                    width: getProportionateScreenWidth(265),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          cardData['title'], // Replace with your item title
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: getProportionateScreenWidth(13),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          "COULEUR: ${cardData['color']}", // Replace with your item couleur
                                          style: TextStyle(
                                            color: kTextColor,
                                            fontSize: getProportionateScreenWidth(12),
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          "TAILLE: ${cardData['taille']}", // Replace with your item taille
                                          style: TextStyle(
                                            color: kTextColor,
                                            fontSize: getProportionateScreenWidth(12),
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "QTE ${cardData['quantite']}", // Replace with your item qte
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: getProportionateScreenWidth(13),
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              "${cardData['price']} FCFA", // Replace with your item price
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: getProportionateScreenWidth(13),
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Divider(height: 1, thickness: 1,),
                      ],
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Container();
              } else {
                return Container();
              }
            },
          ),
        ),
      ],
    );
  }
}

