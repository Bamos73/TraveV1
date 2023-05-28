import 'package:flutter/material.dart';
import 'package:shopapp/constants.dart';
import 'package:shopapp/screens/Privacy_Policy/Privacy_Policy_Screen.dart';
import 'package:shopapp/screens/Term_And_Condition/term_and_condition_screen.dart';
import 'package:shopapp/size_config.dart';

class PolicyAndTerm extends StatelessWidget {
  const PolicyAndTerm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      children: [
        Text(
          "En continuant, vous confirmez que vous acceptez nos",
          style: TextStyle(
            fontSize: getProportionateScreenHeight(13),
          ),
        ),
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, TermAndConditionScreen.routeName),
          child: Text(
            "Conditions générales",
            style: TextStyle(
              fontSize: getProportionateScreenHeight(13),
              color: kPrimaryColor,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
        Text(
          ". Lisez notre ",
          style: TextStyle(
            fontSize: getProportionateScreenHeight(13),
          ),
        ),
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, PrivacyPolicyScreen.routeName),
          child: Text("Politique de confidentialité",
            style: TextStyle(
              fontSize: getProportionateScreenHeight(13),
              color: kPrimaryColor,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}
