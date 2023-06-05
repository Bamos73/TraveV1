import 'package:flutter/material.dart';
import 'package:shopapp/screens/order_details/components/body.dart';

class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen({super.key});
  static String routeName="/order_details";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}
