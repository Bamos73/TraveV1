import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/components/custom_surfix_icon.dart';
import 'package:shopapp/components/default_button.dart';
import 'package:shopapp/components/form_error.dart';
import 'package:shopapp/components/main_screens.dart';
import 'package:shopapp/constants.dart';
import 'package:shopapp/helper/keyboard.dart';
import 'package:shopapp/provider/internet_provider.dart';
import 'package:shopapp/provider/sign_in_provider.dart';
import 'package:shopapp/screens/forgot_password/forgot_password_screen.dart';
import 'package:shopapp/size_config.dart';

class SignForm extends StatefulWidget {
  const SignForm({
    Key? key,
  }) : super(key: key);

  @override
  State<SignForm> createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  late String email;
  late String password = '';
  bool? remember = false;
  bool isPasswordVisible = false;
  final List<String?> errors = [];

  void addError({required String error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({required String error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          FormError(errors: errors),
          Row(
            children: [
              Checkbox(
                value: remember,
                activeColor: kPrimaryColor,
                onChanged: (value) {
                  setState(() {
                    remember = value!;
                  });
                },
              ),
              Text("Se souvenir de moi"),
              Spacer(),
              GestureDetector(
                onTap: () => Navigator.pushNamed(
                    context, ForgotPasswordScreen.routeName),
                child: const Text(
                  "Mot de passe oublié",
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                  ),
                ),
              )
            ],
          ),
          DefaultButton(
            text: "Continuer",
            press: () async {
              // internet provider
              final sp = context.read<SignInProvider>();
              final ip = context.read<InternetProvider>();
              await ip.checkInternetConnection();

              // vérifie si l'utilisateur est connecté à internet
              if (ip.hasInternet == false) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Color(0x00FFFFFF),
                  elevation: 0,
                  content: AwesomeSnackbarContent(
                    title: 'Oh Hey!!',
                    message: "Vérifiez votre connection internet",
                    contentType: ContentType.failure,
                    messageFontSize: getProportionateScreenWidth(15),
                  ),
                ));
              } else {

                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  try {
                      await FirebaseAuth
                        .instance
                        .signInWithEmailAndPassword(
                          email: email,
                          password: password,
                        );
                    KeyboardUtil.hideKeyboard(context);
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'user-not-found' ||
                        e.code == 'wrong-password') {
                      addError(error: kWrongEmailOrPassError);
                    } else if (e.code == 'invalid-email') {
                      addError(error: kInvalidEmailError);
                    } else if (e.code == 'too-many-requests') {
                      addError(error: kTooManyRequestError);
                    } else {
                      removeError(error: kWrongEmailOrPassError);
                      removeError(error: kInvalidEmailError);
                      removeError(error: kTooManyRequestError);

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Color(0x00FFFFFF),
                          elevation: 0,
                          content: AwesomeSnackbarContent(
                            title: 'Oh Hey!!',
                            message: e.message.toString(),
                            contentType: ContentType.failure,
                            messageFontSize: getProportionateScreenWidth(13),
                          ),
                        ),
                      );
                    }
                  }
                }
                //sauvegarder les données dans le sharedPreferences
                await sp.getUserDataFromFirestoreForAuth().then((value) => sp
                    .saveDataToSharedPreferences()
                    .then((value) => sp.setSignIn().then((value) {
                  handleAfterSignIn();
                })));
              }
            },
          ),
        ],
      ),
    );

  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: !isPasswordVisible,
      onSaved: (newValue) => password = newValue ?? '',
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        }
        password = value;
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Mot de passe",
        hintText: "Entrer votre mot de passe",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              isPasswordVisible = !isPasswordVisible;
            });
          },
          child: Padding(
            padding: EdgeInsets.fromLTRB(0,
              getProportionateScreenWidth(20),
              getProportionateScreenWidth(20),
              getProportionateScreenWidth(20),
            ),
            child: Icon(
              isPasswordVisible ? Icons.visibility : Icons.visibility_off,
              color: kPrimaryColor,
            ),
          ),
        ),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue ?? '',
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "E-mail",
        hintText: "Entrer votre email",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(
          svgIcon: "assets/icons/Mail.svg",
        ),
      ),
    );
  }
  //handle after sign in
  handleAfterSignIn() {
    Future.delayed(const Duration(milliseconds: 1000)).then((value) {
      Navigator.pushNamed(context, MainScreen.routeName,arguments: 0);
    });
  }
}
