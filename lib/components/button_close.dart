import 'package:flutter/material.dart';
import 'package:shopapp/constants.dart';
import 'package:shopapp/size_config.dart';


class ButtonClose extends StatelessWidget {
  const ButtonClose({
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getProportionateScreenWidth(35),
      width: getProportionateScreenWidth(35),
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: kPrimaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(60),
          ),
          backgroundColor: Colors.white,
          padding: EdgeInsets.zero,
        ),
        onPressed: () => Navigator.pop(context),
        child: Icon(Icons.close,
          color: kPrimaryColor,
          size: getProportionateScreenWidth(20),
        ),
      ),
    );
  }
}