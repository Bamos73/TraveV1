import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/screens/category/category_screen.dart';
import 'package:shopapp/screens/category_details/details_categorie_screen.dart';
import 'package:shopapp/screens/home/components/card_nouveaute.dart';
import 'package:shopapp/screens/home/components/categorie_popular.dart';
import 'package:shopapp/screens/home/components/home_cover.dart';
import 'package:shopapp/screens/home/components/home_header.dart';
import 'package:shopapp/screens/home/components/products_list.dart';
import 'package:shopapp/screens/home/components/section_title.dart';
import 'package:shopapp/screens/home/components/special_offers.dart';
import 'package:shopapp/service/local_notifications.dart';
import 'package:shopapp/size_config.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late Stream<QuerySnapshot<Map<String, dynamic>>> _productsStream1;
  late Stream<QuerySnapshot<Map<String, dynamic>>> _productsStream2;
  late Stream<QuerySnapshot<Map<String, dynamic>>> _productsStream3;
  late Stream<QuerySnapshot<Map<String, dynamic>>> _productsStream4;

  NotificationServices notificationServices = NotificationServices();
  @override
  void initState() {
    super.initState();
    _productsStream1 = FirebaseFirestore.instance
        .collection('Home_Collection')
        .doc("Home_NewCollection_product")
        .collection('Home_NewCollection_product')
        .snapshots();
    _productsStream2 = FirebaseFirestore.instance
        .collection('Home_Collection')
        .doc("Home_WomanCollection_product")
        .collection('Home_WomanCollection_product')
        .snapshots();
    _productsStream3 = FirebaseFirestore.instance
        .collection('Home_Collection')
        .doc("Home_MenCollection_product")
        .collection('Home_MenCollection_product')
        .snapshots();
    _productsStream4 = FirebaseFirestore.instance
        .collection('Home_Collection')
        .doc("Home_AccessoireCollection_product")
        .collection('Home_AccessoireCollection_product')
        .snapshots();

    notificationServices.requestNotificationPermission();
    notificationServices.forgroundMessage();
    notificationServices.firebaseInit(context);
    notificationServices.setupInteractMessage(context);
    notificationServices.isTokenRefresh();

    // notificationServices.getDeviceToken().then((value) {
    //   if (kDebugMode) {
    //     print('device token');
    //     print(value);
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: getProportionateScreenWidth(80),
                ),
                SectionTitle1(
                  text: "Spécialement pour toi",
                  press: () {},
                ),
                SpecialOffers(),
                SizedBox(
                  height: getProportionateScreenWidth(30),
                ),
                SectionTitle(
                  text: "Catégorie Populaire",
                  press: () {
                    Navigator.pushNamed(context, CategoryScreen.routeName);
                  },
                ),
                SizedBox(
                  height: getProportionateScreenWidth(20),
                ),
                CategoriePopular(),
                SizedBox(
                  height: getProportionateScreenWidth(20),
                ),
                SectionTitle(
                  text: "Nouvelle Collection",
                  press: () {
                    Navigator.pushNamed(context, DetailCtgScreen.routeName,
                        arguments: {
                          'nom_document': 'Home_NewCollection_product',
                          'titre_categorie': 'Nouveauté',
                          'first_collection': 'Home_Collection',
                        });
                  },
                ),
                SizedBox(
                  height: getProportionateScreenWidth(20),
                ),
                ProductsList(
                  productsStream: _productsStream1,
                  collectionName: 'Home_NewCollection_product',
                ),
                SizedBox(
                  height: getProportionateScreenWidth(30),
                ),
                HomeCover(
                    homeCoverStream: FirebaseFirestore.instance
                        .collection('Home')
                        .doc("HomeCover_1")
                        .snapshots()),
                SizedBox(
                  height: getProportionateScreenWidth(30),
                ),
                SectionTitle(
                  text: "Collection Femme",
                  press: () {
                    Navigator.pushNamed(context, DetailCtgScreen.routeName,
                        arguments: {
                          'nom_document': 'Home_WomanCollection_product',
                          'titre_categorie': 'Collection Femme',
                          'first_collection': 'Home_Collection',
                        });
                  },
                ),
                SizedBox(
                  height: getProportionateScreenWidth(20),
                ),
                ProductsList(
                  productsStream: _productsStream2,
                  collectionName: 'Home_WomanCollection_product',
                ),
                SizedBox(
                  height: getProportionateScreenWidth(30),
                ),
                HomeCover(
                    homeCoverStream: FirebaseFirestore.instance
                        .collection('Home')
                        .doc("HomeCover_2")
                        .snapshots()),
                SizedBox(
                  height: getProportionateScreenWidth(30),
                ),
                SectionTitle(
                  text: "Collection Homme",
                  press: () {
                    Navigator.pushNamed(context, DetailCtgScreen.routeName,
                        arguments: {
                          'nom_document': 'Home_MenCollection_product',
                          'titre_categorie': 'Collection Homme',
                          'first_collection': 'Home_Collection',
                        });
                  },
                ),
                SizedBox(
                  height: getProportionateScreenWidth(20),
                ),
                ProductsList(
                  productsStream: _productsStream3,
                  collectionName: 'Home_MenCollection_product',
                ),
                SizedBox(
                  height: getProportionateScreenWidth(30),
                ),
                HomeCover(
                    homeCoverStream: FirebaseFirestore.instance
                        .collection('Home')
                        .doc("HomeCover_3")
                        .snapshots()),
                SizedBox(
                  height: getProportionateScreenWidth(30),
                ),
                SectionTitle(
                  text: "Accessoire",
                  press: () {
                    Navigator.pushNamed(context, DetailCtgScreen.routeName,
                        arguments: {
                          'nom_document': 'Home_AccessoireCollection_product',
                          'titre_categorie': 'Accessoire',
                          'first_collection': 'Home_Collection',
                        });
                  },
                ),
                SizedBox(
                  height: getProportionateScreenWidth(20),
                ),
                ProductsList(
                  productsStream: _productsStream4,
                  collectionName: 'Home_AccessoireCollection_product',
                ),
                SizedBox(
                  height: getProportionateScreenWidth(30),
                ),
                HomeCover(
                    homeCoverStream: FirebaseFirestore.instance
                        .collection('Home')
                        .doc("HomeCover_4")
                        .snapshots()),
                SizedBox(
                  height: getProportionateScreenWidth(30),
                ),
                Text(
                  "Nouveautés a la mode",
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(18),
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: getProportionateScreenWidth(20),
                ),
                CardNouveaute(),
                SizedBox(
                  height: getProportionateScreenWidth(20),
                ),
              ],
            ),
          ),
          HomeHeader(),
        ],
      ),
    );
  }
}
