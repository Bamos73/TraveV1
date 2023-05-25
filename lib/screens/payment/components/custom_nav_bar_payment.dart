import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/components/default_button.dart';

import 'package:shopapp/size_config.dart';

class CustomNavBarPayment extends StatefulWidget {
  const CustomNavBarPayment({Key? key}) : super(key: key);

  @override
  State<CustomNavBarPayment> createState() => _CustomNavBarPaymentState();
}

class _CustomNavBarPaymentState extends State<CustomNavBarPayment> {
  bool _isListViewVisible = false;
  String uid = FirebaseAuth.instance.currentUser?.uid ?? '';


  double _getContainerHeight() {
    if (_isListViewVisible) {
      return getProportionateScreenHeight(219);
    } else {
      return getProportionateScreenHeight(119);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('Card')
          .doc(uid)
          .collection(uid)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Container();
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Container();
        } else if (snapshot.data!.docs.isEmpty) {
          return Container();
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
            else if (!userSnapshot.data!.exists ||
                userSnapshot.data!.get('frais_de_livraison') == null) {
              return Container();
            }

            final userModeLivraison = userSnapshot.data?.get(
                'frais_de_livraison') as int? ?? 1000;

            final userData = userSnapshot.data!.data() as Map<String, dynamic>?;

            final userReduction = userData != null &&
                userData.containsKey('code_reduction_actif')
                ? userData['code_reduction_actif'] as int? ?? 0
                : 0;

            return AnimatedContainer(
              height: _getContainerHeight(),
              duration: Duration(seconds: 2),
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
                      height: getProportionateScreenHeight(97),
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
                                "Reduction :",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: getProportionateScreenHeight(14),
                                  color: Colors.black87,
                                ),
                              ),
                              Text(userReduction > 0
                                  ? "-${userReduction} FCFA" :
                              "0 FCFA",
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
                                    text: "${userModeLivraison + total -
                                        userReduction} FCFA",
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
                              child: DefaultButton(
                                  text: "Commande", press: () {
                                verificationOrder(context);
                              }
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

  void verificationOrder(BuildContext context) async {
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId == null) {
        showCustomSnackBar(context, "L'utilisateur n'a pas de compte", ContentType.failure);
        return;
      }

      final userOrderRef = FirebaseFirestore.instance.collection('Order').doc(userId);
      final userCardRef =
      FirebaseFirestore.instance.collection('Card').doc(userId).collection(userId);
      final userRef = FirebaseFirestore.instance.collection('users').doc(userId);

      final userOrderDoc = await userOrderRef.get();
      if (userOrderDoc.exists) {
        print("L'utilisateur a déjà une commande");
        return;
      }

      final userDoc = await userRef.get();
      if (!userDoc.exists) {
        showCustomSnackBar(context, "L'utilisateur n'a pas de compte", ContentType.failure);
        return;
      }

      final userData = userDoc.data();
      if (userData == null || userData['uid'] != userId) {
        showCustomSnackBar(context, "L'utilisateur n'a pas de compte valide, veuillez creer un autre compte", ContentType.failure);
        return;
      }

      final userCardSnapshot = await userCardRef.get();
      if (userCardSnapshot.docs.isEmpty) {
        showCustomSnackBar(context, "Le panier est vide", ContentType.failure);
        return;
      }

      if (userData['adresse_de_livraison'] == null ||
          userData['nom_de_livraison'] == null) {
        showCustomSnackBar(context, "Veuillez choisir ou ajouter une adresse de livraison", ContentType.failure);
        return;
      }

      if (userData['numero_de_livraison'] == null) {
        showCustomSnackBar(context, "Veuillez ajouter un numéro de téléphone", ContentType.failure);
        return;
      }



      if (userData['code_reduction_name'] != null) {
        final promoCodeData = await FirebaseFirestore.instance
            .collection('CodesPromo')
            .doc(userData['code_reduction_name'] as String)
            .get();

        if (promoCodeData.exists && promoCodeData['minimum_achat'] == userData['code_reduction_actif']) {
          print("Validation de l'achat");

        } else {
          showCustomSnackBar(context, "Erreur sur la valeur du bon de réduction, veuillez utiliser un autre bon de réduction", ContentType.failure);
        }
      } else {

        showCustomSnackBar(context, "L'utilisateur n'a pas de code de réduction", ContentType.failure);
      }
    }catch(e){
      print(e);
    }
  }

  void showCustomSnackBar(BuildContext context, String message, ContentType contentType) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.fixed,
        backgroundColor: Color(0x00FFFFFF),
        elevation: 0,
        content: AwesomeSnackbarContent(
          title: 'Ohh Ohh!!',
          message: message,
          contentType: contentType,
          messageFontSize: getProportionateScreenWidth(15),
        ),
      ),
    );
  }
}

