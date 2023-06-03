import 'dart:math';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/components/default_button.dart';
import 'package:shopapp/constants.dart';
import 'package:shopapp/screens/payment/components/cart_empty.dart';
import 'package:shopapp/size_config.dart';

class CustomNavBarPayment extends StatefulWidget {
  const CustomNavBarPayment({Key? key}) : super(key: key);

  @override
  State<CustomNavBarPayment> createState() => _CustomNavBarPaymentState();
}

class _CustomNavBarPaymentState extends State<CustomNavBarPayment>
    with SingleTickerProviderStateMixin{
  String uid = FirebaseAuth.instance.currentUser?.uid ?? '';
  bool _showSecondContainer = false;
  late AnimationController _animationController;
  late Animation<Offset> _animation;


  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _animation = Tween<Offset>(
      begin: Offset(0.0, 1.0),
      end: Offset(0.0, 0.5),
    ).animate(_animationController);

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleSecondContainer() {
    setState(() {
      _showSecondContainer = !_showSecondContainer;
      if (_showSecondContainer) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          children:[
            SlideTransition(
              position: _animation,
              child: Align(
                alignment: Alignment(0,0.5),
                child: Container(
                  height:getProportionateScreenHeight(97),
                  width: double.infinity,
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20),
                  ),
                  child:
                  StreamBuilder<QuerySnapshot>(
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
                              userSnapshot.data!.get('frais_de_livraison') == null || userSnapshot.data!.get('mode_de_paiement') == null) {
                            return Container();
                          }

                          final userModeLivraison = userSnapshot.data?.get(
                              'frais_de_livraison') as num? ?? 1000;

                          final userData = userSnapshot.data!.data() as Map<String, dynamic>?;

                          final userReduction = userData != null &&
                              userData.containsKey('code_reduction_actif')
                              ? userData['code_reduction_actif'] as num? ?? 0
                              : 0;
                          return Column(

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
                                    "$total FCFA",
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
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
            Container(
                    child: Column(

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
                                  _toggleSecondContainer();
                                },
                                child: Text(_showSecondContainer
                                     ?"RESUME DE LA COMMANDE"
                                    :"RESUME DE LA COMMANDE",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: getProportionateScreenHeight(14),
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  _toggleSecondContainer();
                                },
                                child: Icon(
                                  _showSecondContainer
                                      ? Icons.expand_more
                                      : Icons.expand_less_rounded,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: getProportionateScreenHeight(10)),
                        AnimatedContainer(
                          height: _showSecondContainer
                              ?getProportionateScreenHeight(97)
                              :getProportionateScreenHeight(0),
                          width: double.infinity,
                          color: Colors.transparent,
                        duration: Duration(milliseconds: 200),
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
                              StreamBuilder<QuerySnapshot>(
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
                                      userSnapshot.data!.get('frais_de_livraison') == null || userSnapshot.data!.get('mode_de_paiement') == null) {
                                    return Container();
                                  }

                                  final userModeLivraison = userSnapshot.data?.get(
                                      'frais_de_livraison') as num? ?? 1000;

                                  final userData = userSnapshot.data!.data() as Map<String, dynamic>?;

                                  final userReduction = userData != null &&
                                      userData.containsKey('code_reduction_actif')
                                      ? userData['code_reduction_actif'] as num? ?? 0
                                      : 0;

                               return Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text.rich(
                                      TextSpan(
                                        text: "Total:\n",
                                        children: [
                                          TextSpan(
                                            text: "${userModeLivraison + total - userReduction} FCFA",
                                            style: TextStyle(
                                              fontSize: getProportionateScreenWidth(16),
                                              color: Colors.black,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: getProportionateScreenWidth(190),
                                      child: DefaultButton(
                                          text: "Commande", press: () {
                                          num totalCmd=userModeLivraison + total - userReduction;
                                          verificationOrder(context, totalCmd );
                                          nextScreenReplace(context, EmptyCart());
                                      }
                                      ),
                                    )
                                ],
                              );
                              },
                              );
                              },
                              ),
                              SizedBox(height: getProportionateScreenHeight(5)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

          ]
        ),
      ],
    );


  }

  void verificationOrder(BuildContext context,num total_commande) async {
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId == null) {
        showCustomSnackBar(
            context, "L'utilisateur n'a pas de compte", ContentType.failure);
        return;
      }

      final userCardRef = FirebaseFirestore.instance.collection('Card').doc(userId).collection(userId);
      final userRef = FirebaseFirestore.instance.collection('users').doc(userId);


      final userDoc = await userRef.get();
      if (!userDoc.exists) {
        showCustomSnackBar(context, "Connectez-vous!!", ContentType.failure);
        return;
      }

      final userData = userDoc.data();
      if (userData == null || userData['uid'] != userId) {
        showCustomSnackBar(context, "L'utilisateur n'a pas de compte valide, veuillez creer un autre compte",
            ContentType.failure);
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

        if (promoCodeData.exists && promoCodeData['montant'] == userData['code_reduction_actif']) {
          addOrderWithCodePromo(context,total_commande);

        } else {
          showCustomSnackBar(context, "Erreur sur la valeur du bon de réduction, veuillez utiliser un autre bon de réduction", ContentType.failure);
        }
      } else {
        addOrderWithOutCodePromo(context,total_commande);
      }
    } catch (e) {
      print(e);
    }
  }

  void showCustomSnackBar(BuildContext context, String message,
      ContentType contentType) {
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

  // générer code de commande
  String generateOrderCode() {
    String code = 'CM';
    final random = Random();
    final letters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    final digits = '0123456789';

    // Générer 7 lettres aléatoires
    for (int i = 0; i < 7; i++) {
      int randomIndex = random.nextInt(letters.length);
      code += letters[randomIndex];
    }
    // Générer 3 chiffres aléatoires
    for (int i = 0; i < 3; i++) {
      int randomIndex = random.nextInt(digits.length);
      code += digits[randomIndex];
    }
    return code;
  }


  void addOrderWithCodePromo(BuildContext context,num total_commande) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    if (userId != null) {

      // code de commande généré
      final orderNumber = generateOrderCode();

      final userOrderRef = FirebaseFirestore.instance.collection('Order').doc(userId).collection(orderNumber).doc(orderNumber);
      final userOrderCardRef = FirebaseFirestore.instance.collection('Order').doc(userId).collection(orderNumber).doc(orderNumber).collection('Articles');
      final userCardRef = FirebaseFirestore.instance.collection('Card').doc(userId).collection(userId);
      final userRef = FirebaseFirestore.instance.collection('users').doc(userId);


      final userOrderDocFirst = await FirebaseFirestore.instance.collection('Order').doc(userId).get();
      final userCardQuerySnapshot = await userCardRef.get();
      final userDoc = await userRef.get();


      final userCardData = userCardQuerySnapshot.docs.map((doc) => doc.data()).toList();
      final userData = userDoc.data();

      if (!userOrderDocFirst.exists) {

          //Nouvelle commande
        await userOrderRef.set({
          'code_commande': orderNumber,
          'userID': FirebaseAuth.instance.currentUser?.uid,
          'nom_de_livraison': userData!['nom_de_livraison'],
          'adresse_de_livraison': userData['adresse_de_livraison'],
          'numero_de_livraison': userData['numero_de_livraison'],
          'frais_de_livraison': userData['frais_de_livraison'],
          'reduction': userData['code_reduction_actif'],
          'mode_de_paiement': userData['mode_de_paiement'],
          'date_de_commande': FieldValue.serverTimestamp(),
          'total_commande': total_commande,
        });

        // Copier les documents de la sous-collection "Card" vers la sous-collection "Order"
        for (var docData in userCardData) {
          final code = docData['code'];
          await userOrderCardRef.doc(code).set(docData);
        }

        // Supprimer la sous-collection dans card
        final subcollectionSnapshot = await FirebaseFirestore.instance
            .collection('Card')
            .doc(userId)
            .collection(userId)
            .get();

        for (final doc in subcollectionSnapshot.docs) {
          await doc.reference.delete();
        }

        // Supprimer le document principal dans card
        await FirebaseFirestore.instance
            .collection('Card')
            .doc(userId)
            .delete();

        //ajouter l'uid de l'utilisateur a la collection CodesPromo
        await FirebaseFirestore.instance
            .collection('CodesPromo')
            .doc(userData['code_reduction_name'])
            .collection('list_user')
            .doc(userId)
            .set({
          'utilisé': true,
          'date': FieldValue.serverTimestamp(),
        });

        //supprimer les informations du code promo
        if (userDoc.exists) {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
              .update({
            'code_reduction_actif': FieldValue.delete(),
            'code_reduction_name': FieldValue.delete(),
          });

        }

      }
    }
  }

  void addOrderWithOutCodePromo(BuildContext context,num total_commande) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    if (userId != null) {

      // code de commande généré
      final orderNumber = generateOrderCode();

      final userOrderRef = FirebaseFirestore.instance.collection('Order').doc(userId).collection(orderNumber).doc(orderNumber);
      final userOrderCardRef = FirebaseFirestore.instance.collection('Order').doc(userId).collection(orderNumber).doc(orderNumber).collection('Articles');
      final userCardRef = FirebaseFirestore.instance.collection('Card').doc(userId).collection(userId);
      final userRef = FirebaseFirestore.instance.collection('users').doc(userId);


      final userOrderDocFirst = await FirebaseFirestore.instance.collection('Order').doc(userId).get();
      final userCardQuerySnapshot = await userCardRef.get();
      final userDoc = await userRef.get();


      final userCardData = userCardQuerySnapshot.docs.map((doc) => doc.data()).toList();
      final userData = userDoc.data();

      if (!userOrderDocFirst.exists) {

        //Nouvelle commande
        await userOrderRef.set({
          'code_commande': orderNumber,
          'userID': FirebaseAuth.instance.currentUser?.uid,
          'nom_de_livraison': userData!['nom_de_livraison'],
          'adresse_de_livraison': userData['adresse_de_livraison'],
          'numero_de_livraison': userData['numero_de_livraison'],
          'frais_de_livraison': userData['frais_de_livraison'],
          'reduction': 0,
          'mode_de_paiement': userData['mode_de_paiement'],
          'date_de_commande': FieldValue.serverTimestamp(),
          'total_commande': total_commande,
        });

        // Copier les documents de la sous-collection "Card" vers la sous-collection "Order"
        for (var docData in userCardData) {
          final code = docData['code'];
          await userOrderCardRef.doc(code).set(docData);
        }

        // Supprimer la sous-collection dans card
        final subcollectionSnapshot = await FirebaseFirestore.instance
            .collection('Card')
            .doc(userId)
            .collection(userId)
            .get();

        for (final doc in subcollectionSnapshot.docs) {
          await doc.reference.delete();
        }

        // Supprimer le document principal dans card
        await FirebaseFirestore.instance
            .collection('Card')
            .doc(userId)
            .delete();

      }
    }
  }

}

