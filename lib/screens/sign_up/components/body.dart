import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/components/main_screens.dart';
import 'package:shopapp/components/policy_and_term_card.dart';
import 'package:shopapp/components/snack_bar.dart';
import 'package:shopapp/components/social_card.dart';
import 'package:shopapp/constants.dart';
import 'package:shopapp/provider/internet_provider.dart';
import 'package:shopapp/provider/sign_in_provider.dart';
import 'package:shopapp/screens/sign_up/components/sign_up_form.dart';
import 'package:shopapp/size_config.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
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
              SizedBox(height: SizeConfig.screenHeight * 0.02),
              Text(
                "Register Account",
                style: headingStyle,
              ),
              Text(
                "Complete your details or continue \n with social media",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: getProportionateScreenHeight(14),
                ),
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.07),
              SignUpForm(),
              SizedBox(height: SizeConfig.screenHeight * 0.05),
              Column(
                children: [
                  Text(
                    "Continue with",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: getProportionateScreenWidth(15),
                    ),
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SocialCard(
                        icon: "assets/icons/facebook-2.svg",
                        press: () async {
                          handleFacebookAuth();
                        },
                      ),
                      SocialCard(
                        icon: "assets/icons/google-icon.svg",
                        press: () async {
                          handleGoogleSignIn();
                        },
                      ),
                      SocialCard(
                        icon: "assets/icons/twitter.svg",
                        press: () async {
                          handleTwitterAuth();
                        },
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: getProportionateScreenHeight(30)),
              PolicyAndTerm(),
            ],
          ),
        ),
      ),
    );
  }

//***********************************LOGIN AVEC GOOGLE ***********************************
  Future handleGoogleSignIn() async {
    //handling google signin in
    final sp = context.read<SignInProvider>();

    //internet provider
    final ip = context.read<InternetProvider>();
    await ip.checkInternetConnection();
//***************verifie si l'utilisateur est connecté a internet//
    if (ip.hasInternet == false) {
      openSnackbar(context, "Check your Internet connection", Colors.red);
    } else {
      await sp.signInWithGoogle().then((value) {
        if (sp.hasError == true) {
          openSnackbar(context, sp.errorCode.toString(), Colors.red);
        }
        //****************verifier si l'utilisateur existite ou pas   ******************//
        else {
          sp.checkUserExists().then((value) async {
            if (value == true) {
              await sp.getUserDataFromFirestore(sp.uid).then((value) => sp
                  .saveDataToSharedPreferences()
                  .then((value) => sp.setSignIn().then((value) {
                        handleAfterSignIn();
                      })));
            } else {
              //l'utilisateur existe pas
              sp.saveDataToFirestore().then((value) => sp
                  .saveDataToSharedPreferences()
                  .then((value) => sp.setSignIn().then((value) {
                        handleAfterSignIn();
                      })));
            }
          });
        }
      });
    }
  }

//***********************************LOGIN AVEC FACEBOOK ***********************************
  Future handleFacebookAuth() async {
    //handling google signin in
    final sp = context.read<SignInProvider>();

    //internet provider
    final ip = context.read<InternetProvider>();
    await ip.checkInternetConnection();
//***************verifie si l'utilisateur est connecté a internet//

    if (ip.hasInternet == false) {
      openSnackbar(context, "Check your Internet connection", Colors.red);
    } else {
      await sp.signInWithFacebook().then((value) {
        if (sp.hasError == true) {
          openSnackbar(context, sp.errorCode.toString(), Colors.red);
        }
        //****************verifier si l'utilisateur existite ou pas ******************//
        else {
          sp.checkUserExists().then((value) async {
            if (value == true) {
              await sp.getUserDataFromFirestore(sp.uid).then((value) => sp
                  .saveDataToSharedPreferences()
                  .then((value) => sp.setSignIn().then((value) {
                        handleAfterSignIn();
                      })));
            } else {
              //l'utilisateur existe pas
              sp.saveDataToFirestore().then((value) => sp
                  .saveDataToSharedPreferences()
                  .then((value) => sp.setSignIn().then((value) {
                        handleAfterSignIn();
                      })));
            }
          });
        }
      });
    }
  }

//***********************************LOGIN AVEC TWITTER ***********************************
  Future handleTwitterAuth() async {
    final sp = context.read<SignInProvider>();
    final ip = context.read<InternetProvider>();
    await ip.checkInternetConnection();

    if (ip.hasInternet == false) {
      openSnackbar(context, "Check your Internet connection", Colors.red);
    } else {
      await sp.signInWithTwitter().then((value) {
        if (sp.hasError == true) {
          openSnackbar(context, sp.errorCode.toString(), Colors.red);
        } else {
          // checking whether user exists or not
          sp.checkUserExists().then((value) async {
            if (value == true) {
              // user exists
              await sp.getUserDataFromFirestore(sp.uid).then((value) => sp
                  .saveDataToSharedPreferences()
                  .then((value) => sp.setSignIn().then((value) {
                        handleAfterSignIn();
                      })));
            } else {
              // user does not exist
              sp.saveDataToFirestore().then((value) => sp
                  .saveDataToSharedPreferences()
                  .then((value) => sp.setSignIn().then((value) {
                        handleAfterSignIn();
                      })));
            }
          });
        }
      });
    }
  }

//handle after sign in
  handleAfterSignIn() {
    Future.delayed(const Duration(milliseconds: 1000)).then((value) {
      Navigator.pushNamed(context, MainScreen.routeName);
    });
  }
}
