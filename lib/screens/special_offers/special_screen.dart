import 'package:flutter/material.dart';
import 'package:shopapp/screens/special_offers/components/body.dart';

class SpecialScreen extends StatefulWidget {
  const SpecialScreen({super.key});
  static String routeName='/special_offers';
  @override
  State<SpecialScreen> createState() => _SpecialScreenState();
}

class _SpecialScreenState extends State<SpecialScreen> {

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final NotificationId = args['id'] as String;

    return Scaffold(
      body: Body(NotificationId: NotificationId,),
    );
  }
}
