import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messmanager/FirebaseAuthenticaion/autometic_navigat_to_manager_db_or_creat_join_mess_page.dart';
import 'package:messmanager/Managerdashboard/ManagerDashboard.dart';
import 'package:messmanager/Sign%20Up%20page/SignUpFormValidator.dart';
import 'package:messmanager/Sign%20Up%20page/get_and_upload_image.dart';

class UserAuth {
  static Future<void> creatUser(String email, String password,
      BuildContext context, String userName, String phoneNumber) async {
    showDialog(
      context: context,
      builder: (context) => Center(
        child: CircularProgressIndicator(),
      ),
    );
    try {
      UserCredential? userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      //save user data to firestore
      currentUserInformationSave(userCredential, userName, phoneNumber);
      Navigator.pop(context);
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) {
          debugPrint('Sign in compleat');
          return  GetAndUploadImage(previousPage: 'Signup');
        },
      ));
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      SignUpAlertDialog.signUpErrorDialog(context, e.code);
    }
  }

  static Future<void> currentUserInformationSave(UserCredential? userCredential,
      String? userName, String? phoneNumber) async {
    if (userCredential != null && userCredential.user != null) {
      await FirebaseFirestore.instance
          .collection('User')
          .doc(userCredential.user!.email)
          .set({
        'email': userCredential.user!.email,
        'userName': userName,
        'phone': phoneNumber,
        'mess': 0,
        'messName': 'messName',
        'manager': false,
      });
    }
  }
}

class UserLogin {
  static bool isLogin = false;
  static Future<void> userLogin(
      String email, String password, BuildContext context) async {
    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: CircularProgressIndicator(),
          );
        });
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      Navigator.pop(context);
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) {
          return const AutomaticNavigateToManagerDbOrCreateJoinMessPage();
        },
      ));
    } on FirebaseAuthException catch (e) {
      // SignUpAlertDialog.signUpErrorDialog(context, e.code);
      if (e.code == 'invalid-credential') {
        Navigator.pop(context);
        SignUpAlertDialog.signUpErrorDialog(
            context, 'User Name or Password wrong!!');
      } else if (e.code == 'channel-error') {
        Navigator.pop(context);
        SignUpAlertDialog.signUpErrorDialog(
            context, 'Please enter Email and Password!!');
      } else {
        Navigator.pop(context);
        SignUpAlertDialog.signUpErrorDialog(context, e.code);
      }
    }
  }
}

// class UserInformation {
//   static Future<CurrentUserInformation> currentUserInformation() async {
//     User? user = FirebaseAuth.instance.currentUser;
//     var provider;
//     var uid;
//     String? name;
//     String? emailAddress;
//     String? profilePhoto;

//     if (user != null) {
//       for (final providerProfile in user.providerData) {
//         // ID of the provider (google.com, apple.com, etc.)
//         provider = providerProfile.providerId;

//         // UID specific to the provider
//         uid = providerProfile.uid;

//         // Name, email address, and profile photo URL
//         name = providerProfile.displayName;
//         emailAddress = providerProfile.email;
//         profilePhoto = providerProfile.photoURL;
//       }
//     }
//     return CurrentUserInformation.fromFirebaseAuth(
//         name, emailAddress, profilePhoto);
//   }
// }
