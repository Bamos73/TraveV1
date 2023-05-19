import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/components/default_button.dart';
import 'package:shopapp/constants.dart';
import 'package:shopapp/screens/details/components/color_dots.dart';
import 'package:shopapp/size_config.dart';
import 'package:slide_popup_dialog_null_safety/slide_popup_dialog.dart' as slideDialog;

class CustomNavBar extends StatefulWidget {
  const CustomNavBar({
    super.key,
    required this.product,
  });
  final DocumentSnapshot<Map<String, dynamic>>? product;

  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {

  int _lastSelectedSizeIndex = -1;
  User? user = FirebaseAuth.instance.currentUser;

  void _showDialogTaille(DocumentSnapshot<Map<String, dynamic>>? product) async{
    if (product != null) {
      slideDialog.showSlideDialog(
        context: context,
        barrierDismissible: true,
        barrierColor: Colors.black.withOpacity(0.6),
        pillColor: kPrimaryColor,
        backgroundColor: Colors.white,
        transitionDuration: Duration(milliseconds: 300),
        child: Expanded(
          child: ListView.builder(
            itemCount: product['tailles'].length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  ListTile(
                      title: Text(
                        product['tailles'][index],
                        style: TextStyle(fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,
                      ),
                      onTap: () {
                        _lastSelectedSizeIndex = index;
                        addToCard(widget.product, index);
                      }
                  ),
                  Divider(thickness: 1, height: 1),
                  // séparateur en bas de la tuile
                ],
              );
            },
          ),
        ),
      );
    }
  }

  void addToCard(DocumentSnapshot<Map<String, dynamic>>? product, int index) async {
    if (product == null) {
      return;
    }

    final userId = user?.uid;
    // Utilisez la valeur de quantiteSelectionnee comme vous le souhaitez
    int quantiteSelectionnee = MyAppState.nmbreArticleState;

    // //généré un code a 6 chiffre pour les differente style
    // Random random = Random();
    // int CodeStyle = random.nextInt(99999) + 2300000;
    // print('Code généré : $CodeStyle');

    final userCardRef = FirebaseFirestore.instance
        .collection('Card')
        .doc(userId)
        .collection(userId!)
        .doc(product['code'].toString());



    final userCardDoc = await userCardRef.get();

    if (userCardDoc.exists) {
      final userCardData = userCardDoc.data();
      if (userCardData != null && userCardData['taille'] == product['tailles'][index])  {
        // La taille du produit est la même que celle de la base, alors on vérifie si la quantité est pareil
        if (userCardData != null && userCardData['quantite'] != quantiteSelectionnee) {
          // la quantité est différente
          userCardRef.update({
            'quantite': quantiteSelectionnee,
          });
          print("quantité modifié");
        }
      } else {
        /* La taille du produit est différente de celle de la base alors on creer un autre document
        * avec le nom du code */
        final userCardCollectionRef = FirebaseFirestore.instance
            .collection('Card')
            .doc(userId)
            .collection(userId)
            .doc(userCardData!['code'].toString());

        final userCardRefDoc = await userCardCollectionRef.get();
        final userCardRefData = userCardRefDoc.data();

        // La taille du produit est différente de celle de la base
        await userCardCollectionRef.set({
          'userID': FirebaseAuth.instance.currentUser?.uid,
          'code': userCardData['code']+'b',
          'title': product['title'],
          'image': product['images'][0],
          'color': product['color'],
          'price': product['price'],
          'style': userCardData['style'] + 1,
          'taille': product['tailles'][_lastSelectedSizeIndex],
          'quantite': quantiteSelectionnee,
        });
        if (userCardRefData != null && userCardRefData['quantite'] != quantiteSelectionnee) {
          // la quantité est différente
          userCardCollectionRef.update({
            'quantite': quantiteSelectionnee,
          });
          print("quantité modifié");
        }
      }
    } else {
      print("Le document n'existe pas");
      await userCardRef.set({
        'userID': FirebaseAuth.instance.currentUser?.uid,
        'code': product['code']+'a',
        'title': product['title'],
        'image': product['images'][0],
        'color': product['color'],
        'price': product['price'],
        'style': product['style'],
        'taille': product['tailles'][index],
        'quantite': quantiteSelectionnee,// Ajouter la quantité contenu dans le Intent
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(45)),
          height: getProportionateScreenHeight(40),
          child: DefaultButton(
            text: "AJOUTER AU PANIER",
            press: () => _showDialogTaille(widget.product),
          ),
        ),
      ),
    );
  }
}

