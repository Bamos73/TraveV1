import 'package:flutter/material.dart';
import 'package:shopapp/components/custom_surfix_icon.dart';
import 'package:shopapp/components/default_button.dart';
import 'package:shopapp/screens/profil/components/profile_pic.dart';
import 'package:shopapp/size_config.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(children: [
      const ProfilePic(),
      const SizedBox(
        height: 40,
      ),
      Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
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
            buildnumberFormField(),
            SizedBox(
              height: getProportionateScreenWidth(30),
            ),
            buildPasswordFormField(),
            SizedBox(
              height: getProportionateScreenWidth(30),
            ),
            DefaultButton(text: "Edit Profil", press: () {}),
            SizedBox(
              height: getProportionateScreenWidth(30),
            ),
          ],
        ),
      )
    ]));
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Password",
        hintText: "Enter your first name",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: const CustomSurffixIcon(
          svgIcon: "assets/icons/Lock.svg",
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blue, width: 2),
          borderRadius: BorderRadius.circular(50),
        ),
      ),
    );
  }

  TextFormField buildnumberFormField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Phone Number",
        hintText: "Enter your first name",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: const CustomSurffixIcon(
          svgIcon: "assets/icons/Phone.svg",
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blue, width: 2),
          borderRadius: BorderRadius.circular(50),
        ),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Enter your first name",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: const CustomSurffixIcon(
          svgIcon: "assets/icons/Mail.svg",
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blue, width: 2),
          borderRadius: BorderRadius.circular(50),
        ),
      ),
    );
  }

  TextFormField buildNameFormField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "First Name",
        hintText: "Enter your first name",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: const CustomSurffixIcon(
          svgIcon: "assets/icons/User.svg",
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blue, width: 2),
          borderRadius: BorderRadius.circular(50),
        ),
      ),
    );
  }
}
