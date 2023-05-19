// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shopapp/constants.dart';
import 'package:shopapp/models/product.dart';
import 'package:shopapp/models/product_new_collection.dart';
import 'package:shopapp/size_config.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    this.widthProduct = 120,
    this.aspectRetion = 1.02,
    required this.product,
    required this.press,
  });

  final double widthProduct, aspectRetion;
  final Product product;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
      child: GestureDetector(
        onTap: press,
        child: SizedBox(
          width: getProportionateScreenWidth(widthProduct),
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: aspectRetion,
                child: Container(
                  //*************************************Pour la Box contenant l'image******************************
                  padding: EdgeInsets.all(getProportionateScreenWidth(10)), //Marge interieur pour les image de produit
                  decoration: BoxDecoration(
                      color: kSecondaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(0)),
                  //*************************************Pour l'image du produit******************************
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.asset(
                      product.images[0],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              //*************************************Pour la description du produit******************************
              Text(
                product.title,
                style: TextStyle(color: Colors.black),
                maxLines: 1,
              ),
              //*************************************Pour la Prix du produit******************************
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${product.price.toInt()} FCFA",
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: getProportionateScreenWidth(17),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

