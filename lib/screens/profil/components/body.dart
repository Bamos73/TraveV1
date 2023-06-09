// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/constants.dart';
import 'package:shopapp/provider/sign_in_provider.dart';
import 'package:shopapp/screens/Privacy_Policy/Privacy_Policy_Screen.dart';
import 'package:shopapp/screens/my_account/my_account_screen.dart';
import 'package:shopapp/screens/profil/components/profil_menu.dart';
import 'package:shopapp/screens/profil/components/profile_pic.dart';
import 'package:shopapp/screens/sign_in/sign_in_screen.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  Future getData() async {
    final sp = context.read<SignInProvider>();
    sp.getDataFromSharedPreferences();
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    final sp = context.watch<SignInProvider>();

    return SingleChildScrollView(
      child: Column(
        children: [
          ProfilePic(),
          const SizedBox(
            height: 20,
          ),
          ProfilMenu(
            text: "My Account",
            icon: LineAwesomeIcons.user,
            press: () =>
                Navigator.pushNamed(context, MyAccountScreen.routeName),
          ),
          ProfilMenu(
            text: "Privacy Policy",
            icon: LineAwesomeIcons.user_shield,
            press: () {
              nextScreenReplace(context, const PrivacyPolicyScreen());
            },
          ),
          ProfilMenu(
            text: "Notifications",
            icon: LineAwesomeIcons.bell,
            press: () {},
          ),
          ProfilMenu(
            text: "Settings",
            icon: LineAwesomeIcons.cog,
            press: () {},
          ),
          ProfilMenu(
            text: 'Help Center',
            icon: LineAwesomeIcons.question_circle,
            press: () {},
          ),
          ProfilMenu(
              text: "Log Out",
              icon: LineAwesomeIcons.alternate_sign_out,
              press: () async {
                sp.userSignOut();
                nextScreenReplace(context, SignInScreen());
              }),
        ],
      ),
    );
  }
}
