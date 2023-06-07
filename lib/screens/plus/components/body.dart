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
import 'package:shopapp/screens/order/order_screen.dart';
import 'package:shopapp/screens/payment/components/adresse_list_livraison.dart';
import 'package:shopapp/screens/plus/components/profil_menu.dart';
import 'package:shopapp/screens/plus/components/profile_pic.dart';
import 'package:shopapp/screens/sign_in/sign_in_screen.dart';

import '../../Term_And_Condition/term_and_condition_screen.dart';

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
            text: "Mon compte",
            icon: LineAwesomeIcons.user,
            press: () =>
                Navigator.pushNamed(context, MyAccountScreen.routeName),
          ),
          ProfilMenu(
            text: "Mes commandes",
            icon: LineAwesomeIcons.wallet,
            press: () =>
                Navigator.pushNamed(context, OrderScreen.routeName),
          ),
          ProfilMenu(
            text: "Mes adresses",
            icon: LineAwesomeIcons.map_marked,
            press: () =>
                Navigator.pushNamed(context, AdresseLivraison.routeName),
          ),
          ProfilMenu(
            text: "Notifications",
            icon: LineAwesomeIcons.bell,
            press: () {},
          ),
          ProfilMenu(
            text: "Politique de confidentialité",
            icon: LineAwesomeIcons.user_shield,
            press: () {
              nextScreenReplace(context, const PrivacyPolicyScreen());
            },
          ),
          ProfilMenu(
            text: "Conditions d'utilisation",
            icon: LineAwesomeIcons.copyright,
            press: () {
              nextScreenReplace(context, const TermAndConditionScreen());
            },
          ),
          ProfilMenu(
            text: 'Centre d\'aide',
            icon: LineAwesomeIcons.question_circle,
            press: () {},
          ),
          ProfilMenu(
              text: "Déconnexion",
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
