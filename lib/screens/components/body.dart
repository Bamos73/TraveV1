import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shopapp/components/default_button.dart';
import 'package:shopapp/constants.dart';
import 'package:shopapp/screens/components/splash_content.dart';
import 'package:shopapp/screens/sign_in/sign_in_screen.dart';
import 'package:shopapp/size_config.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);
  Timer? _timer;

  List<Map<String, String>> splashData = [
    {
      "text":
          "Bienvenue sur Trave ! Découvrez les \n meilleurs produits et services réligieux.",
      "image": "assets/images/splash_6.png"
    },
    {
      "text": "La puissance de la foi, disponible en un clic.",
      "image": "assets/images/splash_4.png"
    },
    {
      "text":
          "Des accessoires religieux pour vous\n accompagner dans votre quotidien.",
      "image": "assets/images/splash_5.png"
    },
  ];

  @override
  void initState() {
    super.initState();
    // Démarre le défilement automatique toutes les 3 secondes
    _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (currentPage < splashData.length - 1) {
        currentPage++;
      } else {
        currentPage = 0;
      }
      _pageController.animateToPage(
        currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemCount: splashData.length,
                itemBuilder: (context, index) => SplashContent(
                  text: splashData[index]['text']!,
                  image: splashData[index]["image"]!,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20)),
                child: Column(
                  children: <Widget>[
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                          splashData.length, (index) => buildDot(index: index)),
                    ),
                    const Spacer(
                      flex: 3,
                    ),
                    DefaultButton(
                      text: "Continue",
                      press: () {
                        Navigator.pushNamed(context, SignInScreen.routeName);
                      },
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot({required int index}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: const EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentPage == index ? kPrimaryColor : const Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
