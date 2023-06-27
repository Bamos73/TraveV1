import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shopapp/components/default_button.dart';
import 'package:shopapp/constants.dart';
import 'package:shopapp/screens/address/components/adresse_new_livraison.dart';
import 'package:shopapp/size_config.dart';

class Address {
  String commune;
  String nom;
  String numero;
  String code;

  Address({
    required this.commune,
    required this.nom,
    required this.numero,
    required this.code,
  });
}

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  static String routeName="/address";


  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
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
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios, weight: 100),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: addressesCollection.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
                child: Text('Erreur de chargement des adresses.')
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container();
          }
          List<Address> addresses = snapshot.data!.docs.map((doc) {
            Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
            if (data != null) {
              return Address(
                commune: data['Commune'] ?? '',
                nom: data['Nom'] ?? '',
                numero: data['numero_de_livraison'] ?? '',
                code: data['Code'] ?? '',
              );
            } else {

              return Address(
                commune: '',
                nom: '',
                numero: '',
                code: '',
              );
            }
          }).toList();

          if (addresses.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Lottie.asset("assets/lottiefiles/12587-delivery-address.json",),
                Text(
                  'Aucune adresse enregistrée.',
                  style: TextStyle(fontSize: getProportionateScreenHeight(18)),
                ),
              ],
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
                          "${address.nom}",
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(13),
                          ),
                        ),
                        value: "${address.commune}",
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${address.commune}"),
                            Text(address.numero),
                          ],
                        ),
                        secondary: GestureDetector(
                          onTap: () {
                            if (snapshot.hasData) {
                              showCustomDialog(context, snapshot.data!.docs[index].id);
                            }
                          },
                          child: Icon(Icons.delete_forever),
                        ),
                        groupValue: _selectedOption,
                        onChanged: (value) {
                          setState(() {
                            _selectedOption = value as String;
                          });
                          UpdateselectedOption(_selectedOption, address.numero as String,address.nom as String);
                          Navigator.pop(context);
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
        child: DefaultButtonEmpty(
          text: "AJOUTER UNE ADRESSE",
          press: () {

            Navigator.pushNamed(context, NewAdresse.routeName);
          },
        ),
      ),
    );
  }

  void UpdateselectedOption(String optionTake,String numero,String nom,) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      final userCardRef = FirebaseFirestore.instance.collection('users').doc(userId);
      await userCardRef.set({
        'adresse_de_livraison': optionTake,
        'numero_de_livraison': numero,
        'nom_de_livraison': '$nom',
      }, SetOptions(merge: true));
    }
  }

  void showCustomDialog(BuildContext context, String documentId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Container(
            padding: EdgeInsets.all(15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Voulez-vous vraiment supprimer cette adresse ?',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: getProportionateScreenWidth(14)),
                ),
                SizedBox(height: getProportionateScreenHeight(15)),
                Divider(thickness: 1,height: 1),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextButton(
                        child: Text('Non',style: TextStyle(color: Color(0xFF858585),fontWeight:FontWeight.bold,fontSize: getProportionateScreenWidth(14)),),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                    Container(
                      width: 1,
                      height: 25,
                      color: Color(0xFF858585),
                      margin: EdgeInsets.symmetric(horizontal: 10),
                    ),
                    Expanded(
                      child: TextButton(
                        child: Text(
                          'Oui',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: getProportionateScreenWidth(14),
                          ),
                        ),
                        onPressed: () {
                          FirebaseFirestore.instance
                              .collection('users')
                              .doc(FirebaseAuth.instance.currentUser?.uid)
                              .collection('adresse_livraison')
                              .doc(documentId) // Utilisez le documentId pour spécifier le document à supprimer
                              .delete()
                              .then((_) {
                          }).catchError((error) {
                            print('Erreur lors de la suppression du document: $error');
                          });
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
