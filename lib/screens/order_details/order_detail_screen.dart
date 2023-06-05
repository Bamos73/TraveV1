import 'package:flutter/material.dart';
import 'package:shopapp/screens/order_details/components/body.dart';

class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen({super.key});
  static String routeName="/order_details";

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final codeCommande = args['code_commande'] as String;

    return Scaffold(
      body: Body(CodeCommande: codeCommande,),
    );
  }
}
