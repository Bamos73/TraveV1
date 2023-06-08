import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/authentification/user_add_with_auth.dart';
import 'package:shopapp/components/custom_surfix_icon.dart';
import 'package:shopapp/components/default_button.dart';
import 'package:shopapp/components/form_error.dart';
import 'package:shopapp/components/main_screens.dart';
import 'package:shopapp/constants.dart';
import 'package:shopapp/provider/internet_provider.dart';
import 'package:shopapp/provider/sign_in_provider.dart';
import 'package:shopapp/screens/otp/otp_screen.dart';
import 'package:shopapp/size_config.dart';

class CompleteProfileForm extends StatefulWidget {
  const CompleteProfileForm({Key? key}) : super(key: key);

  @override
  State<CompleteProfileForm> createState() => _CompleteProfileFormState();
}

class _CompleteProfileFormState extends State<CompleteProfileForm> {
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

  final _ctrfirstname = TextEditingController();
  final _ctrlastname = TextEditingController();
  final _ctrphonenumber = TextEditingController();
  final _ctradresse = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            buildFirstNameFormField(),
            SizedBox(height: getProportionateScreenWidth(30),),
            buildLastNameFormField(),
            SizedBox(height: getProportionateScreenWidth(30),),
            buildPhoneNumberFormField(),
            SizedBox(
              height: getProportionateScreenWidth(30),
            ),
            buildAddressFormField(),
            FormError(errors: errors),
            SizedBox(height: getProportionateScreenWidth(40),),
            DefaultButton(
                text: "Continuer",
                press: () async {
                  // Fournisseur d'accès Internet
                  final sp = context.read<SignInProvider>();
                  final ip = context.read<InternetProvider>();
                  await ip.checkInternetConnection();
                  // Vérifie si l'utilisateur est connecté à Internet
                  if (ip.hasInternet == false) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Color(0x00FFFFFF),
                      elevation: 0,
                      content: AwesomeSnackbarContent(
                        title: 'Oh Hey!!',
                        message: "Vérifiez votre connexion Internet",
                        contentType: ContentType.failure,
                        messageFontSize: getProportionateScreenWidth(15),
                      ),
                    ));
                  } else {
                    if (_formKey.currentState!.validate()) {
                      final user = UserAuth(
                          firstname: _ctrfirstname.text.trim(),
                          lastname: _ctrlastname.text,
                          phonenumber: _ctrphonenumber.text.trim(),
                          address: _ctradresse.text,
                          email: '',
                          uid: '');
                      addUser(user);

                      // Sauvegarder les données dans le sharedPreferences
                      await sp.getUserDataFromFirestoreForAuth().then((value) => sp
                          .saveDataToSharedPreferences()
                          .then((value) => sp.setSignIn().then((value) {})));

                      await FirebaseAuth.instance.verifyPhoneNumber(
                        phoneNumber: '+225${_ctrphonenumber.text.trim()}',
                        verificationCompleted: (PhoneAuthCredential credential) {},
                        verificationFailed: (FirebaseAuthException e) {},
                        codeSent: (String verificationId, int? resendToken) {
                          Navigator.pushNamed(context, OTPScreen.routeName,
                              arguments: {
                            'verificationId': verificationId,
                          });
                        },
                        codeAutoRetrievalTimeout: (String verificationId) {},
                      );

                      print('+225${_ctrphonenumber.text.trim()}');

                    }
                  }
                }),
          ],
        ));
  }

  TextFormField buildFirstNameFormField() {
    return TextFormField(
      controller: _ctrfirstname,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNamelNullError);
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kNamelNullError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Prénom",
        hintText: "Entrez votre prénom",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(
          svgIcon: "assets/icons/User.svg",
        ),
      ),
    );
  }

  TextFormField buildLastNameFormField() {
    return TextFormField(
      controller: _ctrlastname,
      // onSaved: (newValue) => LastName=newValue!,
      decoration: const InputDecoration(
        labelText: "Nom",
        hintText: "Entrez votre nom",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(
          svgIcon: "assets/icons/User.svg",
        ),
      ),
    );
  }

  TextFormField buildPhoneNumberFormField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      controller: _ctrphonenumber,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPhoneNumberNullError);
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPhoneNumberNullError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Numéro de téléphone",
        hintText: "Entrez votre numéro de téléphone",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(
          svgIcon: "assets/icons/Phone.svg",
        ),
      ),
    );
  }

  TextFormField buildAddressFormField() {
    return TextFormField(
      keyboardType: TextInputType.streetAddress,
      controller: _ctradresse,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kAddressNullError);
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kAddressNullError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Adresse",
        hintText: "Entrez votre adresse",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(
          svgIcon: "assets/icons/Location point.svg",
        ),
      ),
    );
  }


  void sendOTP(String phoneNumber) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {},
      verificationFailed: (FirebaseAuthException e) {
        showCustomSnackBar("erreur sur le numero fourni.",ContentType.failure);
      },
      codeSent: (String verificationId, int? resendToken) {

        Navigator.pushNamed(context, OTPScreen.routeName,
            arguments: {
              'verificationId': verificationId,
            });
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  void showCustomSnackBar(String message, ContentType Content) {
    ScaffoldMessenger.of(context as BuildContext).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.fixed,
        backgroundColor: Color(0x00FFFFFF),
        elevation: 0,
        content: AwesomeSnackbarContent(
          title: 'Code OTP incorrect',
          message: message,
          contentType: Content,
          messageFontSize: getProportionateScreenWidth(15),
        ),
      ),
    );
  }
}
