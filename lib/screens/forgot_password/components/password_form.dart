import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/components/custom_surfix_icon.dart';
import 'package:shopapp/components/default_button.dart';
import 'package:shopapp/components/form_error.dart';
import 'package:shopapp/components/no_account_text.dart';
import 'package:shopapp/constants.dart';
import 'package:shopapp/provider/internet_provider.dart';
import 'package:shopapp/screens/sign_in/sign_in_screen.dart';
import 'package:shopapp/size_config.dart';

class ForgotPassForm extends StatefulWidget {
  const ForgotPassForm({Key? key}) : super(key: key);

  @override
  State<ForgotPassForm> createState() => _ForgotPassFormState();
}

class _ForgotPassFormState extends State<ForgotPassForm> {
  final _formKey = GlobalKey<FormState>();
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

  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) {
              if (value.isNotEmpty && errors.contains(kEmailNullError)) {
                setState(() {
                  errors.remove(kEmailNullError);
                });
              } else if (emailValidatorRegExp.hasMatch(value) &&
                  errors.contains(kInvalidEmailError)) {
                setState(() {
                  errors.remove(kInvalidEmailError);
                });
              }
              return null;
            },
            validator: (value) {
              if (value!.isEmpty && !errors.contains(kEmailNullError)) {
                setState(() {
                  errors.add(kEmailNullError);
                });
              } else if (!emailValidatorRegExp.hasMatch(value) &&
                  !errors.contains(kInvalidEmailError)) {
                setState(() {
                  errors.add(kInvalidEmailError);
                });
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: "Email",
              hintText: "Entrer votre Email",
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: CustomSurffixIcon(
                svgIcon: "assets/icons/Mail.svg",
              ),
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(30)),
          FormError(errors: errors),
          SizedBox(height: SizeConfig.screenHeight * 0.1),
          DefaultButton(
              text: "Continue",
              press: () {
                PasswordReset();
              }),
          SizedBox(height: SizeConfig.screenHeight * 0.1),
          NoAccountText(),
        ],
      ),
    );
  }

  Future PasswordReset() async {
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
          message: "Vérifiez votre connection internet",
          contentType: ContentType.failure,
          messageFontSize: getProportionateScreenWidth(15),
        ),
      ));
    } else {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        try {
          await FirebaseAuth.instance
              .sendPasswordResetEmail(email: _emailController.text.trim());
          Navigator.pushNamed(context, SignInScreen.routeName);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            behavior: SnackBarBehavior.floating,
            backgroundColor: Color(0x00FFFFFF),
            elevation: 0,
            content: AwesomeSnackbarContent(
              title: 'Oh Hey!!',
              message: "vous avez récu un mail de confirmation dans votre boite mail",
              contentType: ContentType.success,
              messageFontSize: getProportionateScreenWidth(15),
            ),
          ));

        } on FirebaseAuthException catch (e) {
          if (e.code == 'user-not-found') {
            addError(error: kEmailNotExistError);
          } else if (e.code == 'invalid-email') {
            addError(error: kInvalidEmailError);
          } else if (e.code == 'too-many-requests') {
            addError(error: kTooManyRequestError);
          } else if (e.message == 'Given String is empty or null') {
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
  }
}
