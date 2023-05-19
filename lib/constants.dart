import 'package:flutter/material.dart';
import 'package:shopapp/size_config.dart';

const kPrimaryColor = Color(0xFF48B82C);
// 0xFF48B82C  vert
// 0xFF0FADFF bleu
// 0xFF7e55f2 violet
const kPrimaryLightColor = Color(0xFFFFECDF);
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
const String kEmailNullError = "Please Enter your email";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too short";
const String kNotStrongPassError =
    "must contain an uppercase letter,\na lowercase letter and a number";
const String kEmailExistPassError =
    "The account already exists for that email.";
const String kMatchPassError = "Passwords don't match";
const String kNamelNullError = "Please Enter your name";
const String kPhoneNumberNullError = "Please Enter your phone number";
const String kAddressNullError = "Please Enter your address";
const String kWrongEmailOrPassError = "incorrect email address or password";
const String kEmailNotExistError = "you do not have an account with \nthis email address";
const String kTooManyRequestError = "the user has been disabled due to\ntoo many failed login attempts.";

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
