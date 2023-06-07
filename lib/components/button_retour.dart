import 'package:flutter/material.dart';
import 'package:shopapp/constants.dart';
import 'package:shopapp/size_config.dart';


class ButtonRetour extends StatelessWidget {
  const ButtonRetour({
    super.key,
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
          padding: EdgeInsets.only(left: getProportionateScreenWidth(5)),
        ),
        onPressed: () => Navigator.pop(context),
        child: Icon(Icons.arrow_back_ios,
          color: kPrimaryColor,
          size: getProportionateScreenWidth(20),
        )
      ),
    );
  }
}