import 'package:flutter/material.dart';
import 'package:shopapp/screens/otp/components/body.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({Key? key, }) : super(key: key);
  static String routeName="/otp";

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  @override

  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final VerificationId = args['verificationId'] as String;
    final PhoneNumber = args['phoneNumber'] as String;

    return Scaffold(
      appBar: AppBar(
        title: Text("OTP Verification"),
        centerTitle: true,
      ),
      body: Body(verificationId: VerificationId,phoneNumber:PhoneNumber),
    );
  }
}
