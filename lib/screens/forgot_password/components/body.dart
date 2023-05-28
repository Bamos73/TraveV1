import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/components/custom_surfix_icon.dart';
import 'package:shopapp/components/default_button.dart';
import 'package:shopapp/components/form_error.dart';
import 'package:shopapp/components/no_account_text.dart';
import 'package:shopapp/provider/internet_provider.dart';
import 'package:shopapp/provider/sign_in_provider.dart';
import 'package:shopapp/screens/forgot_password/components/password_form.dart';
import 'package:shopapp/screens/sign_in/sign_in_screen.dart';
import 'package:shopapp/size_config.dart';
import '../../../constants.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Column(
            children: [
              SizedBox(height: SizeConfig.screenHeight*0.01,),
              Text("Mot de passe oublié",
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(24),
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text("Veuillez saisir votre e-mail et nous vous enverrons \n un lien pour revenir à votre compte",
              textAlign: TextAlign.center,
              ),
              SizedBox(height: SizeConfig.screenHeight*0.1,),
              ForgotPassForm()
            ],
          ),
        ),
      ),
    );
  }
}
