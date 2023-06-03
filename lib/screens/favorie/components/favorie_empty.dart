import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shopapp/components/default_button.dart';
import 'package:shopapp/components/main_screens.dart';
import 'package:shopapp/size_config.dart';

class EmptyFavorie extends StatelessWidget {
  static String routeName='favorie/components';
  const EmptyFavorie({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Lottie.asset("assets/lottiefiles/116422-shopping-cart.json",),
          ),
          Text("TON PANIER EST VIDE. DÉCOUVRE LES NOUVEAUTÉS.",
            style: TextStyle(
                color:Colors.black.withOpacity(0.8),
                fontWeight: FontWeight.bold,
                fontSize: getProportionateScreenWidth(15)
            ),
            textAlign: TextAlign.center,),
          SizedBox(height: getProportionateScreenHeight(30),),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: getProportionateScreenHeight(50)),
            child: DefaultButton(text: "MAGASINE", press: (){
              Navigator.pushNamed(context, MainScreen.routeName);
            }),
          )
        ],
      ),
    );
  }
}