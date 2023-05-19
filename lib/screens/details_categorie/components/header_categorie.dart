import 'package:flutter/material.dart';
import 'package:shopapp/components/button_retour.dart';
import 'package:shopapp/components/buttom_card.dart';
import 'package:shopapp/screens/cart/cart_screen.dart';
import 'package:shopapp/screens/details_categorie/components/filtre.dart';
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
                        Navigator.pushNamed(context, FiltresScreen.routeName);
                      },
                      child: Text(
                        "FILTRES",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: getProportionateScreenWidth(12.5),
                          color: Color(0xFF858585),
                        ),
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
}
