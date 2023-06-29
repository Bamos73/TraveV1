import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shopapp/components/default_button.dart';
import 'package:shopapp/components/main_screens.dart';
import 'package:shopapp/constants.dart';
import 'package:shopapp/screens/order/order_screen.dart';
import 'package:shopapp/size_config.dart';

class CommandeValide extends StatefulWidget {
  static String routeName = 'payment/components';

  const CommandeValide({Key? key}) : super(key: key);

  @override
  State<CommandeValide> createState() => _CommandeValideState();
}

class _CommandeValideState extends State<CommandeValide> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          Lottie.asset("assets/lottiefiles/96365-delivery-service-delivery-man.json"),
          Text.rich(
            TextSpan(
              text: "Votre commande a été enregistrée avec succès.\n",
              style: TextStyle(
                color: Colors.black.withOpacity(0.8),
                fontSize: getProportionateScreenWidth(15),
              ),
              children: [
                TextSpan(
                  text: "Suivre l'état de la commande",
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: kPrimaryColor,
                  ),
                  recognizer: TapGestureRecognizer()..onTap = () {
                    Navigator.pushNamed(context, OrderScreen.routeName);
                  },
                ),
                TextSpan(
                  text: " ou allez sur la page d'accueil",
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: getProportionateScreenHeight(50)),
            child: DefaultButtonEmpty(
              text: "PAGE D'ACCUEIL",
              press: () {
                Navigator.pushNamed(context, MainScreen.routeName);
              },
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(20)),
        ],
      ),
    );
  }
}
