import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/size_config.dart';

import '../../../constants.dart';

class Card_item_Favorie extends StatefulWidget {
  const Card_item_Favorie({
    super.key,
    required this.cardImages,
    required this.cardTitles,
    required this.cardColors,
    required this.cardPrices,
    this.cardStyles,
    required this.documentId,
    this.cardCodes,
  });

  final  cardImages;
  final  cardTitles;
  final  cardColors;
  final  cardPrices;
  final  cardStyles;
  final  cardCodes;
  final String documentId;

  @override
  State<Card_item_Favorie> createState() => _Card_item_FavorieState();
}

class _Card_item_FavorieState extends State<Card_item_Favorie> {


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
                  widget.cardImages ?? '',
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
                        Text(
                          widget.cardTitles ?? '',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: getProportionateScreenWidth(13),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "STYLE: ${widget.cardStyles ?? ''}",
                          style: TextStyle(
                            color: kTextColor,
                            fontSize: getProportionateScreenWidth(12),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "COULEUR: ${widget.cardColors ?? ''}",
                          style: TextStyle(
                            color: kTextColor,
                            fontSize: getProportionateScreenWidth(12),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),

                    Spacer(),
                    Row(
                      children: [
                        Text(
                          "${widget.cardPrices ?? ''} FCFA",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: getProportionateScreenWidth(13),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: getProportionateScreenHeight(10)),
          Divider(thickness: 1, height: 1),
        ],
      ),
    );
  }



}