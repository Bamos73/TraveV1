import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  const Body({super.key, required this.NotificationId});

 final String NotificationId;
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
            children: [Text("Message screen ${widget.NotificationId}")],
        ));
  }
}
