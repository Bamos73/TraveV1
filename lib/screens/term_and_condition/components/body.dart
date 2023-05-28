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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Accord Utilisateur Trave",
              style: TextStyle(
                fontSize: getProportionateScreenWidth(20),
                fontWeight: FontWeight.bold,
                color: kPrimaryColor,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.02,),
            Image.asset("assets/images/Visual data-pana.png"),
            Text("En utilisant l'Application Trave, vous acceptez les termes et conditions énoncés dans cet Accord Utilisateur (ci-après l'Accord). Si vous n'êtes pas d'accord avec les termes et conditions de cet Accord, vous ne devez pas utiliser l'Application.",
              style: TextStyle(
                fontSize: getProportionateScreenWidth(15),
                color: Colors.black,
              ),
            ),

            //***********************************Utilisation de l'Application************************//
            SizedBox(height: SizeConfig.screenHeight * 0.02,),
            Text("1. Utilisation de l'Application",
              style: TextStyle(
                fontSize: getProportionateScreenWidth(18),
                fontWeight: FontWeight.bold,
                color: kPrimaryColor,
              ),
            ),
            const Divider(height: 3, color: Colors.black,),
            SizedBox(height: SizeConfig.screenHeight * 0.01,),
            Text("L'Application Trave est une plateforme de commerce électronique qui permet à ses utilisateurs d'acheter et de vendre des produits en ligne. Vous êtes autorisé à utiliser l'Application pour votre usage personnel uniquement, et vous vous engagez à ne pas l'utiliser a toute activité illégale.",
              style: TextStyle(
                fontSize: getProportionateScreenWidth(15),
                color: Colors.black,
              ),
            ),

            //***********************************Inscription et création de compte************************//
            SizedBox(height: SizeConfig.screenHeight * 0.02,),
            Text("2. Inscription et création de compte",
              style: TextStyle(
                fontSize: getProportionateScreenWidth(18),
                fontWeight: FontWeight.bold,
                color: kPrimaryColor,
              ),
            ),
            const Divider(height: 3, color: Colors.black,),
            SizedBox(height: SizeConfig.screenHeight * 0.01,),
            Text("Pour utiliser l'Application, vous devez créer un compte en fournissant des informations précises et à jour. Vous êtes responsable de la confidentialité de vos informations d'identification de compte, y compris votre nom d'utilisateur et votre mot de passe. Vous êtes responsable de toutes les activités qui se produisent sous votre compte.",
              style: TextStyle(
                fontSize: getProportionateScreenWidth(15),
                color: Colors.black,
              ),
            ),

            //***********************************Contenu de l'utilisateur************************//
            SizedBox(height: SizeConfig.screenHeight * 0.02,),
            Text("3. Contenu de l'utilisateur",
              style: TextStyle(
                fontSize: getProportionateScreenWidth(18),
                fontWeight: FontWeight.bold,
                color: kPrimaryColor,
              ),
            ),
            const Divider(height: 3, color: Colors.black,),
            SizedBox(height: SizeConfig.screenHeight * 0.01,),
            Text("Vous êtes responsable du contenu que vous publiez sur l'Application, y compris les descriptions de produit, les photos et les commentaires. Vous acceptez de ne pas publier de contenu offensant, illégal, trompeur ou inapproprié. L'Application se réserve le droit de supprimer tout contenu qui enfreint les termes de cet Accord.",
              style: TextStyle(
                fontSize: getProportionateScreenWidth(15),
                color: Colors.black,
              ),
            ),

            //***********************************Achat et vente de produits************************//
            SizedBox(height: SizeConfig.screenHeight * 0.02,),
            Text("4. Achat et vente de produits",
              style: TextStyle(
                fontSize: getProportionateScreenWidth(18),
                fontWeight: FontWeight.bold,
                color: kPrimaryColor,
              ),
            ),
            const Divider(height: 3, color: Colors.black,),
            SizedBox(height: SizeConfig.screenHeight * 0.01,),
            Text("L'Application permet aux utilisateurs d'acheter et de vendre des produits. Les transactions sont effectuées directement entre l'acheteur et le vendeur, et l'Application n'est pas responsable des transactions, des produits ou des services vendus par les utilisateurs. L'Application n'offre aucune garantie quant à la qualité des produits ou des services vendus.",
              style: TextStyle(
                fontSize: getProportionateScreenWidth(15),
                color: Colors.black,
              ),
            ),

            //***********************************Paiements************************//
            SizedBox(height: SizeConfig.screenHeight * 0.02,),
            Text("5. Paiements",
              style: TextStyle(
                fontSize: getProportionateScreenWidth(18),
                fontWeight: FontWeight.bold,
                color: kPrimaryColor,
              ),
            ),
            const Divider(height: 3, color: Colors.black,),
            SizedBox(height: SizeConfig.screenHeight * 0.01,),
            Text("Les utilisateurs acceptent que les paiements effectués via Trave seront traités par des prestataires de services tiers tels que des processeurs de paiement et des banques. Les utilisateurs reconnaissent et acceptent que Trave ne sera pas responsable de toute défaillance ou erreur de traitement de paiement commise par un tiers.\nLes utilisateurs acceptent que Trave conserve les informations de paiement des utilisateurs, telles que les informations de carte de crédit et de débit, dans un environnement sécurisé. Les utilisateurs peuvent mettre à jour ou supprimer leurs informations de paiement à tout moment via les paramètres de leur compte Trave.\nLes utilisateurs acceptent que toute dispute concernant le paiement d'un achat doit être résolue directement avec Trave. Les utilisateurs acceptent également que Trave puisse retenir tout paiement en cas de suspicion de fraude ou de violation des conditions d'utilisation de Trave.",
              style: TextStyle(
                fontSize: getProportionateScreenWidth(15),
                color: Colors.black,
              ),
            ),

            //***********************************Protection des données personnelles************************//
            SizedBox(height: SizeConfig.screenHeight * 0.02,),
            Text("6. Protection des données personnelles",
              style: TextStyle(
                fontSize: getProportionateScreenWidth(18),
                fontWeight: FontWeight.bold,
                color: kPrimaryColor,
              ),
            ),
            const Divider(height: 3, color: Colors.black,),
            SizedBox(height: SizeConfig.screenHeight * 0.01,),
            Text("L'Application collecte et utilise les données personnelles conformément à sa Politique de Confidentialité, que vous devez lire et accepter avant d'utiliser l'Application.",
              style: TextStyle(
                fontSize: getProportionateScreenWidth(15),
                color: Colors.black,
              ),
            ),

            //***********************************Loi applicable et juridiction************************//
            SizedBox(height: SizeConfig.screenHeight * 0.02,),
            Text("7. Loi applicable et juridiction",
              style: TextStyle(
                fontSize: getProportionateScreenWidth(18),
                fontWeight: FontWeight.bold,
                color: kPrimaryColor,
              ),
            ),
            const Divider(height: 3, color: Colors.black,),
            SizedBox(height: SizeConfig.screenHeight * 0.01,),
            Text("Cet Accord sera régi et interprété conformément aux lois de la République de Côte d'Ivoire. Tout litige découlant de cet Accord sera soumis à la juridiction exclusive des tribunaux de la République de Côte d'Ivoire.\nEn utilisant l'Application, vous acceptez les termes et conditions énoncés dans cet Accord. Si vous avez des questions ou des préoccupations concernant cet Accord, veuillez nous contacter à l'adresse e-mail suivante : support-trave@gmail.com.",
              style: TextStyle(
                fontSize: getProportionateScreenWidth(15),
                color: Colors.black,
              ),
            ),

            //***********************************Utilisation de l'Application************************//
            SizedBox(height: SizeConfig.screenHeight * 0.02,),
            Text("Date d'entrée en vigueur : 05/05/2023",
              style: TextStyle(
                fontSize: getProportionateScreenWidth(15),
                fontWeight: FontWeight.bold,
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
