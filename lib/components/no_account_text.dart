import 'package:flutter/material.dart';
import 'package:shopapp/constants.dart';
import 'package:shopapp/screens/sign_up/sign_up_screen.dart';
import 'package:shopapp/size_config.dart';

class NoAccountText extends StatelessWidget {
  const NoAccountText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Vous n'avez pas de compte ?",
          style: TextStyle(fontSize: getProportionateScreenWidth(15)),
        ),
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, SignUpScreen.routeName),
          child: Text(
            "  S'inscrire",
            style: TextStyle(
              fontSize: getProportionateScreenWidth(15),
              color: kPrimaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
