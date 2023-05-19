
import 'package:flutter/material.dart';
import 'package:shopapp/components/button_close.dart';

import '../../../size_config.dart';

class header_card_filtre extends StatelessWidget {
  const header_card_filtre({
    super.key, required this.titleCenter, required this.titleRight,
  });
  final String titleCenter;
  final String titleRight;

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
          titleCenter,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: getProportionateScreenWidth(15),
            color: Colors.black,
          ),
        ),
        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              titleRight,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: getProportionateScreenWidth(15),
                color: Color(0xFF858585),
              ),
            ),
          ),
        ),
      ],
    );
  }
}