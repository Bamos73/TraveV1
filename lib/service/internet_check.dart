import 'dart:async';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:lottie/lottie.dart';
import 'package:shopapp/components/default_button.dart';
import 'package:shopapp/constants.dart';
import 'package:shopapp/size_config.dart';


class InternetCheck{
  late ConnectivityResult result;
  late StreamSubscription subscription;
  var isConnected =false;

  checkInternet(BuildContext context) async{
    result = await Connectivity().checkConnectivity();

    if(result != ConnectivityResult.none){
      isConnected =true;
    }else{
      isConnected =false;
      showSuccessDialog(context);
    }

  }


  void showSuccessDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Container(
            height: getProportionateScreenHeight(340),
            width: getProportionateScreenWidth(50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: getProportionateScreenHeight(10)),
                Text(
                  "Connexion perdue",
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(15),
                    fontWeight: FontWeight.bold,
                    color: kErrorColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: getProportionateScreenHeight(5)),
                Lottie.asset("assets/lottiefiles/71565-no-internet.json"),
                SizedBox(height: getProportionateScreenHeight(5)),
                Text(
                  "Veuillez vérifier votre connexion internet !!",
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(14),
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: getProportionateScreenHeight(10)),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(30),
                  ),
                  child: DefaultButtonError(
                    text: "Actualiser",
                    press: () {
                      Navigator.pop(context);
                      checkInternet(context);
                    },
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(15)),
              ],
            ),
          ),
        );
      },
    );
  }



  startStreaming(BuildContext context) {
    subscription = Connectivity().onConnectivityChanged.listen((event) async {
      checkInternet(context); // Passer le contexte à checkInternet
    });
  }

}