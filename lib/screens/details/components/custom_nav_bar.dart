import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
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
              final isUnavailable = product['quantite'][index] == 0;
              return Column(
                children: [
                  ListTile(
                    title: Text(
                      isUnavailable
                          ? product['tailles'][index] + " ( Indisponible )"
                          : product['tailles'][index],
                      style: TextStyle(
                        fontWeight: isUnavailable ? FontWeight.bold : FontWeight.w500,
                        color: isUnavailable ? Colors.red : null,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    onTap: isUnavailable ? null : () {
                      _lastSelectedSizeIndex = index;
                      addToCard(widget.product, index);
                    },
                    enabled: !isUnavailable,
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

    final userCardRef = FirebaseFirestore.instance
        .collection('Card')
        .doc(userId)
        .collection(userId!)
        .doc(product['code'].toString()+ "-" + product['tailles'][_lastSelectedSizeIndex].toString());

    await FirebaseFirestore.instance.runTransaction((transaction) async {
      final userCardDoc = await transaction.get(userCardRef);

      if (userCardDoc.exists) {
        final userCardData = userCardDoc.data();
        if (userCardData != null && userCardData['taille'] == product['tailles'][_lastSelectedSizeIndex])  {
          // La taille du produit est la même que celle de la base, alors on vérifie si la quantité est pareille

          if (userCardData['quantite_Max'] > userCardData['quantite']){
          transaction.update(userCardRef, {
            'quantite': userCardData['quantite'] + 1,
          });
        }
        }
      } else {
        transaction.set(userCardRef, {
          'userID': FirebaseAuth.instance.currentUser?.uid,
          'code': product['code'],
          'title': product['title'],
          'image': product['images'][0],
          'color': product['color'],
          'price': product['price'],
          'style': product['style'],
          'taille': product['tailles'][_lastSelectedSizeIndex],
          'quantite': 1,
          'quantite_index':_lastSelectedSizeIndex,
          'quantite_Max': product['quantite'][_lastSelectedSizeIndex],
          'first_document': product['first_document'],
          'first_collection': product['first_collection'],
        });

      }
    });
    Navigator.of(context).pop();
    showSuccessDialog(context);
  }

  void showSuccessDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        Future.delayed(Duration(milliseconds: 2500), () {
          Navigator.pop(context);
        });

        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Container(
            width: 150,
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [
                Lottie.asset("assets/lottiefiles/80594-add-to-cart.json"),
                SizedBox(height: 5),
                Text(
                  "Votre article a été ajouté au panier !",
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(15),
                    fontWeight: FontWeight.bold,
                    color: kPrimaryColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}


