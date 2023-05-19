import 'package:flutter/material.dart';
import 'package:shopapp/components/button_close.dart';
import 'package:shopapp/constants.dart';
import 'package:shopapp/screens/details_categorie/components/header_filtre.dart';
import 'package:shopapp/size_config.dart';

class FiltresScreen extends StatefulWidget {
  const FiltresScreen({Key? key,}) : super(key: key);
  static String routeName="/details_categorie/components";


  @override
  State<FiltresScreen> createState() => _FiltresScreenState();
}

class _FiltresScreenState extends State<FiltresScreen> {

  final filtre = [
    {
      "titre": "CATEGORIE",
    },

    {
      "titre": "TAILLE",
    },

    {
      "titre": "COULEUR",
    },

    {
      "titre": "PROMO",
    },

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(10),
                  vertical: getProportionateScreenHeight(5)),
              child: header_card_filtre(titleCenter: 'FILTRE', titleRight: 'SUPPRIMER',),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: filtre.length,
                  itemBuilder: (context,index){
                    final Filtre = filtre[index];
                    final titre = Filtre['titre'];
                    return Container(
                      color: kSecondaryColor.withOpacity(0.2),
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(
                              '$titre',
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            trailing: Icon(Icons.chevron_right, color: kSecondaryColor),
                          ),
                          Divider(thickness: 1, height: 1), // séparateur en bas de la tuile
                        ],
                      ),
                    );
                  }
              ),
            )
          ],
        ),
      ),
    );
  }


}

