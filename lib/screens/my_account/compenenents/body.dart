import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/components/custom_surfix_icon.dart';
import 'package:shopapp/components/default_button.dart';
import 'package:shopapp/constants.dart';
import 'package:shopapp/provider/sign_in_provider.dart';
import 'package:shopapp/screens/plus/components/profile_pic.dart';
import 'package:shopapp/size_config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
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
  final _ctrphonenumber = TextEditingController();
  final _ctradresse = TextEditingController();
  final _ctremail = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    final sp = context.watch<SignInProvider>();
    return SingleChildScrollView(
      child: Column(
        children: [
          const ProfilePic(),
          const SizedBox(
            height: 40,
          ),
          Padding(
            padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  buildNameFormField(),
                  SizedBox(
                    height: getProportionateScreenWidth(30),
                  ),
                  buildEmailFormField(),
                  SizedBox(
                    height: getProportionateScreenWidth(30),
                  ),
                  buildNumberFormField(),
                  SizedBox(
                    height: getProportionateScreenWidth(30),
                  ),
                  buildAddressFormField(),
                  SizedBox(
                    height: getProportionateScreenWidth(30),
                  ),
                  DefaultButton(
                    text: "Modifier le profil",
                    press: () {
                      _updateProfile(sp);
                    },
                  ),
                  SizedBox(
                    height: getProportionateScreenWidth(30),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  TextFormField buildNameFormField() {
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
        labelText: "Nom et Prénom",
        hintText: "Entrez votre nom et prénom",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(
          svgIcon: "assets/icons/User.svg",
        ),
      ),
    );
  }

  TextFormField buildNumberFormField() {
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

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: _ctremail,
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
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "E-mail",
        hintText: "Entrez votre e-mail",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(
          svgIcon: "assets/icons/Mail.svg",
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

  Future<void> fetchUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    final uid = user?.uid;

    final userRef = FirebaseFirestore.instance.collection('users').doc(uid);
    final userData = await userRef.get();

    if (userData.exists) {
      final data = userData.data() as Map<String, dynamic>;

      final email = data['email'];
      final address = data['Address'];
      final phoneNumber = data['Phonenumber'];
      final name = data['name'];

      _ctrfirstname.text = name;
      _ctremail.text = email;
      if (data['Phonenumber'] != null){
        _ctrphonenumber.text = phoneNumber;
        _ctradresse.text = address;
      }

    }
  }

  Future<void> _updateProfile(SignInProvider sp) async {
    final user = FirebaseAuth.instance.currentUser;
    final uid = user?.uid;

    final userRef = FirebaseFirestore.instance.collection('users').doc(uid);
    final userDoc = await userRef.get();
    final userData = await userDoc.data();

    if (userDoc.exists) {
      if (_formKey.currentState!.validate()) {
        final newEmail = _ctremail.text;
        final newName = _ctrfirstname.text;
        final newAdresse = _ctradresse.text;
        final newNumber = _ctrphonenumber.text;
        if (newEmail != user!.email ||
            newName != userData!['name'] ||
            newAdresse != userData['Address'] ||
            newNumber != userData['Phonenumber']) {
        if (newEmail != user.email) {
          // Mettre à jour l'adresse e-mail dans Firebase Authentication
          user.updateEmail(newEmail).then((_) {
            // Envoyer un e-mail de confirmation
            user.sendEmailVerification().then((_) {
              // Mettre à jour les données dans Firestore
              FirebaseFirestore.instance.collection('users').doc(uid).update({
                'email': newEmail,
                'Address': _ctradresse.text,
                'Phonenumber': _ctrphonenumber.text,
                'name': _ctrfirstname.text,
              }).then((value) {
                showCustomSnackBar(
                    "Profil mis à jour avec succès. Un e-mail de confirmation a été envoyé.",
                    ContentType.success);
              }).catchError((error) {
                showCustomSnackBar(
                    "Échec de la mise à jour du profil.", ContentType.failure);
              });
            }).catchError((error) {
              showCustomSnackBar(
                  "Échec de l'envoi de l'e-mail de confirmation.",
                  ContentType.failure);
            });
          }).catchError((error) {
            showCustomSnackBar("Échec de la mise à jour de l'adresse e-mail.",
                ContentType.failure);
          });
        } else {
          // L'adresse e-mail n'a pas été modifiée, mettre à jour les autres données seulement
          FirebaseFirestore.instance.collection('users').doc(uid).update({
            'Address': _ctradresse.text,
            'Phonenumber': _ctrphonenumber.text,
            'name': _ctrfirstname.text,
          }).then((value) {
            showCustomSnackBar(
                "Profil mis à jour avec succès.", ContentType.success);
          }).catchError((error) {
            showCustomSnackBar(
                "Échec de la mise à jour du profil.", ContentType.failure);
          });
        }
        await sp.getUserDataFromFirestoreForAuth();
        await sp.saveDataToSharedPreferences();
        sp.setSignIn();

      }else{
          showCustomSnackBar(
              "Aucun changement", ContentType.failure);
        }
        }

    }
  }


  void showCustomSnackBar(String message, ContentType content) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.fixed,
        backgroundColor: Color(0x00FFFFFF),
        elevation: 0,
        content: AwesomeSnackbarContent(
          title: 'Ohh Ohh!!',
          message: message,
          contentType: content,
          messageFontSize: getProportionateScreenWidth(15),
        ),
      ),
    );
  }
}
