import 'package:flutter/material.dart';
import 'package:shopapp/screens/order_details/components/body.dart';

import '../../service/internet_check.dart';

class OrderDetailScreen extends StatefulWidget {
  const OrderDetailScreen({Key? key});
  static String routeName = "/order_details";

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {

  InternetCheck internetCheck = InternetCheck();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    internetCheck.startStreaming(context); // Passer le contexte
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final codeCommande = args['code_commande'] as String;
    final quantite = args['Quantite'];
    final montant = args['Montant'];
    final statut = args['statut'];
    final nomDeLivraison = args['nom_de_livraison'];
    final adresse = args['adresse'];
    final modeLivraison = args['mode_livraison'];
    final modePaiement = args['mode_paiement'];
    final fraisLivraison = args['fraie_livraison'];
    final codePromo = args['code_promo'];
    final numero = args['numero'];
    final date = args['date'];

    return Scaffold(
      body: Body(
        CodeCommande: codeCommande,
        Quantite: quantite,
        Montant: montant,
        statut: statut,
        adresse: adresse,
        numero: numero,
        nom_de_livraison: nomDeLivraison,
        mode_livraison: modeLivraison,
        mode_paiement: modePaiement,
        fraie_livraison: fraisLivraison,
        code_promo: codePromo,
        date: date,
      ),
    );
  }
}
