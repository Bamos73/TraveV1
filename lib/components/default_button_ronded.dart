import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shopapp/constants.dart';
import 'package:shopapp/size_config.dart';

final RoundedLoadingButtonController _btnController =
    RoundedLoadingButtonController();

void _doSomething() async {
  // ignore: prefer_const_constructors
  Timer(Duration(seconds: 3), () {
    _btnController.success();
  });
}

class DefaultButtonRounded extends StatelessWidget {
  const DefaultButtonRounded({Key? key, this.text, this.press})
      : super(key: key);

  final String? text;
  final Function? press;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: getProportionateScreenHeight(56),
          child: RoundedLoadingButton(
            controller: _btnController,
            successColor: kPrimaryColor,
            color: kPrimaryColor,
            onPressed: _doSomething,
            borderRadius: 20,
            child: Text(
              text!,
              style: TextStyle(
                fontSize: getProportionateScreenWidth(18),
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
