// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:shopapp/constants.dart';
import 'package:shopapp/size_config.dart';

class RoundedIconBtn extends StatelessWidget {
  const RoundedIconBtn({
    super.key,
    required this.iconData,
    required this.press,
  });
  final IconData iconData;
  final GestureTapCallback press;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: getProportionateScreenWidth(40),
      width: getProportionateScreenHeight(40),
      child: TextButton(
        onPressed: press,
        child: Icon(iconData),
        style: TextButton.styleFrom(
          foregroundColor: kPrimaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          backgroundColor: Colors.white,
          padding: EdgeInsets.zero,
        ),
      ),
    );
  }
}
