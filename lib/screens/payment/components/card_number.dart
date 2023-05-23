import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/components/default_button.dart';
import 'package:shopapp/constants.dart';
import 'package:shopapp/size_config.dart';

import '../../../authentification/user_add_livraison_address.dart';

class ListPaymentNumber extends StatefulWidget {
  const ListPaymentNumber({
    super.key,
  });

  @override
  State<ListPaymentNumber> createState() => _ListPaymentNumberState();
}

class _ListPaymentNumberState extends State<ListPaymentNumber> {
  final _ctrphonenumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: getProportionateScreenHeight(65),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Icons.check_circle,size: getProportionateScreenWidth(18),),
                SizedBox(width: getProportionateScreenWidth(12)),
                Container(
                  width: getProportionateScreenWidth(180),
                  height: getProportionateScreenHeight(53),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text("NUMERO DE TELEPHONE",style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: getProportionateScreenHeight(14),
                            color: Colors.black87,
                          ),),
                        ],
                      ),
                      SizedBox(height: 5,),
                      Row(
                        children: [
                          StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                            stream: FirebaseFirestore.instance
                                .collection('users')
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                .snapshots(),
                            builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> userSnapshot) {
                              if (!userSnapshot.hasData) {
                                return Container();
                              } else if (userSnapshot.connectionState == ConnectionState.waiting) {
                                return Container();
                              }

                              final userDoc = userSnapshot.data!;
                              if (!userDoc.exists || !userDoc.data()!.containsKey('numero_de_livraison')) {
                                return Text(
                                  'Veuillez ajouter un numero.',
                                  maxLines: 2,
                                  style: TextStyle(
                                    color: kTextColor,
                                    fontSize: getProportionateScreenHeight(10),
                                  ),
                                );
                              }

                              final userAdresseLivraison = userDoc.data()!['numero_de_livraison'] as String;
                              return Text(
                                userAdresseLivraison.toUpperCase(),
                                maxLines: 2,
                                style: TextStyle(
                                  color: kTextColor,
                                  fontSize: getProportionateScreenHeight(13),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ) ,
            GestureDetector(
              onTap: () {
                showCustomDialog(context);
              },
              child: Text("MODIFIER",
                style: TextStyle(
                fontSize: getProportionateScreenHeight(13),
                color: Colors.black87,
              ),),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> showCustomDialog(BuildContext context) async {

    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      final userCardRef = FirebaseFirestore.instance.collection('Livraison').doc('Mode_Livraison');
      final userCardDoc = await userCardRef.get();
      if (userCardDoc.exists) {
        final userCardData = userCardDoc.data();

        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(1),
                  vertical: getProportionateScreenHeight(10),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'NUMERO DE TELEPHONE',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(14),
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: getProportionateScreenHeight(30)),
                    buildNumber(),
                    SizedBox(height: getProportionateScreenHeight(30)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(50)),
                      child: DefaultButton(text: "Modifier", press: (){

                        final user = UserAuth(
                          phonenumber: _ctrphonenumber.text.trim(),
                        );
                        addUserNumber(user);
                        Navigator.of(context).pop();
                      }),
                    ),

                  ],
                ),
              ),
            );
          },
        );
      }
    }
  }



  Padding buildNumber() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: TextFormField(
        controller: _ctrphonenumber,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          labelText: "Numéro",
          hintText: "Entrer votre numero de téléphone",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.call),
        ),
      ),
    );
  }
}