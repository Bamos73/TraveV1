
import 'package:flutter/material.dart';
import 'package:shopapp/constants.dart';
import 'package:shopapp/size_config.dart';

class ListPaymentAdresse extends StatelessWidget {
  const ListPaymentAdresse({
    super.key,
  });


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
                          Text("ADRESSE DE LIVRAISON",style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: getProportionateScreenHeight(14),
                            color: Colors.black87,
                          ),),
                        ],
                      ),
                      Text(
                        "MARCORY ANOUMANBO, PRES DE LA BOULANGERIE LE ROI DU PAIN",
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
            GestureDetector(
              onTap: () {

              },
              child: Text("MODIFIER",style: TextStyle(
                fontSize: getProportionateScreenHeight(13),
                color: Colors.black87,
              ),),
            ),
          ],
        ),
      ),
    );
  }
}
