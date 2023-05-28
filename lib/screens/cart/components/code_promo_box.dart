
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/components/form_error.dart';
import 'package:shopapp/size_config.dart';

class CodePromoBox extends StatefulWidget {
  const CodePromoBox({Key? key}) : super(key: key);
  

  @override
  State<CodePromoBox> createState() => _CodePromoBoxState();
}

class MyAppState {
  static String CodeReductionPrecedent = "code";
}

class _CodePromoBoxState extends State<CodePromoBox> {
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
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: getProportionateScreenHeight(15),
        horizontal: getProportionateScreenWidth(30),
      ),
      width:  double.infinity,
      height: getProportionateScreenHeight(150) ,
      decoration: BoxDecoration(
        color:Colors.white,
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
      child: Column(
        children: [
          Form(
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

                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            MyAppState.CodeReductionPrecedent=_ctrcodepromo.text.trim();
                          });
                          verifyPromoCode(_ctrcodepromo.text.trim(),12000,_ctrcodepromo);

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
        ],
      ),
    );

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
          showCustomSnackBar("Le code promo n'est pas valide",ContentType.failure);
          return;
        }


        if (promoCodeData['actif']==false) {
          showCustomSnackBar("Le code promo n'est pas actif",ContentType.failure);
          return;
        }


        if (!promoCodeData['date_limite'].toDate().isAfter(DateTime.now())) {
          showCustomSnackBar("La date du code promo est passée",ContentType.failure);
          return;
        }


        if (promoCodeData['minimum_achat']>total) {
          // miminum d'achat

          showCustomSnackBar("Le montant minimum d'achat pour utiliser ce code promo est de ${promoCodeData['minimum_achat']} FCFA",ContentType.failure);
          return;
        }



        if (promolistRef.exists) {

          showCustomSnackBar("code promo déjà utilisé",ContentType.failure);

          return;
        }

        if (userData.data()!.containsKey('code_reduction_actif')) {
          final codeReductionActif = userData['code_reduction_actif'] as int;
          showCustomDialog(context as BuildContext, codeReductionActif);

          return;
        } else {
          await userDataRef.set({
            'code_reduction_actif': promoCodeData['montant'],
            'code_reduction_name': promoCodeData['code_name'],
          }, SetOptions(merge: true)
          );
          showCustomSnackBar("Code de reduction activé. Allez a la caisse",ContentType.success);
          controler.text='';
        }


        // Apply the promo code
        // ...
      }else{
        showCustomSnackBar("Connectez-vous",ContentType.failure);

      }
    } catch (e) {
      print(e);
      showCustomSnackBar("Erreur lors de la récupération des données",ContentType.failure);

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
                              .update({
                            'code_reduction_actif': FieldValue.delete(),
                            'code_reduction_name': FieldValue.delete(),
                          });
                        }
                        Navigator.of(context).pop();
                        showCustomSnackBar("Code de reduction supprimé",ContentType.failure);

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

void showCustomSnackBar(String message, ContentType Content) {
  ScaffoldMessenger.of(context as BuildContext).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.fixed,
      backgroundColor: Color(0x00FFFFFF),
      elevation: 0,
      content: AwesomeSnackbarContent(
        title: 'Ohh Ohh!!',
        message: message,
        contentType: Content,
        messageFontSize: getProportionateScreenWidth(15),
      ),
    ),
  );
}
}