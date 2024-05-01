import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messmanager/Sign%20Up%20page/SignUpFormValidator.dart';

class UserAuth {
  static bool isUserCreat = false;
  static Future<bool> creatUser(String email, String password,
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
      if (context.mounted) {
        Navigator.pop(context);
      }
      isUserCreat = true;
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        Navigator.pop(context);
      }
      SignUpAlertDialog.signUpErrorDialog(context, e.code);
      isUserCreat = false;
    }
    return isUserCreat ;
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
        'mess' : null,
        'manager' : false,
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
       if(context.mounted){Navigator.pop(context);}
      isLogin = true;
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
      isLogin = false;
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
