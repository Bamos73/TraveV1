import 'package:flutter/material.dart';
import 'package:shopapp/components/default_button.dart';
import 'package:shopapp/constants.dart';
import 'package:shopapp/screens/payment/components/adresse_list_livraison.dart';
import 'package:shopapp/size_config.dart';

class NewAdresse extends StatefulWidget {
  const NewAdresse({Key? key}) : super(key: key);
  static String routeName = "payment/components";

  @override
  State<NewAdresse> createState() => _NewAdresseState();
}

class _NewAdresseState extends State<NewAdresse> {
  final _formKey = GlobalKey<FormState>();
  late String email;
  late String password = '';
  late String conform_password;

  final List<String> errors = [];

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
    return Scaffold(
      backgroundColor: Color(0xFFF5F6F9),
      appBar: AppBar(
        title: Text(
          "AJOUTER UNE NOUVELLE ADRESSE",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: getProportionateScreenWidth(15),
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            nextScreenReplace(context, AdresseLivraison());
          },
          child: Icon(Icons.arrow_back_ios, weight: 100),
        ),
      ),
      // body: Form(
      //   child: Column(
      //     children: [
      //       Row(
      //         children: [
      //           TextFormField(
      //
      //           )
      //         ],
      //       )
      //     ],
      //   ),
      // ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          left: getProportionateScreenWidth(80),
          right: getProportionateScreenWidth(80),
          bottom: getProportionateScreenHeight(30),
        ),
        child: DefaultButton(
          text: "AJOUTER UNE ADRESSE",
          press: () {
            // Action pour ajouter une nouvelle adresse
          },
        ),
      ),
    );
  }
}
