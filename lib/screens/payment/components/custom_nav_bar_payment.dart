import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shopapp/components/default_button.dart';
import 'package:shopapp/components/default_button_ronded.dart';
import 'package:shopapp/components/main_screens.dart';
import 'package:shopapp/constants.dart';
import 'package:shopapp/size_config.dart';

class CustomNavBarPayment extends StatefulWidget {
  const CustomNavBarPayment({Key? key}) : super(key: key);

  @override
  State<CustomNavBarPayment> createState() => _CustomNavBarPaymentState();
}

class _CustomNavBarPaymentState extends State<CustomNavBarPayment> {
  bool _isListViewVisible = false;

  double _getContainerHeight() {
    if (_isListViewVisible) {
      return getProportionateScreenHeight(195);
    } else {
      return getProportionateScreenHeight(115);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('Card')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .collection(FirebaseAuth.instance.currentUser!.uid)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Container();
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Container();
        } else if (snapshot.data!.docs.isEmpty) {
          return Container(
            height: 0,
            width: 0,
          );
        }

        final docs = snapshot.data!.docs;
        num total = 0;
        // Calculer la somme des prix
        for (var doc in docs) {
          final data = doc.data();
          // On multiplie le prix par la quantité
          final price = (data as Map<String, dynamic>?)?['price'] *
              (data as Map<String, dynamic>?)?['quantite'] ??
              0;
          total += price;
        }

        return StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<DocumentSnapshot> userSnapshot) {
            if (!userSnapshot.hasData) {
              return Container();
            } else if (userSnapshot.connectionState ==
                ConnectionState.waiting) {
              return Container();
            }

            final userModeLivraison =
                userSnapshot.data?.get('mode_de_livraison') as int? ?? 1000;

            return Container(
              height: _getContainerHeight(),
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Divider(height: 1, thickness: 1),
                  SizedBox(height: getProportionateScreenHeight(10)),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _isListViewVisible = !_isListViewVisible;
                            });
                          },
                          child: Text(
                            "RESUME DE LA COMMANDE",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: getProportionateScreenHeight(14),
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _isListViewVisible = !_isListViewVisible;
                            });
                          },
                          child: Icon(
                            _isListViewVisible
                                ? Icons.expand_more
                                : Icons.expand_less_rounded,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: getProportionateScreenHeight(10)),
                  Visibility(
                    visible: _isListViewVisible,
                    child: Container(
                      height: getProportionateScreenHeight(80),
                      width: double.infinity,
                      color: Colors.white,
                      padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(20),
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: getProportionateScreenHeight(10)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Sous-Total :",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: getProportionateScreenHeight(14),
                                  color: Colors.black87,
                                ),
                              ),
                              Text(
                                "${total} FCFA",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: getProportionateScreenHeight(14),
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: getProportionateScreenHeight(10)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Livraison :",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: getProportionateScreenHeight(14),
                                  color: Colors.black87,
                                ),
                              ),
                              Text(
                                "${userModeLivraison} FCFA",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: getProportionateScreenHeight(14),
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(height: 1, thickness: 1),
                  Container(
                    height: getProportionateScreenHeight(70),
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(30),
                    ),
                    color: Colors.white,
                    child: Column(
                      children: [
                        SizedBox(height: getProportionateScreenHeight(10)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text.rich(
                              TextSpan(
                                text: "Total:\n",
                                children: [
                                  TextSpan(
                                    text: "${userModeLivraison+total} FCFA",
                                    style: TextStyle(
                                      fontSize: getProportionateScreenWidth(16),
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: getProportionateScreenWidth(190),
                              child: DefaultButton(text: "Commande", press: () {}
                            ),
                              )
                          ],
                        ),
                        SizedBox(height: getProportionateScreenHeight(5)),

                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

