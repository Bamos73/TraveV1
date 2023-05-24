import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopapp/components/default_button.dart';
import 'package:shopapp/components/form_error.dart';
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
  bool _showContainer = false;
  final List<String?> errors = [];
  final _formKey = GlobalKey<FormState>();
  final _ctrcodepromo = TextEditingController();

  void addError({required String error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({required String error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
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
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _showContainer = true;
                        });
                      },
                      child: _showContainer == true
                          ? GestureDetector(
                            onTap: () {
                              setState(() {
                                _showContainer = false;
                              });
                            },
                            child: Icon(Icons.close,color: kPrimaryColor,size: 30,))
                          : Text("Ajouter un code promo")
                      ,
                    ),
                    const SizedBox(width: 10),
                    _showContainer == true
                        ? Text("")
                        :Icon(Icons.arrow_forward_ios, size: 12, color: kTextColor,)
                  ],
                ),
                SizedBox(height: getProportionateScreenHeight(20),),
                buildAnimatedContainer(total),
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
                      child: DefaultButton(text: "Caisse", press: () {
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

  AnimatedContainer buildAnimatedContainer(num total) {
    return AnimatedContainer(
                duration: Duration(seconds: 3),
                width: _showContainer ? double.infinity : 0,
                height: _showContainer ? getProportionateScreenHeight(140) : 0,
                // color: Colors.redAccent,
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _ctrcodepromo,
                              onChanged: (value) {
                                if (value.isNotEmpty) {
                                  removeError(error: "Veuillez saisir le code");
                                } else {
                                  addError(error: "Veuillez saisir le code");
                                }
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  addError(error: "Veuillez saisir le code");
                                  return "Erreur";
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                hintText: "CODE PROMO",
                                floatingLabelBehavior: FloatingLabelBehavior.always,
                                  contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20)
                              ),
                            ),
                          ),
                          SizedBox(width: 20,),
                          GestureDetector(
                            onTap: () {

                              if (_formKey.currentState!.validate()) {
                                verifyPromoCode(_ctrcodepromo.text.trim(),total);
                              }
                            },
                              child: Text("AJOUTER"),
                          ),
                        ],
                      ),
                      SizedBox(height: 5,),
                      FormError(errors: errors),
                    ],
                  ),
                ),
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

  void verifyPromoCode(String promoCode, num total) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {


    // Get the promo code data from Firestore
    final promoCodeData = await FirebaseFirestore.instance
        .collection('CodesPromo')
        .doc(promoCode)
        .get();

    final promolistRef = await FirebaseFirestore.instance
        .collection('CodesPromo')
        .doc(promoCode)
        .collection('list_user')
        .doc(userId)
        .get();

    final promoCodeDate = promoCodeData['date_limite'];

    // Check if the promo code is valid
    if (!promoCodeData.exists) {
      // Promo code is not valid
      addError(error: "Promo code is not valid");
      return;
    }else{
      removeError(error: "Promo code is not valid");
    }


    // Check if the promo code is still active
    if (promoCodeData['Actif']==false) {
      // Promo code is not active
      addError(error: "Promo code is not active");
      return;
    }else{
      removeError(error: "Promo code is not active");
    }


    // Check if the promo code date has not passed
    if (!promoCodeDate.toDate().isAfter(DateTime.now())) {
      // Promo code date has passed
      addError(error: "Promo code date has passed");
      return;
    }else{
      removeError(error: "Promo code date has passed");
    }


    if (promoCodeData['minimum_achat']>total) {
      // miminum d'achat
      addError(error: "Le montant minimum d'achat pour utiliser \nce code promo est de ${promoCodeData['minimum_achat']} FCFA");
      return;
    }else{
      removeError(error: "Le montant minimum d'achat pour utiliser \nce code promo est de ${promoCodeData['minimum_achat']} FCFA");
    }


    if (promolistRef.exists) {
      addError(error: "coupon code already used");
      return;
    }else{
      removeError(error: "coupon code already used");
    }

    print('code ajouté');

    // Apply the promo code
    // ...
  }
}



}
