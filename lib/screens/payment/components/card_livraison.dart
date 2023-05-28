import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/constants.dart';
import 'package:shopapp/size_config.dart';

class ListPaymentLivraison extends StatefulWidget {
  const ListPaymentLivraison({
    Key? key,
  }) : super(key: key);

  @override
  State<ListPaymentLivraison> createState() => _ListPaymentLivraisonState();
}

class _ListPaymentLivraisonState extends State<ListPaymentLivraison> {
  String _selectedOption = "";

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
                  width: getProportionateScreenWidth(170),
                  height: getProportionateScreenHeight(53),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text("MODE DE LIVRAISON",style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: getProportionateScreenHeight(14),
                            color: Colors.black87,
                          ),),
                        ],
                      ),
                      const SizedBox(height: 5,),
                      Row(
                        children: [
                          Text(
                            _selectedOption.isEmpty ? "REGULIER" : _selectedOption.toUpperCase(),
                            maxLines: 2,
                            style: TextStyle(
                              color: kTextColor,
                              fontSize: getProportionateScreenHeight(13),
                            ),
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
              child: Text("MODIFIER",style: TextStyle(
                fontSize: getProportionateScreenHeight(13),
                color: Colors.black87,
              ),
              ),
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
                  'MODE DE LIVRAISON',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(14),
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(10)),
                Divider(thickness: 1, height: 1),
                RadioListTile(
                  title: Text("Livraison régulière (${userCardData!['Regulier']} FCFA)"
                    ,style: TextStyle(
                      fontSize: getProportionateScreenWidth(13),
                    ),),
                  subtitle: Text('1 à 3 jours ouvrables'),
                  value: 'Regulier',
                  groupValue: _selectedOption,
                  onChanged: (value) {
                    setState(() {
                      _selectedOption = value as String;
                    });
                    Navigator.of(context).pop();
                    UpdateselectedOption(userCardData['Regulier']);
                  },
                ),
                Divider(thickness: 1, height: 1),
                RadioListTile(
                  title: Text("Livraison express (${userCardData['Express']} FCFA)",
                    style: TextStyle(
                    fontSize: getProportionateScreenWidth(13),
                  ),),
                  value: 'Express',
                  subtitle: Text('2 à 8 heures'),
                  groupValue: _selectedOption,
                  onChanged: (value) {
                    setState(() {
                      _selectedOption = value as String;
                    });
                    Navigator.of(context).pop();
                    UpdateselectedOption(userCardData['Express']);
                  },
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

  void UpdateselectedOption(int optionTake) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      final userCardRef = FirebaseFirestore.instance.collection('users').doc(userId);
      await userCardRef.set({
        'frais_de_livraison': optionTake,
      }, SetOptions(merge: true));
    }
  }
}
