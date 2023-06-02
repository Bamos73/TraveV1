import 'package:flutter/material.dart';
import 'package:shopapp/components/button_retour.dart';
import 'package:shopapp/components/buttom_card.dart';
import 'package:shopapp/components/default_button.dart';
import 'package:shopapp/constants.dart';
import 'package:shopapp/screens/cart/cart_screen.dart';
import 'package:slide_popup_dialog_null_safety/slide_popup_dialog.dart' as slideDialog;
import 'package:shopapp/size_config.dart';

class HeaderCategorie extends StatefulWidget {
  const HeaderCategorie({
    Key? key,
    required this.titre_document,
    required this.onOrderByChanged,
  }) : super(key: key);

  final String titre_document;
  final ValueChanged<String> onOrderByChanged;


  @override
  State<HeaderCategorie> createState() => _HeaderCategorieState();
}

class _HeaderCategorieState extends State<HeaderCategorie> {
  String dropdownValue = 'NOUVEAUTÉS'; // valeur par défaut

  double _startPrice = 0.0;
  double _endPrice = 100000.0;
  List<bool> _isSelectedColor = List.generate(9, (index) => false);
  List<bool> _isSelectedTaille = List.generate(6, (index) => false);

  List<String> _colors = ['Noir', 'Blanc', 'Gris', 'Bleu', 'Rouge','Vert','Orange','Rose','Autre'];
  List<String> _tailles = ['XXXL','XXL', 'XL', 'L', 'M', 'S',];

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
                    press: () =>
                        Navigator.pushNamed(context, CartScreen.routeName),
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
                          Icon(Icons.filter_list)
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
              values: RangeValues(_startPrice,_endPrice),
              min: 0.0,
              max: 100000.0,
              activeColor: kPrimaryColor,
              divisions: 500 ,
              labels: RangeLabels(_startPrice.toString(),_endPrice.toString()),
              inactiveColor: kPrimaryColor.withOpacity(0.2),
              onChanged: (value) {
                setState(() {
                  _startPrice = value.start;
                  _endPrice=value.end;
                });
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(
                    TextSpan(
                        text: 'Prix Min : ${_startPrice.toInt()} FCFA',
                        style: TextStyle(
                          color: kSecondaryColor.withOpacity(0.5),
                          fontSize: getProportionateScreenWidth(13),
                        )
                    )
                ),
                Text.rich(
                    TextSpan(
                      text: 'Prix Max : ${_endPrice.toInt()} FCFA',
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
                filterChipColor(0, _colors[0]),
                filterChipColor(1, _colors[1]),
                filterChipColor(2, _colors[2]),
                filterChipColor(3, _colors[3]),
                filterChipColor(4, _colors[4]),
                filterChipColor(5, _colors[5]),
                filterChipColor(6, _colors[6]),
                filterChipColor(7, _colors[7]),
                filterChipColor(7, _colors[8]),
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
                  filterChipTaille(0, _tailles[0]),
                  filterChipTaille(0, _tailles[1]),
                  filterChipTaille(1, _tailles[2]),
                  filterChipTaille(2, _tailles[3]),
                  filterChipTaille(3, _tailles[4]),
                  filterChipTaille(4, _tailles[5]),
                ],
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(40)),
            DefaultButton(
              text: 'Filtrer',
              press: () {
                // Ajoutez ici la logique pour filtrer les documents
                Navigator.of(context).pop(); // Ferme le dialogue
              },)
          ],
        ),
      ),
    );
  }


  Widget filterChipColor(int index, String color) {
    return FilterChip(
      label: Text(color),
      labelStyle: TextStyle(
        color: Colors.black,
        fontSize: getProportionateScreenWidth(13),
      ),
      selected: _isSelectedColor[index],
      onSelected: (isSelected) {
        setState(() {
          _isSelectedColor[index] = isSelected;
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
      selected: _isSelectedTaille[index],
      onSelected: (isSelected) {
        setState(() {
          _isSelectedTaille[index] = isSelected;
        });
      },
      selectedColor: kPrimaryColor.withOpacity(0.2),
    );
  }


}
