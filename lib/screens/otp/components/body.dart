import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/constants.dart';
import 'package:shopapp/screens/otp/components/otp_form.dart';
import 'package:shopapp/screens/otp/otp_screen.dart';
import 'package:shopapp/size_config.dart';

class Body extends StatefulWidget {
  const Body({
    Key? key,
    required this.verificationId,
    required this.phoneNumber,
  }) : super(key: key);

  final String verificationId;
  final String phoneNumber;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> with TickerProviderStateMixin {
  late AnimationController _animationController;
  String _formatTime(int time) {
    return time.toString().padLeft(2, '0');
  }

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(minutes: 2), // Durée de 2 minutes
    );
    _animationController.reverse(from: 2 * 60);
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: SizeConfig.screenHeight * 0.05),
              Text(
                "OTP Verification",
                style: headingStyle,
              ),
              Text("Nous avons envoyé votre code au +225 ${widget.phoneNumber.substring(0, 4)}****${widget.phoneNumber.substring(widget.phoneNumber.length - 2)}"),
              buildTimer(),
              SizedBox(height: SizeConfig.screenHeight * 0.15),
              OtpForm(verificationId: widget.verificationId),
              SizedBox(height: SizeConfig.screenHeight * 0.1),
              GestureDetector(
                onTap: () {
                  sendOTP(widget.phoneNumber);
                  showCustomSnackBar("Le code OTP a été renvoyé avec succès.", ContentType.success);
                },
                child: Text(
                  "Renvoyer le code OTP",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              ),
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
        Text("Ce code expirera dans "),
        AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            int minutes = _animationController.value ~/ 60;
            int seconds = _animationController.value.toInt() % 60;
            return Text(
              '${_formatTime(minutes)}:${_formatTime(seconds)}',
              style: TextStyle(color: kPrimaryColor),
            );
          },
        ),
      ],
    );
  }

  void sendOTP(String phoneNumber) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+225$phoneNumber',
      timeout: Duration(minutes: 2,seconds: 30),
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int? resendToken) {
        Navigator.pushNamed(context, OTPScreen.routeName,
            arguments: {
              'verificationId': verificationId,
              'phoneNumber':phoneNumber,
            });
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  void showCustomSnackBar(String message, ContentType Content) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.fixed,
        backgroundColor: Color(0x00FFFFFF),
        elevation: 0,
        content: AwesomeSnackbarContent(
          title: 'Code OTP renvoyé',
          message: message,
          contentType: Content,
          messageFontSize: getProportionateScreenWidth(15),
        ),
      ),
    );
  }
}
