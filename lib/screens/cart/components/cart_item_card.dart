import 'package:flutter/material.dart';
import 'package:shopapp/size_config.dart';

class CardProduct extends StatefulWidget {
  const CardProduct({
    super.key,
    required this.cardImages,
    required this.cardTitles,
    required this.cardColors,
    required this.cardTailles,
    required this.cardQuantites,
    required this.cardPrices,
    this.cardStyles,
  });

  final  cardImages;
  final  cardTitles;
  final  cardColors;
  final  cardTailles;
  final  cardQuantites;
  final  cardPrices;
  final  cardStyles;

  @override
  State<CardProduct> createState() => _CardProductState();
}

class _CardProductState extends State<CardProduct> {
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
                            color: Color(0xFF757575),
                            fontSize:getProportionateScreenWidth(12),
                            fontWeight: FontWeight.w500
                        )),
                      ],
                    ),
                    Row(
                      children: [
                        Text("COULEUR: ${widget.cardColors}",style: TextStyle(
                            color: Color(0xFF757575),
                            fontSize:getProportionateScreenWidth(12),
                            fontWeight: FontWeight.w500
                        )),
                      ],
                    ),
                    Row(
                      children: [
                        Text("TAILLE: ${widget.cardTailles}",style: TextStyle(
                            color: Color(0xFF757575),
                            fontSize:getProportionateScreenWidth(12),
                            fontWeight: FontWeight.w500
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
                        Text("${widget.cardPrices} FCFA",style: TextStyle(
                            color: Colors.black,
                            fontSize:getProportionateScreenWidth(13),
                            fontWeight: FontWeight.bold
                        )),
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