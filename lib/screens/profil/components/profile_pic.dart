import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:provider/provider.dart';
import 'package:shopapp/size_config.dart';
import '../../../provider/sign_in_provider.dart';

class ProfilePic extends StatefulWidget {
  const ProfilePic({
    Key? key,
  }) : super(key: key);

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
              CircleAvatar(
                backgroundColor: Colors.grey,
                backgroundImage: sp.imageUrl != null ? NetworkImage(sp.imageUrl!) : null,
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
                        borderRadius: BorderRadius.circular(50),
                      ),
                      side: const BorderSide(color: Colors.white),
                      backgroundColor: const Color(0xFFF5F6F9),
                      padding: EdgeInsets.zero,
                    ),
                    onPressed: () {
                      _pickImage(context, sp);
                    },
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
              fontSize: getProportionateScreenHeight(15),
            ),
          ),
        ),
        SizedBox(
          height: getProportionateScreenHeight(20),
          child: Text(
            "${sp.email}",
            style: TextStyle(
              fontWeight: FontWeight.w100,
              fontSize: getProportionateScreenHeight(15),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _pickImage(BuildContext context, SignInProvider sp) async {
    final ImagePicker picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      // Image was successfully picked
      File selectedImage = File(pickedImage.path);

      // Get the application directory
      Directory appDir = await getApplicationDocumentsDirectory();

      // Create the complete path for the PhotoProfile/UID directory
      String photoProfileDirPath = path.join(appDir.path, "PhotoProfile", sp.uid);
      Directory photoProfileDir = Directory(photoProfileDirPath);

      // Check if the directory already exists
      if (!await photoProfileDir.exists()) {
        // The directory doesn't exist, create it
        await photoProfileDir.create(recursive: true);
      }

      // Move the selected image to the PhotoProfile/UID directory
      String imagePath = path.join(photoProfileDirPath, "profile_image.jpg");
      File newImage = await selectedImage.copy(imagePath);

      // Upload the image to Firebase Storage and get the download URL
      Reference storageRef = FirebaseStorage.instance
          .ref()
          .child("PhotoProfile")
          .child(sp.uid!)
          .child("profile_image.jpg");

      TaskSnapshot snapshot = await storageRef.putFile(newImage);

      if (snapshot.ref != null) {
        String downloadURL = await snapshot.ref.getDownloadURL();

        // Update the 'image_url' field in Firestore with the download URL
        final user = FirebaseAuth.instance.currentUser;
        final uid = user?.uid;
        FirebaseFirestore.instance.collection('users').doc(uid).update({
          'image_url': downloadURL,
        });

        // Refresh user data and save to SharedPreferences
        await sp.getUserDataFromFirestoreForAuth();
        await sp.saveDataToSharedPreferences();
        sp.setSignIn();
      } else {
        // Handle the case when the reference is null
        // Display an error message or take appropriate action
      }
    } else {
      // No image selected
    }
  }

}


