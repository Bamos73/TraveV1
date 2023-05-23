import 'package:flutter/material.dart';
import 'package:shopapp/authentification/user_add_livraison_addresse.dart';
import 'package:shopapp/components/custom_surfix_icon.dart';
import 'package:shopapp/components/default_button.dart';
import 'package:shopapp/components/form_error.dart';
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
  final List<String?> errors = [];

  final _ctrfirstname = TextEditingController();
  final _ctrlastname = TextEditingController();
  final _ctrphonenumber = TextEditingController();
  final _ctrcommune = TextEditingController();
  final _ctrquartier = TextEditingController();


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
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: getProportionateScreenWidth(30),),
              buildFirstName(),
              SizedBox(height: getProportionateScreenWidth(30),),
              buildLastName(),
              SizedBox(height: getProportionateScreenWidth(30),),
              buildNumber(),
              SizedBox(height: getProportionateScreenWidth(30),),
              buildCommune(),
              SizedBox(height: getProportionateScreenWidth(30),),
              buildQuartier(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(30)),
                child: FormError(errors: errors),
              ),
              SizedBox(height: getProportionateScreenWidth(30),),

            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          left: getProportionateScreenWidth(80),
          right: getProportionateScreenWidth(80),
          bottom: getProportionateScreenHeight(30),
        ),
        child: DefaultButton(
          text: "AJOUTER UNE ADRESSE",
          press: () {
            if (_formKey.currentState!.validate()) {
              final user = UserAuth(
                  nom: _ctrfirstname.text.trim(),
                  prenom: _ctrlastname.text,
                  phonenumber: _ctrphonenumber.text.trim(),
                  commune: _ctrcommune.text.trim(),
                  quartier: _ctrquartier.text.trim(),

              );
              addUser(user);
              _ctrfirstname.text = '';
              _ctrlastname.text = '';
              _ctrphonenumber.text = '';
              _ctrcommune.text = '';
              _ctrquartier.text = '';
              nextScreenReplace(context, AdresseLivraison());
            }
          },
        ),
      ),
    );
  }

  Padding buildFirstName() {
    return Padding(
            padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(30)),
            child: TextFormField(
              controller: _ctrfirstname,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  removeError(error: kNamelNullError);
                } else {
                  addError(error: kNamelNullError);
                }
              },
              validator: (value) {
                if (value!.isEmpty) {
                  addError(error: kNamelNullError);
                  return "";
                }
                return null;
              },
              decoration: const InputDecoration(
                labelText: "Nom",
                hintText: "Entrer votre nom",
                floatingLabelBehavior: FloatingLabelBehavior.always,
                suffixIcon: Icon(Icons.person_pin_circle),
              ),
            ),
          );
  }

  Padding buildLastName() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(30)),
      child: TextFormField(
        controller: _ctrlastname,
        onChanged: (value) {
          if (value.isNotEmpty) {
            removeError(error: kNamelNullError);
          } else {
            addError(error: kNamelNullError);
          }
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
          hintText: "Entrer votre prénom",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.person_pin_circle),
        ),
      ),
    );
  }

  Padding buildCommune() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(30)),
      child: TextFormField(
        controller: _ctrcommune,
        onChanged: (value) {
          if (value.isNotEmpty) {
            removeError(error: kNamelNullError);
          } else {
            addError(error: kNamelNullError);
          }
        },
        validator: (value) {
          if (value!.isEmpty) {
            addError(error: kNamelNullError);
            return "";
          }
          return null;
        },
        decoration: const InputDecoration(
          labelText: "Commune",
          hintText: "Entrer le nom de votre commune",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.map),
        ),
      ),
    );
  }
  Padding buildQuartier() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(30)),
      child: TextFormField(
        controller: _ctrquartier,
        onChanged: (value) {
          if (value.isNotEmpty) {
            removeError(error: kNamelNullError);
          } else {
            addError(error: kNamelNullError);
          }
        },
        validator: (value) {
          if (value!.isEmpty) {
            addError(error: kNamelNullError);
            return "";
          }
          return null;
        },
        decoration: const InputDecoration(
          labelText: "Quartier",
          hintText: "Entrer le nom de votre quartier",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.pin_drop),
        ),
      ),
    );
  }
  Padding buildNumber() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(30)),
      child: TextFormField(
        controller: _ctrphonenumber,
        keyboardType: TextInputType.number,
        onChanged: (value) {
          if (value.isNotEmpty) {
            removeError(error: kNamelNullError);
          } else {
            addError(error: kNamelNullError);
          }
        },
        validator: (value) {
          if (value!.isEmpty) {
            addError(error: kNamelNullError);
            return "";
          }
          return null;
        },
        decoration: const InputDecoration(
          labelText: "Numéro",
          hintText: "Entrer votre numero de téléphone",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.call),
        ),
      ),
    );
  }

}
