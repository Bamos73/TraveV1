import 'package:flutter/material.dart';
import 'package:shopapp/constants.dart';
import 'package:shopapp/size_config.dart';

class AdresseLivraison extends StatelessWidget {
  const AdresseLivraison({Key? key}) : super(key: key);
  static String routeName="payment/components";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F6F9),
      appBar: AppBar(
        title: Text(
          "SELECTIONNER ADRESSE",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: getProportionateScreenWidth(15),
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        leading: Icon(Icons.arrow_back_ios, weight: 100),
      ),
      body: Container(
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
                    child: Row(
                      children: [
                        Text(
                          "ESPECES",
                          maxLines: 2,
                          style: TextStyle(
                            color: kTextColor,
                            fontSize: getProportionateScreenHeight(10),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ) ,
            ],
          ),
        ),
      ),
    );
  }
}
