import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
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
class MyAppState {
  static String CodeReductionPrecedent = "code";
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
                SizedBox(height: _showContainer == true
                    ?getProportionateScreenHeight(0)
                    :getProportionateScreenHeight(20)
                  ,),
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
                duration: Duration(seconds: 2),
                width: _showContainer ? double.infinity : 0,
                height: _showContainer ? getProportionateScreenHeight(150) : 0,
                // color: Colors.redAccent,
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  return "";
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
                              removeerror(MyAppState.CodeReductionPrecedent,total);

                              if (_formKey.currentState!.validate()) {

                                setState(() {
                                  MyAppState.CodeReductionPrecedent=_ctrcodepromo.text.trim();
                                });
                                verifyPromoCode(_ctrcodepromo.text.trim(),total,_ctrcodepromo);

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



  void verifyPromoCode(String promoCode, num total,TextEditingController controler) async {

    try {

    final userId = FirebaseAuth.instance.currentUser?.uid;

    if (userId != null) {
      //supprimer l'erreur si l'utilisateur est connecté
      removeError(error: "Connectez-vous");

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

    final userDataRef = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId);

      final userData= await userDataRef.get();


    // Check if the promo code is valid
    if (!promoCodeData.exists) {
      // Le code promo n'est pas valide
      addError(error: "Le code promo n'est pas valide");
      return;
    }else{
      removeError(error: "Le code promo n'est pas valide");
    }


    // Check if the promo code is still active
    if (promoCodeData['Actif']==false) {
      // Le code promo n'est pas actif
      addError(error: "Le code promo n'est pas actif");
      return;
    }else{
      removeError(error: "Le code promo n'est pas actif");
    }


    // Check if the promo code date has not passed
    if (!promoCodeData['date_limite'].toDate().isAfter(DateTime.now())) {
      // La date du code promo est passée
      addError(error: "La date du code promo est passée");
      return;
    }else{
      removeError(error: "La date du code promo est passée");
    }


    if (promoCodeData['minimum_achat']>total) {
      // miminum d'achat
      addError(error: "Le montant minimum d'achat pour utiliser ce code promo est de ${promoCodeData['minimum_achat']} FCFA");
      return;
    }else{
      removeError(error: "Le montant minimum d'achat pour utiliser ce code promo est de ${promoCodeData['minimum_achat']} FCFA");
    }



    if (promolistRef.exists) {
      addError(error: "code promo déjà utilisé");
      return;
    }else{
      removeError(error: "code promo déjà utilisé");
    }

      if (userData.data()!.containsKey('code_reduction_actif')) {
        final codeReductionActif = userData['code_reduction_actif'] as int;

        showCustomDialog(context, codeReductionActif);

        return;
      } else {
           await userDataRef.set({'code_reduction_actif': promoCodeData['montant']}, SetOptions(merge: true)
        );

           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
             behavior: SnackBarBehavior.floating,
             backgroundColor: Color(0x00FFFFFF),
             elevation: 0,
             content: AwesomeSnackbarContent(
               title: 'Super!!',
               message: "Code de reduction activé. Allez a la caisse",
               contentType: ContentType.success,
               messageFontSize: getProportionateScreenWidth(15),
             ),
           ));
           controler.text='';
      print('code ajouté');
    }


    // Apply the promo code
    // ...
  }else{
      addError(error: "Connectez-vous");
    }
    } catch (e) {
      print(e);
      addError(error: 'Erreur lors de la récupération des données');
    }
}

  void removeerror(String promoCode, num total) async {

      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId != null) {
        final promoCodeData = await FirebaseFirestore.instance
            .collection('CodesPromo')
            .doc(promoCode)
            .get();
          removeError(error: "Connectez-vous");
          removeError(error: "Le code promo n'est pas valide");
          removeError(error: "Le code promo n'est pas actif");
          removeError(error: "La date du code promo est passée");
          removeError(error: "code promo déjà utilisé");
          removeError(error: "Erreur lors de la récupération des données");
          try{
             removeError(error: "Le montant minimum d'achat pour utiliser ce code promo est de ${promoCodeData['minimum_achat']} FCFA");
          }catch(e){
            print(e);
          }
  }
  }


  void showCustomDialog(BuildContext context, int reduction_actif) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Container(
            padding: EdgeInsets.all(15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Vous avez déjà un code de reduction actif de ${reduction_actif} FCFA, voulez vous le supprimer ?',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: getProportionateScreenWidth(14),color: Colors.black),
                ),
                SizedBox(height: getProportionateScreenHeight(15)),
                Divider(thickness: 1,height: 1),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextButton(
                        child: Text('Non',style: TextStyle(color: Color(0xFF858585),fontWeight:FontWeight.bold,fontSize: getProportionateScreenWidth(14)),),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                    Container(
                      width: 1,
                      height: 25,
                      color: Color(0xFF858585),
                      margin: EdgeInsets.symmetric(horizontal: 10),
                    ),
                    Expanded(
                      child: TextButton(
                        child: Text('Oui',style: TextStyle(color: Colors.red,fontWeight:FontWeight.bold,fontSize: getProportionateScreenWidth(14)),),
                        onPressed: () async {

                          final userId = FirebaseAuth.instance.currentUser?.uid;
                          final userData = await FirebaseFirestore.instance
                              .collection('users')
                              .doc(userId)
                              .get();

                          if (userData.exists) {
                            await FirebaseFirestore.instance
                                .collection('users')
                                .doc(userId)
                                .set(userData.data()!..remove('code_reduction_actif'));
                          }
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }



}
