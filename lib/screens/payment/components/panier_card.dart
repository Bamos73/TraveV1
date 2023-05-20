import 'package:flutter/material.dart';
import 'package:shopapp/constants.dart';
import 'package:shopapp/size_config.dart';


class PanierPayment extends StatelessWidget {
  const PanierPayment({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: getProportionateScreenHeight(40),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    "PANIER",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: getProportionateScreenHeight(14),
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(width: getProportionateScreenWidth(20)),
                  Text(
                    "2 ARTICLE",
                    style: TextStyle(
                      color: kTextColor,
                      fontSize: getProportionateScreenHeight(14),
                    ),
                  ),
                ],
              ),
              Icon(Icons.add, size: getProportionateScreenWidth(15), weight: 100),
            ],
          ),
        ),
      ),
    );
  }
}
