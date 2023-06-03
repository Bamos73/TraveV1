import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shopapp/components/default_button.dart';
import 'package:shopapp/components/main_screens.dart';
import 'package:shopapp/size_config.dart';

class EmptyCart extends StatefulWidget {
  static String routeName='payment/components';
  const EmptyCart({
    super.key,
  });

  @override
  State<EmptyCart> createState() => _EmptyCartState();
}

class _EmptyCartState extends State<EmptyCart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          Lottie.asset("assets/lottiefiles/96365-delivery-service-delivery-man.json"),
          Text("Votre commande a été enregistrée avec succès.",
            style: TextStyle(
                color:Colors.black.withOpacity(0.8),
                fontSize: getProportionateScreenWidth(15)
            ),
            textAlign: TextAlign.center,),
          Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: getProportionateScreenHeight(50)),
            child: DefaultButtonEmpty(text: "PAGE D'ACCUEIL", press: (){
              Navigator.pushNamed(context, MainScreen.routeName);
            }),
          ),
          SizedBox(height: getProportionateScreenHeight(20),),
        ],
      ),
    );
  }
}