import 'package:flutter/material.dart';
import 'package:shopapp/screens/order/components/body.dart';

import '../../service/internet_check.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});
  static String routeName="/order";

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  InternetCheck internetCheck = InternetCheck();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    internetCheck.startStreaming(context); // Passer le contexte
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:Body(),
    );
  }
}
