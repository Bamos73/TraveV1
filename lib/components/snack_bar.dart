import 'package:flutter/material.dart';

void openSnackbar(context, snackMessage, color) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: color,
      action: SnackBarAction(
        label: "OK",
        textColor: Colors.white,
        onPressed: () {},
      ),
      content: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          snackMessage,
          style: const TextStyle(fontSize: 14),
        ),
      ),
    ),
  );
}