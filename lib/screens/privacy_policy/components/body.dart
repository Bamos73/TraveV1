import 'package:flutter/material.dart';
import 'package:shopapp/constants.dart';
import 'package:shopapp/size_config.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(

      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal:getProportionateScreenWidth(25)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Text("Politique de confidentialité et de protection des données",
                style: TextStyle(
                    fontSize: getProportionateScreenWidth(20),
                    fontWeight: FontWeight.bold,
                  color: kPrimaryColor,
                ),
               textAlign: TextAlign.center,
             ),
            SizedBox(height: SizeConfig.screenHeight * 0.02,),
            Image.asset("assets/images/Security-pana.png"),
            Text("Nous sommes engagés à protéger la confidentialité et la sécurité des données personnelles de nos utilisateurs. Cette politique de confidentialité décrit comment nous collectons, utilisons et protégeons les données personnelles de nos utilisateurs. En utilisant notre application, vous acceptez les termes de cette politique de confidentialité.",
                style: TextStyle(
                    fontSize: getProportionateScreenWidth(15),
                  color: Colors.black,
                ),
            ),

            //***********************************Collecte de données************************//

            SizedBox(height: SizeConfig.screenHeight * 0.02,),
            Text("1. Collecte de données",
              style: TextStyle(
                fontSize: getProportionateScreenWidth(18),
                fontWeight: FontWeight.bold,
                color: kPrimaryColor,
              ),
            ),
            Divider(height: 3, color: Colors.black,),
             SizedBox(height: SizeConfig.screenHeight * 0.01,),
            Text("Nous collectons les données personnelles suivantes auprès de nos utilisateurs :",
              style: TextStyle(
                fontSize: getProportionateScreenWidth(15),
                color: Colors.black,
              ),
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.005,),
            Puce(puce: "Les informations d'identification : nom, adresse e-mail, photo de profil ;",),
            SizedBox(height: SizeConfig.screenHeight * 0.005,),
            Puce(puce: "Les informations de connexion : nom d'utilisateur, mot de passe, jetons d'accès ;",),
            SizedBox(height: SizeConfig.screenHeight * 0.005,),
            Puce(puce: "Les données d'utilisation : statistiques d'engagement, analyses de l'audience, préférences d'utilisateur ;",),
            SizedBox(height: SizeConfig.screenHeight * 0.005,),
            Puce(puce: "Les informations relatives à la géolocalisation (si l'utilisateur a activé cette fonctionnalité).",),


            //***********************************Utilisation des données************************//
            SizedBox(height: SizeConfig.screenHeight * 0.02,),
            Text("2. Utilisation des données",
              style: TextStyle(
                fontSize: getProportionateScreenWidth(18),
                fontWeight: FontWeight.bold,
                color: kPrimaryColor,
              ),
            ),
            Divider(height: 3, color: Colors.black,),
            SizedBox(height: SizeConfig.screenHeight * 0.01,),
            Text("Les données personnelles collectées seront utilisées pour :",
              style: TextStyle(
                fontSize: getProportionateScreenWidth(15),
                color: Colors.black,
              ),
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.005,),
            Puce(puce: "Authentifier l'identité de l'utilisateur ;",),
            SizedBox(height: SizeConfig.screenHeight * 0.005,),
            Puce(puce: "Personnaliser l'expérience utilisateur ;",),
            SizedBox(height: SizeConfig.screenHeight * 0.005,),
            Puce(puce: "Analyser les données d'utilisation pour améliorer l'expérience utilisateur et optimiser les performances de l'application ;",),
            SizedBox(height: SizeConfig.screenHeight * 0.005,),
            Puce(puce: "Proposer des offres promotionnelles ou des publicités ciblées en fonction des préférences de l'utilisateur.",),

            //***********************************Protection des données************************//
            SizedBox(height: SizeConfig.screenHeight * 0.02,),
            Text("3. Protection des données",
              style: TextStyle(
                fontSize: getProportionateScreenWidth(18),
                fontWeight: FontWeight.bold,
                color: kPrimaryColor,
              ),
            ),
            Divider(height: 3, color: Colors.black,),
            SizedBox(height: SizeConfig.screenHeight * 0.01,),
            Text("Nous prenons des mesures de sécurité raisonnables pour protéger les données personnelles de nos utilisateurs contre la perte, la destruction, la divulgation ou l'accès non autorisé. Cela comprend l'utilisation de technologies de sécurité et de cryptage avancées pour protéger les données lors de leur transmission.",
              style: TextStyle(
                fontSize: getProportionateScreenWidth(15),
                color: Colors.black,
              ),
            ),

//***********************************Partage de données************************//
            SizedBox(height: SizeConfig.screenHeight * 0.02,),
            Text("4. Partage de données",
              style: TextStyle(
                fontSize: getProportionateScreenWidth(18),
                fontWeight: FontWeight.bold,
                color: kPrimaryColor,
              ),
            ),
            Divider(height: 3, color: Colors.black,),
            SizedBox(height: SizeConfig.screenHeight * 0.01,),
            Text("Nous conservons les données personnelles de nos utilisateurs aussi longtemps que cela est nécessaire pour fournir les services de l'application et pour se conformer à nos obligations légales ou réglementaires. Les données personnelles seront supprimées ou anonymisées lorsque nous n'avons plus besoin de les conserver.",
              style: TextStyle(
                fontSize: getProportionateScreenWidth(15),
                color: Colors.black,
              ),
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.005,),
            Puce(puce: "Authentifier l'identité de l'utilisateur ;",),
            SizedBox(height: SizeConfig.screenHeight * 0.005,),
            Puce(puce: "Personnaliser l'expérience utilisateur ;",),
            SizedBox(height: SizeConfig.screenHeight * 0.005,),
            Puce(puce: "Si cela est nécessaire pour fournir les services de l'application (par exemple, l'envoi de notifications push) ;",),
            SizedBox(height: SizeConfig.screenHeight * 0.005,),
            Puce(puce: "Si cela est nécessaire pour répondre aux exigences légales ou réglementaires ;",),
            SizedBox(height: SizeConfig.screenHeight * 0.005,),
            Puce(puce: "Si cela est nécessaire pour protéger les droits, la propriété ou la sécurité de notre entreprise, de nos utilisateurs ou d'autres tiers.",),

            //***********************************Conservation des données************************//
            SizedBox(height: SizeConfig.screenHeight * 0.02,),
            Text("5. Conservation des données",
              style: TextStyle(
                fontSize: getProportionateScreenWidth(18),
                fontWeight: FontWeight.bold,
                color: kPrimaryColor,
              ),
            ),
            Divider(height: 3, color: Colors.black,),
            SizedBox(height: SizeConfig.screenHeight * 0.01,),
            Text("Nous conservons les données personnelles de nos utilisateurs aussi longtemps que cela est nécessaire pour fournir les services de l'application et pour se conformer à nos obligations légales ou réglementaires. Les données personnelles seront supprimées ou anonymisées lorsque nous n'avons plus besoin de les conserver.",
              style: TextStyle(
                fontSize: getProportionateScreenWidth(15),
                color: Colors.black,
              ),
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.005,),

            //***********************************Droits des utilisateurs************************//
            SizedBox(height: SizeConfig.screenHeight * 0.02,),
            Text("6. Droits des utilisateurs",
              style: TextStyle(
                fontSize: getProportionateScreenWidth(18),
                fontWeight: FontWeight.bold,
                color: kPrimaryColor,
              ),
            ),
            Divider(height: 3, color: Colors.black,),
            SizedBox(height: SizeConfig.screenHeight * 0.01,),
            Text("Les utilisateurs ont le droit d'accéder, de corriger, de limiter l'utilisation ou de supprimer leurs données personnelles. Les utilisateurs peuvent également retirer leur consentement à tout moment pour l'utilisation de leurs données personnelles.",
              style: TextStyle(
                fontSize: getProportionateScreenWidth(15),
                color: Colors.black,
              ),
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.005,),

            //***********************************Contact************************//
            SizedBox(height: SizeConfig.screenHeight * 0.02,),
            Text("7. Contact",
              style: TextStyle(
                fontSize: getProportionateScreenWidth(18),
                fontWeight: FontWeight.bold,
                color: kPrimaryColor,
              ),
            ),
            Divider(height: 3, color: Colors.black,),
            SizedBox(height: SizeConfig.screenHeight * 0.01,),
            Text("Si vous avez des questions ou des préoccupations concernant cette politique de confidentialité, veuillez nous contacter à l'adresse e-mail suivante : support-grave@gmail.com.",
              style: TextStyle(
                fontSize: getProportionateScreenWidth(15),
                color: Colors.black,
              ),
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.05,),

          ],
        ),
      ),
    );
  }
}

class Puce extends StatelessWidget {
  const Puce({
    super.key, required this.puce,
  });
  final String puce;


  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("- ",
          style: TextStyle(
            fontSize: getProportionateScreenWidth(15),
            color: Colors.black,
          ),
        ),
        Flexible(
          child: Text(puce,
            style: TextStyle(
              fontSize: getProportionateScreenWidth(15),
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
