import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/components/button_retour.dart';
import 'package:shopapp/components/buttom_card.dart';
import 'package:shopapp/components/default_button.dart';
import 'package:shopapp/constants.dart';
import 'package:shopapp/screens/cart/cart_screen.dart';
import 'package:slide_popup_dialog_null_safety/slide_popup_dialog.dart' as slideDialog;
import 'package:shopapp/size_config.dart';

class HeaderCategorie extends StatefulWidget {
  HeaderCategorie({
    Key? key,
    required this.titre_document,
    required this.onOrderByChanged,
    required this.colors,
    required this.tailles,
    required this.SelectedColor,
    required this.SelectedTaille,
    required this.startPrice,
    required this.endPrice,
    required this.onOrderByChangedFiltre,
  }) : super(key: key);

  final String titre_document;
  final ValueChanged<String> onOrderByChanged;
  final VoidCallback onOrderByChangedFiltre;
  final List<String> colors;
  final List<String> tailles;
  final List<bool> SelectedColor;
  final List<bool> SelectedTaille;
  double startPrice;
  double endPrice;

  @override
  State<HeaderCategorie> createState() => _HeaderCategorieState();
}

class _HeaderCategorieState extends State<HeaderCategorie> {
  String dropdownValue = 'NOUVEAUTÉS';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  ButtonRetour(),
                  Spacer(),
                  Text(
                    widget.titre_document,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: getProportionateScreenWidth(18),
                      color: Colors.black,
                    ),
                  ),
                  Spacer(),
                  ButtomCard(
                    svgSrc: "assets/icons/shopping_bag.svg",
                    press: () {
                      Navigator.pushNamed(context, CartScreen.routeName);
                      UpdateLivraisonAndPaiement();
                      },
                    height: 35,
                    width: 35,
                    padding: 5,
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: DropdownButton<String>(
                      value: dropdownValue,
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                          widget.onOrderByChanged(dropdownValue);
                        });
                      },
                      icon: Icon(
                        Icons.expand_more,
                        color: Color(0xFF858585),
                        size: getProportionateScreenHeight(20),
                      ),
                      underline: Container(),
                      items: <String>[
                        "PRIX BAS",
                        "PRIX HAUT",
                        "NOUVEAUTÉS"
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: getProportionateScreenWidth(12.5),
                              color: Color(0xFF858585),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                Container(
                  width: 1,
                  height: 25,
                  color: Color(0xFF858585),
                  margin: EdgeInsets.symmetric(horizontal: 10),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () {
                        showSlideDialog(context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('FILTRE',
                            style: TextStyle(
                              fontWeight:FontWeight.w400,
                              fontSize: getProportionateScreenWidth(12.5),
                              color: Color(0xFF858585),
                            ),
                          ),
                          SizedBox(width: 5,),
                          Icon(Icons.filter_list,color: kSecondaryColor,size: getProportionateScreenWidth(15),)
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: getProportionateScreenHeight(1),
            ),
            Container(
              width: double.infinity,
              height: 1,
              color: Color(0xFF858585),
            )
          ],
        ),
      ],
    );
  }

  void showSlideDialog(BuildContext context) {
    slideDialog.showSlideDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.6),
      pillColor: kPrimaryColor,
      backgroundColor: Colors.white,
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Prix',
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(16),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            RangeSlider(
              values: RangeValues(widget.startPrice,widget.endPrice),
              min: 0.0,
              max: 100000.0,
              activeColor: kPrimaryColor,
              divisions: 500 ,
              labels: RangeLabels(widget.startPrice.toString(),widget.endPrice.toString()),
              inactiveColor: kPrimaryColor.withOpacity(0.2),
              onChanged: (value) {
                setState(() {
                  widget.startPrice = value.start;
                  widget.endPrice=value.end;
                });
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(
                    TextSpan(
                        text: 'Prix Min : ${widget.startPrice.toInt()} FCFA',
                        style: TextStyle(
                          color: kSecondaryColor.withOpacity(0.5),
                          fontSize: getProportionateScreenWidth(13),
                        )
                    )
                ),
                Text.rich(
                    TextSpan(
                      text: 'Prix Max : ${widget.endPrice.toInt()} FCFA',
                      style: TextStyle(
                        color: kSecondaryColor.withOpacity(0.5),
                        fontSize: getProportionateScreenWidth(13),),
                    )
                ),
              ],),
            SizedBox(height: 20.0),
            Center(child: Text(
              'Couleurs',
              style: TextStyle(
                fontSize: getProportionateScreenWidth(16),
                fontWeight: FontWeight.bold,
              ),)),
            SizedBox(height: getProportionateScreenHeight(5)),
            Wrap(
              spacing: getProportionateScreenWidth(10),
              children: [
                filterChipColor(0, widget.colors[0]),
                filterChipColor(1, widget.colors[1]),
                filterChipColor(2, widget.colors[2]),
                filterChipColor(3, widget.colors[3]),
                filterChipColor(4, widget.colors[4]),
                filterChipColor(5, widget.colors[5]),
                filterChipColor(6, widget.colors[6]),
                filterChipColor(7, widget.colors[7]),
                filterChipColor(7, widget.colors[8]),
              ],
            ),
            SizedBox(height: 5.0),
            Center(child: Text(
              'Tailles',
              style: TextStyle(
                fontSize: getProportionateScreenWidth(16),
                fontWeight: FontWeight.bold,
              ),)),
            SizedBox(height: getProportionateScreenHeight(5)),
            Center(
              child: Wrap(
                spacing: getProportionateScreenWidth(10),
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  filterChipTaille(0, widget.tailles[0]),
                  filterChipTaille(0, widget.tailles[1]),
                  filterChipTaille(1, widget.tailles[2]),
                  filterChipTaille(2, widget.tailles[3]),
                  filterChipTaille(3, widget.tailles[4]),
                  filterChipTaille(4, widget.tailles[5]),
                ],
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(40)),
            DefaultButton(
              text: 'Filtrer',
              press: () {
                applyFilters();
                Navigator.of(context).pop(); // Ferme la boîte de dialogue
              },
            ),
          ],
        ),
      ),
    );
  }

  bool anyFilterSelected() {
    return widget.SelectedColor.any((selected) => selected) ||
        widget.SelectedTaille.any((selected) => selected);
  }
  void applyFilters() {
    if (anyFilterSelected()) {
      // widget.onOrderByChangedFiltre();
    } else {
      // Aucun filtre sélectionné, affichez un message d'erreur ou effectuez une autre action appropriée
      print('Aucun filtre sélectionné');
    }
  }

  Widget filterChipColor(int index, String color) {
    return FilterChip(
      label: Text(color),
      labelStyle: TextStyle(
        color: Colors.black,
        fontSize: getProportionateScreenWidth(13),
      ),
      selected: widget.SelectedColor[index],
      onSelected: (isSelected) {
        setState(() {
          widget.SelectedColor[index] = isSelected;
        });
      },
      selectedColor: kPrimaryColor.withOpacity(0.2),
    );
  }

  Widget filterChipTaille(int index, String taille) {
    return FilterChip(
      label: Text(taille),
      labelStyle: TextStyle(
        color: Colors.black,
        fontSize: getProportionateScreenWidth(13),
      ),
      selected: widget.SelectedTaille[index],
      onSelected: (isSelected) {
        setState(() {
          widget.SelectedTaille[index] = isSelected;
        });
      },
      selectedColor: kPrimaryColor.withOpacity(0.2),
    );
  }

  void UpdateLivraisonAndPaiement() async {

    //Ajouter le mode de livraison et le mode de paiement
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      final userCardRefLiv = FirebaseFirestore.instance.collection('Livraison').doc('Mode_Livraison');
      final userCardDocLiv = await userCardRefLiv.get();

      if (userCardDocLiv.exists) {
        final userCardData = userCardDocLiv.data();

        //Changement du mode de Livraison par defaut a Régulier
        final userCardRefMode = FirebaseFirestore.instance.collection('users').doc(userId);
        await userCardRefMode.set({
          'frais_de_livraison': userCardData!['Regulier'],
          'mode_de_livraison': 'Regulier',
        }, SetOptions(merge: true));

        //Changement du mode de paiement par defaut a Expèces
        final userCardRefPaie = FirebaseFirestore.instance.collection('users').doc(userId);
        await userCardRefPaie.set({
          'mode_de_paiement': 'Espèces',
        }, SetOptions(merge: true));
      }
    }
  }


}
