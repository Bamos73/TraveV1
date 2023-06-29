
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/screens/cart/components/body.dart';
import 'package:shopapp/screens/cart/components/custom_nav_bar.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);
  static String routeName = "/cart";

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  Stream<QuerySnapshot> cartItemsStream = FirebaseFirestore.instance
      .collection('Card')
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .collection(FirebaseAuth.instance.currentUser?.uid ?? '')
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F6F9),
      body: Body(),
      bottomNavigationBar: StreamBuilder<QuerySnapshot>(
        stream: cartItemsStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final isEmpty = snapshot.data?.docs.isEmpty ?? true;
            return isEmpty ? SizedBox.shrink() : CheckOurCard();
          } else if (snapshot.hasError) {
            return SizedBox.shrink();
          } else {
            return SizedBox.shrink();
          }
        },
      ),
    );
  }
}







