import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopapp/constants.dart';
import 'package:shopapp/size_config.dart';


class ButtonRetour extends StatelessWidget {
  const ButtonRetour({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
        child: SvgPicture.asset(
          "assets/icons/Back ICon.svg",
          height: 20,
        ),
      ),
    );
  }
}