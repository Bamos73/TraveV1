import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shopapp/components/default_button.dart';
import 'package:shopapp/components/main_screens.dart';
import 'package:shopapp/size_config.dart';

class EmptyCart extends StatelessWidget {
  const EmptyCart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Lottie.asset("assets/lottiefiles/96365-delivery-service-delivery-man.json"),
          ),
          Text("TON PANIER EST VIDE. DÉCOUVRE LES NOUVEAUTÉS.",
            style: TextStyle(
                color:Colors.black.withOpacity(0.8),
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