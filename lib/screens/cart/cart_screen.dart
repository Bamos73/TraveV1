
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
  bool isEmpty = false;

  @override
  void initState() {
    super.initState();
    checkCartIsEmpty();
  }

  Future<void> checkCartIsEmpty() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    final collectionRef = FirebaseFirestore.instance
        .collection('Card')
        .doc(userId)
        .collection(userId!);

    final snapshot = await collectionRef.get();

    setState(() {
      isEmpty = snapshot.docs.isEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F6F9),
      body: Body(),
      bottomNavigationBar: isEmpty ? null : CheckOurCard(),
    );
  }
}





