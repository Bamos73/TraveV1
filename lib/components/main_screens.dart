// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:shopapp/screens/category/category_screen.dart';
import 'package:shopapp/screens/favory/favorie_screen.dart';
import 'package:shopapp/screens/otp/otp_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/plus/profil_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  static String routeName = "/components";

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int pageIndex = 0;
  List<Widget> pageList = <Widget>[
    HomeScreen(),
    CategoryScreen(),
    FavorieScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: pageList[pageIndex],
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: BottomNavigationBar(
            currentIndex: pageIndex,
            selectedItemColor: Colors.black,
            onTap: (value) {
              setState(() {
                pageIndex = value;
              });
            },
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.polymer),
                  label: "Acceuil"),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.local_mall,
                  ),
                  label: "Categories"),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.favorite_border,
                  ),
                  label: "Favorie"),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.more_horiz,
                  ),
                  label: "Plus"),
            ],
          ),
        ),
      ),
    );
  }
}
