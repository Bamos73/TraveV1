import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/components/default_button.dart';
import 'package:shopapp/constants.dart';
import 'package:shopapp/screens/payment/components/adresse_new_livraison.dart';
import 'package:shopapp/screens/payment/payment_screen.dart';
import 'package:shopapp/size_config.dart';

class Address {
  String commune;
  String quartier;
  String nom;
  String prenom;
  String numero;
  String code;

  Address({
    required this.commune,
    required this.quartier,
    required this.nom,
    required this.prenom,
    required this.numero,
    required this.code,
  });
}

class AdresseLivraison extends StatefulWidget {
  const AdresseLivraison({Key? key}) : super(key: key);
  static String routeName = "payment/components";

  @override
  State<AdresseLivraison> createState() => _AdresseLivraisonState();
}

class _AdresseLivraisonState extends State<AdresseLivraison> {
  String _selectedOption = "";

  CollectionReference addressesCollection = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('adresse_livraison');

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(0xFFF5F6F9),
      appBar: AppBar(
        title: Text(
          "SELECTIONNER UNE ADRESSE",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: getProportionateScreenWidth(15),
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            nextScreenReplace(context, PaymentScreen());
          },
          child: Icon(Icons.arrow_back_ios, weight: 100),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: addressesCollection.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Erreur de chargement des adresses.'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          List<Address> addresses = snapshot.data!.docs.map((doc) {
            Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
            return Address(
              commune: data['Commune'],
              quartier: data['Quartier'],
              nom: data['Nom'],
              prenom: data['Prenom'],
              numero: data['Numero'],
              code: data['Code'],
            );
          }).toList();

          if (addresses.isEmpty) {
            return Center(
              child: Text(
                'Aucune adresse enregistrée.',
                style: TextStyle(fontSize: getProportionateScreenHeight(18)),
              ),
            );
          }
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: addresses.length,
                  itemBuilder: (BuildContext context, int index) {
                    Address address = addresses[index];
                    return Container(
                      color: Colors.white,
                      child: RadioListTile(
                        title: Text(
                          "${address.nom} ${address.prenom}",
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(13),
                          ),
                        ),
                        value: address.code,
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${address.commune}, ${address.quartier}"),
                            Text(address.numero),
                          ],
                        ),
                        secondary: Text("MODIFIER"),
                        groupValue: _selectedOption,
                        onChanged: (value) {
                          setState(() {
                            _selectedOption = value as String;
                          });
                          nextScreenReplace(context, PaymentScreen());
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          left: getProportionateScreenWidth(80),
          right: getProportionateScreenWidth(80),
          top: getProportionateScreenHeight(20),
          bottom: getProportionateScreenHeight(30),
        ),
        child: DefaultButton(
          text: "AJOUTER UNE ADRESSE",
          press: () {
            nextScreenReplace(context, NewAdresse());
          },
        ),
      ),
    );
  }
}
