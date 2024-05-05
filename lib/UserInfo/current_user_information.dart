import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messmanager/Sign%20Up%20page/SignUpFormValidator.dart';

class CurrentUserInformation {
  User? currentUser = FirebaseAuth.instance.currentUser;
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserInformatio() async {
    return await FirebaseFirestore.instance
        .collection('User')
        .doc(currentUser!.email)
        .get();
  }
}

// class CurrentUserInformationAsString {
//   Map<String,dynamic>? user;
//   CurrentUserInformation currentUserInformation = CurrentUserInformation();
//   String getUserInformatio(BuildContext context){
//     FutureBuilder(
//       future: currentUserInformation.getUserInformatio(),
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           user = snapshot.data?.data();
//         } else {
//           SignUpAlertDialog.signUpErrorDialog(context, '');
//         }
//       },);
//   }
// }
