import 'package:flutter/material.dart';
import 'package:shopapp/size_config.dart';

const kPrimaryColor = Color(0xFF7e55f2);
// 0xFF48B82C  vert
// 0xFF0FADFF bleu
// 0xFF7e55f2 violet
const kPrimaryLightColor = Color(0xFFFFECDF);
const kErrorColor = Color(0xFFEF2E5B);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
);

const kSecondaryGradientColor = LinearGradient(
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
  colors: [Color(0xFFF13B3B), Color(0xFFF8ACAC)],
);

const kSecondaryColor = Color(0xFF979797);
// 0xFF979797
const kTextColor = Color(0xFF757575);

const kAnimationDuration = Duration(milliseconds: 200);

final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

bool isPasswordValid(String password) {
  String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])';
  RegExp regExp = new RegExp(pattern);
  return regExp.hasMatch(password);
}
final RegExp emailValidatorRegExp =
RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Veuillez saisir votre adresse e-mail";
const String kInvalidEmailError = "Veuillez saisir une adresse e-mail valide";
const String kPassNullError = "Veuillez saisir votre mot de passe";
const String kShortPassError = "Le mot de passe est trop court";
const String kNotStrongPassError =
    "doit contenir une lettre majuscule, une lettre minuscule et un chiffre";
const String kEmailExistPassError =
    "Ce compte existe déjà avec cette adresse e-mail.";
const String kMatchPassError = "Les mots de passe ne correspondent pas";
const String kNamelNullError = "Veuillez saisir votre nom";
const String kLastNamelNullError = "Veuillez saisir votre prenom";
const String kPhoneNumberNullError = "Veuillez saisir votre numéro de téléphone";
const String kAddressNullError = "Veuillez saisir votre adresse";
const String kCommuneNullError = "Veuillez saisir votre commune";
const String kQuartierNullError = "Veuillez saisir votre quartier";
const String kWrongEmailOrPassError = "Adresse e-mail ou mot de passe incorrect";
const String kEmailNotExistError = "Vous n'avez pas de compte avec cette adresse e-mail";
const String kTooManyRequestError = "L'utilisateur a été désactivé en raison de trop de tentatives de connexion échouées.";



final otpInputDecoration = InputDecoration(
  contentPadding:
      EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
  enabledBorder: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  border: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
    borderSide: BorderSide(
      color: kPrimaryColor,
    ),
  );
}

void nextScreen(context, page) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => page));
}

void nextScreenReplace(context, page) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => page));
}

class Config {
  static final app_icon = "assets/images/Profile Image.png";
  static final apikey_twitter ="aep6S9Zrz8OmQ8UJWnRjvCwpz";
  static final secretkey_twitter ="Mr7DhA7BQfskqeQvZVAZbkkFmvpPEbeugIR8mJuEJmQ9vGEdkd";
}

const String MapBoxToken = 'pk.eyJ1IjoidHJhdmVhcHAiLCJhIjoiY2xpb285YmN3MGFvdjNlbzFlM2IxdWM1NCJ9.sPOpAb5of3ovAKlTlHWbOw';
const String MapBoxId ='mapbox.mapbox-streets-v8';
const String MapBoxUrlTemplate ='https://api.mapbox.com/styles/v1/traveapp/climwptmh00lc01r17h234fjo/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoidHJhdmVhcHAiLCJhIjoiY2xpbXdlOXk4MGloOTNxcXJjd3dlMjcyeiJ9._rTseXD442UKgZfsMQZZCQ';