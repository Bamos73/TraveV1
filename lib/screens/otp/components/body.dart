import 'package:flutter/material.dart';
import 'package:shopapp/constants.dart';
import 'package:shopapp/screens/otp/components/otp_form.dart';
import 'package:shopapp/size_config.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  String _formatTime(double time) {
    return time.toStringAsFixed(0).padLeft(2, '0');
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal:getProportionateScreenWidth(20)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: SizeConfig.screenHeight*0.05,),
              Text(
                "OTP Verification",
                style: headingStyle,
              ),
              Text("We sent your code to +225 076 776****"),
              buildTimer(),
              SizedBox(height: SizeConfig.screenHeight*0.15,),
              OtpForm(),
              SizedBox(height: SizeConfig.screenHeight*0.1,),
              GestureDetector(
                onTap: () {
                    //Renvoyer le code OTP
                },
                child: Text("Resend OTP Code"
                    ,style: TextStyle(decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Row buildTimer() {
    return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("This code will expire in "),
            TweenAnimationBuilder(
              tween: Tween(begin: 30.0, end: 0.0),
              duration: Duration(seconds: 30),
              builder: (context, value, child) => Text(
                '00:${_formatTime(value)}', // fonction de formatage ici
                style: TextStyle(color: kPrimaryColor,),
              ),
              onEnd: () {

              },
            ),
          ],
        );
  }
}
