import 'package:flutter/material.dart';
import 'package:shopapp/components/button_close.dart';
import '../../../size_config.dart';

class HeaderCart extends StatelessWidget {
  const HeaderCart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Align(
              alignment: Alignment.centerLeft,
              child: ButtonClose()),
        ),
        Text(
          "MON PANIER",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: getProportionateScreenWidth(15),
            color: Colors.black,
          ),
        ),
        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: Icon(Icons.favorite,color: Color(0xFFDBDEE4),fill:null),
          ),
        ),
      ],
    );
  }
}