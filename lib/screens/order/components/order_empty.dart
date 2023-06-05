import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shopapp/components/default_button.dart';
import 'package:shopapp/components/main_screens.dart';
import 'package:shopapp/screens/order/components/custom_app_bar.dart';
import 'package:shopapp/size_config.dart';

class EmptyOrder extends StatelessWidget {
  static String routeName='favorie/components';
  const EmptyOrder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset("assets/lottiefiles/93134-not-found.json",),
                Text("TA LISTE DE COMMANDE EST VIDE. DÉCOUVRE LES NOUVEAUTÉS.",
                  style: TextStyle(
                      color:Colors.black.withOpacity(0.8),
                      fontWeight: FontWeight.bold,
                      fontSize: getProportionateScreenWidth(15)
                  ),
                  textAlign: TextAlign.center,),
                Spacer(),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenHeight(50),),
                  child: DefaultButtonEmpty(text: "MAGASINE", press: (){
                    Navigator.pushNamed(context, MainScreen.routeName);
                  }),
                ),
                SizedBox(height: getProportionateScreenHeight(20),)
              ],
          ),
            CustomAppBar(),
          ],
        ),
      ),
    );
  }
}