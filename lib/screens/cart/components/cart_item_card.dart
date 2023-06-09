import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/size_config.dart';

import '../../../constants.dart';

class CardProduct extends StatefulWidget {
  const CardProduct({
    super.key,
    required this.cardImages,
    required this.cardTitles,
    required this.cardColors,
    required this.cardTailles,
    required this.cardQuantites,
    required this.cardPrices,
    this.cardStyles, required this.documentId, this.cardCodes,
  });

  final  cardImages;
  final  cardTitles;
  final  cardColors;
  final  cardTailles;
  final  cardQuantites;
  final  cardPrices;
  final  cardStyles;
  final  cardCodes;
  final String documentId;

  @override
  State<CardProduct> createState() => _CardProductState();
}

class _CardProductState extends State<CardProduct> {
  void updateQuantity(int newQuantity) {
    FirebaseFirestore.instance
        .collection('Card')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection(FirebaseAuth.instance.currentUser!.uid)
        .doc(widget.documentId)
        .update({'quantite': newQuantity})
        .then((value) {
      print('Quantity updated successfully!');
    }).catchError((error) {
      print('Failed to update quantity: $error');
    });
  }

  void showCustomDialog(BuildContext context) {
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
                  'Voulez-vous vraiment supprimer cet article sélectionné ?',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: getProportionateScreenWidth(14)),
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
                        onPressed: () {
                          // Action à effectuer lorsque l'icône est "Icons.delete"

                          FirebaseFirestore.instance
                              .collection('Card')
                              .doc(FirebaseAuth.instance.currentUser?.uid)
                              .collection(FirebaseAuth.instance.currentUser!.uid)
                              .where('code', isEqualTo: widget.cardCodes) // Filtrez par le champ 'code'
                              .get()
                              .then((querySnapshot) {
                            querySnapshot.docs.forEach((document) {
                              document.reference.delete(); // Supprimez le document correspondant
                            });
                          });
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: getProportionateScreenHeight(5)),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: getProportionateScreenHeight(200),
                width: getProportionateScreenWidth(130),
                child: Image.network(
                  widget.cardImages,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10)),
                height: getProportionateScreenHeight(200),
                width: getProportionateScreenWidth(215),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(widget.cardTitles,style: TextStyle(
                            color: Colors.black,
                            fontSize:getProportionateScreenWidth(13),
                            fontWeight: FontWeight.bold
                        )),
                      ],
                    ),
                    Row(
                      children: [
                        Text("STYLE: ${widget.cardStyles}",style: TextStyle(
                            color: kTextColor,
                            fontSize:getProportionateScreenWidth(12),
                            fontWeight: FontWeight.w500
                        )),
                      ],
                    ),
                    Row(
                      children: [
                        Text("COULEUR: ${widget.cardColors}",style: TextStyle(
                            color: kTextColor,
                            fontSize:getProportionateScreenWidth(12),
                            fontWeight: FontWeight.w500
                        )),
                      ],
                    ),
                    Row(
                      children: [
                        Text("TAILLE: ${widget.cardTailles}",style: TextStyle(
                            color: kTextColor,
                            fontSize:getProportionateScreenWidth(12),
                            fontWeight: FontWeight.w500
                        )),
                      ],
                    ),
                    Row(
                      children: [
                        Text("${widget.cardPrices} FCFA",style: TextStyle(
                            color: Colors.black,
                            fontSize:getProportionateScreenWidth(13),
                            fontWeight: FontWeight.bold
                        )),
                      ],
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("QTE ${widget.cardQuantites}",style: TextStyle(
                            color: Colors.black,
                            fontSize:getProportionateScreenWidth(13),
                            fontWeight: FontWeight.bold
                        )),
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.add,
                                  size: getProportionateScreenWidth(20),
                                  color: kTextColor
                              ),
                              onPressed: () {
                                int newQuantity = widget.cardQuantites + 1;
                                updateQuantity(newQuantity);
                              },
                            ),
                            // SizedBox(width: getProportionateScreenWidth(1)),
                            IconButton(
                              icon: Icon(
                                widget.cardQuantites == 0 ? Icons.delete : Icons.remove,
                                size: getProportionateScreenWidth(20),
                                color: kTextColor,
                              ),
                              onPressed: () {
                                if (widget.cardQuantites == 0) {
                                  showCustomDialog(context);
                                } else {
                                  int newQuantity = widget.cardQuantites - 1;
                                  updateQuantity(newQuantity);
                                }
                              },
                            ),
                          ],
                        ),
                      ],
                    ),

                  ],
                ),
              )
            ],
          ),
          SizedBox(height: getProportionateScreenHeight(10),),
          Divider(thickness: 1, height: 1,)
        ],
      ),
    );
  }
}