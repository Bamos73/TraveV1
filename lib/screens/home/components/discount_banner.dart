import 'package:flutter/material.dart';
import 'package:shopapp/size_config.dart';


class DiscountBanner extends StatelessWidget {
  const DiscountBanner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(20),
      ),
      padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(20),
          vertical: getProportionateScreenHeight(15)
      ),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xFF4A3298),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text.rich(
        TextSpan(text: "A summer Surpise\n",
          style: TextStyle(color: Colors.white),
          children:  [
            TextSpan(text: "Cashback 20%",
              style: TextStyle(
                fontSize:24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ) ,
      ) ,
    );
  }
}
