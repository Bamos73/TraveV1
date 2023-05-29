import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/size_config.dart';
import '../../../provider/sign_in_provider.dart';

class ProfilePic extends StatefulWidget {
  const ProfilePic({
    super.key,
  });

  @override
  State<ProfilePic> createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {
  @override
  Widget build(BuildContext context) {
    final sp = context.watch<SignInProvider>();
    return Column(
      children: [
        SizedBox(
          height: 115,
          width: 115,
          child: Stack(
            clipBehavior: Clip.none,
            fit: StackFit.expand,
            children: [
              const CircleAvatar(
                backgroundColor: Colors.grey,
                backgroundImage: AssetImage("assets/images/Profile Image.png"),
              ),
              Positioned(
                right: -12,
                bottom: 0,
                child: SizedBox(
                  height: 46,
                  width: 46,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      side: const BorderSide(color: Colors.white),
                      backgroundColor: const Color(0xFFF5F6F9),
                      padding: EdgeInsets.zero,
                    ),
                    onPressed: () {},
                    child: SvgPicture.asset("assets/icons/Camera Icon.svg"),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: getProportionateScreenHeight(20),
          child: Text(
            "${sp.name}",
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: getProportionateScreenHeight(15)),
          ),
        ),
        SizedBox(
          height: getProportionateScreenHeight(20),
          child: Text(
            "${sp.email}",
            style: TextStyle(
                fontWeight: FontWeight.w100,
                fontSize: getProportionateScreenHeight(15)),
          ),
        ),
      ],
    );
  }
}
