// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shopapp/constants.dart';
import 'package:shopapp/screens/Privacy_Policy/Privacy_Policy_Screen.dart';
import 'package:shopapp/screens/Term_And_Condition/term_and_condition_screen.dart';
import 'package:shopapp/screens/complete_profile/components/complete_profile_form.dart';
import 'package:shopapp/size_config.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "Complete Profile",
                style: headingStyle,
              ),
              const Text(
                "Complete your detail or continue \n with social media",
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: SizeConfig.screenHeight * 0.03,
              ),
              CompleteProfileForm(),
              SizedBox(height: SizeConfig.screenHeight * 0.05),
              SizedBox(height: getProportionateScreenHeight(20)),
              Wrap(
                alignment: WrapAlignment.center,
                children: [
                  Text(
                    "By continuing, you confirm that you agree with our",
                    style: TextStyle(
                      fontSize: getProportionateScreenHeight(13),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(
                        context, TermAndConditionScreen.routeName),
                    child: Text(
                      "Term and Condition",
                      style: TextStyle(
                        fontSize: getProportionateScreenHeight(13),
                        color: kPrimaryColor,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  Text(
                    ". Read our ",
                    style: TextStyle(
                      fontSize: getProportionateScreenHeight(13),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(
                        context, PrivacyPolicyScreen.routeName),
                    child: Text(
                      "Privacy Policy",
                      style: TextStyle(
                        fontSize: getProportionateScreenHeight(13),
                        color: kPrimaryColor,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
