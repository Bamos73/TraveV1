import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/constants.dart';
import 'package:shopapp/screens/address/address_screen.dart';
import 'package:shopapp/size_config.dart';

class ListPaymentAdresse extends StatefulWidget {
  const ListPaymentAdresse({
    super.key,
  });

  @override
  State<ListPaymentAdresse> createState() => _ListPaymentAdresseState();
}

class _ListPaymentAdresseState extends State<ListPaymentAdresse> {
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
                  width: getProportionateScreenWidth(235),
                  height: getProportionateScreenHeight(53),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("ADRESSE DE LIVRAISON",style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: getProportionateScreenHeight(14),
                        color: Colors.black87,
                      ),),
                      SizedBox(height: 2,),
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
                          if (!userDoc.exists || !userDoc.data()!.containsKey('adresse_de_livraison')) {
                            return Text(
                              'Veuillez ajouter une adresse.',
                              maxLines: 2,
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: getProportionateScreenHeight(12),
                              ),
                            );
                          }

                          final userAdresseLivraison = userDoc.data()!['adresse_de_livraison'] as String;
                          return Wrap(
                            children: [
                              Text(
                              userAdresseLivraison.toUpperCase(),
                              maxLines: 2,
                              style: TextStyle(
                                color: kTextColor,
                                fontSize: getProportionateScreenHeight(10),
                              ),
                            ),]
                          );
                        },
                      ),




                    ],
                  ),
                ),
              ],
            ) ,
            GestureDetector(
              onTap: () {
                nextScreenReplace(context, AddressScreen());
              },
              child: Text("MODIFIER",style: TextStyle(
                fontSize: getProportionateScreenHeight(13),
                color: Colors.black87,
              ),),
            ),
          ],
        ),
      ),
    );
  }
}
