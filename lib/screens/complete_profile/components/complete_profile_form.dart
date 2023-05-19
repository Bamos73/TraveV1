// ignore_for_file: avoid_returning_null_for_void

import 'package:flutter/material.dart';
import 'package:shopapp/authentification/user_add_with_auth.dart';
import 'package:shopapp/components/custom_surfix_icon.dart';
import 'package:shopapp/components/default_button.dart';
import 'package:shopapp/components/form_error.dart';
import 'package:shopapp/constants.dart';
import 'package:shopapp/screens/otp/otp_screen.dart';
import 'package:shopapp/size_config.dart';

class CompleteProfileForm extends StatefulWidget {
  const CompleteProfileForm({Key? key}) : super(key: key);

  @override
  State<CompleteProfileForm> createState() => _CompleteProfileFormState();
}

class _CompleteProfileFormState extends State<CompleteProfileForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String?> errors = [];

  void addError({required String error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({required String error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  final _ctrfirstname = TextEditingController();
  final _ctrlastname = TextEditingController();
  final _ctrphonenumber = TextEditingController();
  final _ctradresse = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            buildFirstNameFormField(),
            SizedBox(
              height: getProportionateScreenWidth(30),
            ),
            buildLastNameFormField(),
            SizedBox(
              height: getProportionateScreenWidth(30),
            ),
            buildPhoneNumberFormField(),
            SizedBox(
              height: getProportionateScreenWidth(30),
            ),
            buildAddressFormField(),
            FormError(errors: errors),
            SizedBox(
              height: getProportionateScreenWidth(40),
            ),
            DefaultButton(
                text: "Continue",
                press: () {
                  if (_formKey.currentState!.validate()) {
                    final user = UserAuth(
                        firstname: _ctrfirstname.text.trim(),
                        lastname: _ctrlastname.text,
                        phonenumber: _ctrphonenumber.text.trim(),
                        address: _ctradresse.text,
                        email: '',
                        uid: '');
                    addUser(user);
                    _ctrfirstname.text = '';
                    _ctrlastname.text = '';
                    _ctrphonenumber.text = '';
                    _ctradresse.text = '';
                    Navigator.pushNamed(context, OTPScreen.routeName);
                  }
                }),
          ],
        ));
  }

  TextFormField buildFirstNameFormField() {
    return TextFormField(
      controller: _ctrfirstname,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNamelNullError);
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kNamelNullError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "First Name",
        hintText: "Enter your first name",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(
          svgIcon: "assets/icons/User.svg",
        ),
      ),
    );
  }

  TextFormField buildLastNameFormField() {
    return TextFormField(
      controller: _ctrlastname,
      // onSaved: (newValue) => LastName=newValue!,
      decoration: const InputDecoration(
        labelText: "Last Name",
        hintText: "Enter your last name",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(
          svgIcon: "assets/icons/User.svg",
        ),
      ),
    );
  }

  TextFormField buildPhoneNumberFormField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      controller: _ctrphonenumber,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPhoneNumberNullError);
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPhoneNumberNullError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Phone number",
        hintText: "Enter your phone number",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(
          svgIcon: "assets/icons/Phone.svg",
        ),
      ),
    );
  }

  TextFormField buildAddressFormField() {
    return TextFormField(
      keyboardType: TextInputType.streetAddress,
      controller: _ctradresse,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kAddressNullError);
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kAddressNullError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Address",
        hintText: "Enter your Address",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(
          svgIcon: "assets/icons/Location point.svg",
        ),
      ),
    );
  }
}
