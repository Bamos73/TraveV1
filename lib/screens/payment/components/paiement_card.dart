import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/constants.dart';
import 'package:shopapp/size_config.dart';

class ListPaymentPaiement extends StatefulWidget {
  const ListPaymentPaiement({
    super.key,
  });

  @override
  State<ListPaymentPaiement> createState() => _ListPaymentPaiementState();
}

class _ListPaymentPaiementState extends State<ListPaymentPaiement> {
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
                          Text("PAIEMENT",style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: getProportionateScreenHeight(14),
                            color: Colors.black87,
                          ),),
                        ],
                      ),
                      SizedBox(height: 5,),
                      Row(
                        children: [
                          Text(
                            _selectedOption.isEmpty ? "ESPÈCES" : _selectedOption.toUpperCase(),
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
              child: Text("MODIFIER"
                ,style: TextStyle(
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
                    title: Text(
                      "Paiement à la livraison",
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(13),
                      ),
                    ),
                    subtitle: Text('Payez en espèces a la livraison'),
                    value: 'Espèces',
                    groupValue: _selectedOption,
                    onChanged: (value) {
                      setState(() {
                        _selectedOption = value as String;
                      });
                      Navigator.of(context).pop();
                      UpdateselectedOption(_selectedOption);
                    },
                    secondary: Image.asset(
                      'assets/images/money.png', // Remplacez le chemin d'accès par votre image
                      width: 30,
                      height: 30,
                    ),
                  ),
                  RadioListTile(
                    title: Text(
                      "MTN Money",
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(13),
                      ),
                    ),
                    value: 'MTN_Money',
                    subtitle: Text('Payez en toute sécurité avec MTN'),
                    groupValue: _selectedOption,
                    onChanged: (value) {
                      setState(() {
                        _selectedOption = value as String;
                      });
                      Navigator.of(context).pop();
                      UpdateselectedOption(_selectedOption);
                    },
                    secondary: Image.asset(
                      'assets/images/mtn-money.png', // Remplacez le chemin d'accès par votre image
                      width: 30,
                      height: 30,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
  }
        void UpdateselectedOption(String optionTake) async {
          final userId = FirebaseAuth.instance.currentUser?.uid;
          if (userId != null) {
            final userCardRef = FirebaseFirestore.instance.collection('users').doc(userId);
            await userCardRef.set({
              'mode_de_paiement': optionTake,
            }, SetOptions(merge: true));
          }
        }
    }


