import 'package:flutter/material.dart';
import 'package:shopapp/size_config.dart';

class StatusText extends StatelessWidget {
  final String statut;

  const StatusText({Key? key, required this.statut}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color textColor;

    if (statut == "En Cours") {
      textColor = Colors.blue;
    } else if (statut == "Annulé") {
      textColor = Colors.red;
    } else if (statut == "Livré") {
      textColor = Colors.green;
    } else {
      // Couleur par défaut si le statut n'est pas reconnu
      textColor = Colors.blue;
    }

    return Text(
      statut,
      style: TextStyle(
        color: textColor,
        fontSize: getProportionateScreenWidth(13),
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
