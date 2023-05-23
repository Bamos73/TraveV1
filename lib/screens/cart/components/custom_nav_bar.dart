import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopapp/components/default_button.dart';
import 'package:shopapp/constants.dart';
import 'package:shopapp/screens/payment/payment_screen.dart';
import 'package:shopapp/size_config.dart';

class CheckOurCard extends StatefulWidget {
  const CheckOurCard({
    super.key,
  });

  @override
  State<CheckOurCard> createState() => _CheckOurCardState();
}

class _CheckOurCardState extends State<CheckOurCard> {
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
          //On multiplie le prix par la quantité
          final price = (data as Map<String, dynamic>?)?['price'] * (data as Map<String, dynamic>?)?['quantite']?? 0;
          total += price;
        }

        return Container(
          padding: EdgeInsets.symmetric(
            vertical: getProportionateScreenHeight(15),
            horizontal: getProportionateScreenWidth(30),
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, -15),
                blurRadius: 20,
                color: Color(0xFFDADADA).withOpacity(0.15),
              )
            ],
          ),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      height: getProportionateScreenWidth(40),
                      width: getProportionateScreenWidth(40),
                      decoration: BoxDecoration(
                        color: Color(0xFFF5F6F9),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: SvgPicture.asset("assets/icons/receipt.svg",color: kPrimaryColor,),
                    ),
                    Spacer(),
                    Text("Ajouter un code promo"),
                    const SizedBox(width: 10),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 12,
                      color: kTextColor,
                    )
                  ],
                ),
                SizedBox(
                  height: getProportionateScreenHeight(20),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text.rich(
                      TextSpan(
                        text: "Total:\n",
                        children: [
                          TextSpan(
                            text: "$total FCFA",
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
                      child: DefaultButton(text: "Check Out", press: () {
                        nextScreenReplace(context, PaymentScreen());
                        UpdateselectedOption();
                      }),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  void UpdateselectedOption() async {
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
