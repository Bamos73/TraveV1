import 'package:flutter/material.dart';
import 'package:shopapp/screens/order/components/body.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});
  static String routeName="/order";

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:Body(),
    );
  }
}
