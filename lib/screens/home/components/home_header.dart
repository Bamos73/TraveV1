import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/components/buttom_card.dart';
import 'package:shopapp/constants.dart';
import 'package:shopapp/screens/cart/cart_screen.dart';
import 'package:shopapp/screens/cart/components/test.dart';
import 'package:shopapp/components/buttom_bell.dart';
import 'package:shopapp/size_config.dart';
import 'package:flutter/services.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader({Key? key}) : super(key: key);

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  List searchResult = [];
  bool isSearching = false;
  final _ctrresearch = TextEditingController();

  void searchFromFirebase(String query) async {
    final result = await FirebaseFirestore.instance
        .collection('Category')
        .where('keyword', arrayContains: query)
        .get();

    setState(() {
      searchResult = result.docs.map((e) => e.data()).toList();
    });
  }

  void startSearch() {
    setState(() {
      isSearching = true;
    });
  }

  void endSearch() {
    setState(() {
      isSearching = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20),
                vertical: getProportionateScreenHeight(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AnimatedContainer(
                  duration: Duration(milliseconds: 100),
                  width: !isSearching
                      ? getProportionateScreenWidth(220)
                      : getProportionateScreenWidth(245),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextField(
                    onTap: startSearch,
                    controller: _ctrresearch,
                    readOnly: !isSearching,
                    onChanged: (value) {
                      searchFromFirebase(value);
                    },
                    decoration: InputDecoration(
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      hintText: "Rechercher un produit",
                      prefixIcon: const Icon(
                        Icons.search,
                        color: kPrimaryColor,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(20),
                        vertical: getProportionateScreenWidth(9),
                      ),
                    ),
                  ),
                ),
                if (isSearching==false)
                DelayedDisplay(
                  delay: Duration(milliseconds: 10),
                      fadingDuration: Duration(milliseconds: 70),
                      child: ButtomCard(
                        svgSrc: "assets/icons/shopping_bag.svg",
                        press: () {
                          Navigator.pushNamed(context, CartScreen.routeName);
                          CartUpdateLivraison();
                        },
                        height: 46,
                        width: 46,
                        padding: 10,
                      ),
                    ),

                if (isSearching==false)
                DelayedDisplay(
                  delay: Duration(milliseconds: 10),
                  fadingDuration: Duration(milliseconds: 70),
                  child: ButtomBell(
                    svgSrc: "assets/icons/notifications_active.svg",
                    numOfItems: 3, // le nombre de Notification a parametrer après
                    press: () {
                      nextScreenReplace(context, MyApp());
                    },
                    height: 46,
                    width: 46,
                    padding: 10,
                  ),
                ),
                if (isSearching==true)
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isSearching = false;
                      _ctrresearch.text="";
                    });
                  },
                    child: Text("Annuler",
                      style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: getProportionateScreenWidth(16),
                          fontWeight: FontWeight.w400,
                      ),)),
              ],
            ),
          ),
        ),
        if (isSearching)
          Expanded(
            child: Container(
              color: Colors.white,
              child: ListView.builder(
                itemCount: searchResult.length,
                itemBuilder: (context, index) {

                  final categoryData = searchResult[index];
                  String title = categoryData['titre_categorie'] ?? "Nouveauté";
                  String image = categoryData['image'] ?? "https://firebasestorage.googleapis.com/v0/b/singup-a9273.appspot.com/o/Cat%C3%A9gorie%2FAbaya%2FAY0001%2Fjilbab.jpg?alt=media&token=0537c680-7fed-443b-963a-61e43f7eec2d";

                  return Column(
                    children: [
                      SizedBox(height: getProportionateScreenHeight(10),),
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.grey[300],
                          radius: 25,
                          backgroundImage: NetworkImage(image),
                        ),
                        title: Text(
                          title,
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
      ],
    );
  }
}
