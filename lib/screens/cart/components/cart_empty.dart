import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shopapp/components/default_button.dart';
import 'package:shopapp/components/main_screens.dart';
import 'package:shopapp/size_config.dart';

class EmptyCart extends StatelessWidget {
  static String routeName='cart/components';
  const EmptyCart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F6F9),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Lottie.asset("assets/lottiefiles/116422-shopping-cart.json",),
            Text("TON PANIER EST VIDE. DÉCOUVRE LES NOUVEAUTÉS.",
              style: TextStyle(
                  color:Colors.black.withOpacity(0.8),
                  fontWeight: FontWeight.bold,
                  fontSize: getProportionateScreenWidth(15)
              ),
              textAlign: TextAlign.center,),
            Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: getProportionateScreenHeight(50)),
              child: DefaultButtonEmpty(text: "MAGASINE", press: (){
                Navigator.pushNamed(context, MainScreen.routeName,arguments: 0);
              }),
            ),
            SizedBox(height: getProportionateScreenHeight(20),),
          ],
        ),
      ),
    );
  }
}