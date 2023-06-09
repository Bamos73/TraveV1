import 'package:flutter/material.dart';
import 'package:shopapp/components/default_button.dart';
import 'package:shopapp/components/main_screens.dart';
import 'package:shopapp/constants.dart';
import 'package:shopapp/size_config.dart';

class EmptyCart extends StatelessWidget {
  const EmptyCart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding:  EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(40),
            vertical: getProportionateScreenHeight(180)),
        child: Column(
          children: [
            Icon(Icons.shopping_cart_checkout,
              size: getProportionateScreenWidth(80),
              color: kSecondaryColor.withOpacity(0.6),),
            Text("TON PANIER EST VIDE. DÉCOUVRE LES NOUVEAUTÉS.",
              style: TextStyle(
                  color:Colors.black.withOpacity(0.8),
                  fontSize: getProportionateScreenWidth(15) ),
              textAlign: TextAlign.center,),
            Padding(
              padding: EdgeInsets.symmetric(vertical: getProportionateScreenHeight(20)),
              child: DefaultButton(text: "MAGASINE", press: (){
                Navigator.pushNamed(context, MainScreen.routeName);
              }),
            )
          ],
        ),
      ),
    );
  }
}