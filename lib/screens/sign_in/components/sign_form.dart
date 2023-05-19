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
              Text("Remember me"),
              Spacer(),
              GestureDetector(
                onTap: () => Navigator.pushNamed(
                    context, ForgotPasswordScreen.routeName),
                child: Text(
                  "Forgot Password",
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                  ),
                ),
              )
            ],
          ),
          DefaultButton(
            text: "Continue",
            press: () async {
              // internet provider
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
                    message: "Check your Internet connection",
                    contentType: ContentType.failure,
                    messageFontSize: getProportionateScreenWidth(15),
                  ),
                ));
              } else {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  try {
                    UserCredential userCredential =
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: email,
                      password: password,
                    );
                    KeyboardUtil.hideKeyboard(context);
                    nextScreenReplace(context, MainScreen());
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
              }
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
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
        labelText: "Password",
        hintText: "Enter your password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(
          svgIcon: "assets/icons/Lock.svg",
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
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Enter your email",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(
          svgIcon: "assets/icons/Mail.svg",
        ),
      ),
    );
  }
}
