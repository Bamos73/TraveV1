import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/components/shimmer_box.dart';
import 'package:shopapp/screens/order/components/card_item_order.dart';
import 'package:shopapp/screens/order/components/order_empty.dart';
import 'package:intl/intl.dart';


class CardOrder extends StatefulWidget {
  const CardOrder({Key? key,
  }) : super(key: key);

  @override
  State<CardOrder> createState() => _CardOrderState();
}

class _CardOrderState extends State<CardOrder> {
  late String currentUserID;

  @override
  void initState() {
    super.initState();
    currentUserID = FirebaseAuth.instance.currentUser?.uid ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(currentUserID)
          .collection('commande')
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Expanded(
            child: ShimmerOrder(),
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Expanded(
            child: ShimmerOrder(),
          );
        } else if (snapshot.data!.docs.isEmpty) {
              // WidgetsBinding.instance.addPostFrameCallback((_) {
              //   Navigator.pushReplacement(context,
              //     MaterialPageRoute(builder: (context) => EmptyOrder()),
              //   );
              // });
            return Expanded(
                child: EmptyOrder(),
            );
        }
        final List<DocumentSnapshot> userOrderData = snapshot.data!.docs;
        return Expanded(
          child: ListView.builder(
            itemCount: userOrderData.length,
            itemBuilder: (BuildContext context, int index) {
              final DocumentSnapshot favDoc = userOrderData[index];
              final CodeCommande= favDoc['code_commande'];
              final Date= favDoc['date'];
              final formattedDate = DateFormat('dd/MM/yyyy').format(Date.toDate());
              final formattedTime = DateFormat('HH:mm').format(Date.toDate());
              final statut= favDoc['statut'];
              final Montant= favDoc['montant'];
              final Quantite= favDoc['nombre_article'];
              final adresse_de_livraison= favDoc['adresse_de_livraison'];
              final frais_de_livraison= favDoc['frais_de_livraison'];
              final mode_de_livraison= favDoc['mode_de_livraison'];
              final mode_de_paiement= favDoc['mode_de_paiement'];
              final nom_de_livraison= favDoc['nom_de_livraison'];
              final numero_de_livraison= favDoc['numero_de_livraison'];
              final code_reduction= favDoc['code_reduction'];

              return  card_item_order(
                CodeCommande: CodeCommande,
                Quantite: Quantite,
                Montant: Montant,
                statut: statut,
                formattedDate: formattedDate,
                formattedTime: formattedTime,
                nom_de_livraison:nom_de_livraison,
                adresse:adresse_de_livraison,
                mode_livraison:mode_de_livraison,
                mode_paiement:mode_de_paiement,
                fraie_livraison:frais_de_livraison,
                code_promo:code_reduction,
                numero: numero_de_livraison,

              );
            },
          ),
        );
      },
    );
  }
}

