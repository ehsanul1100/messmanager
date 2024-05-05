import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messmanager/Managerdashboard/ManagerDashboard.dart';
import 'package:messmanager/Sign%20Up%20page/SignUpFormValidator.dart';

class CreatAndJoinMessValidator {
  // Enter mess name on allMess table and creat mess table include user
  CreatMess creatMess = CreatMess();
  void creatMessNameValidator(String? messName, BuildContext context) {
    if (messName == null || messName.isEmpty) {
      SignUpAlertDialog.signUpErrorDialog(
          context, 'Please enter a mess name!!');
    } else if (messName.length < 6) {
      SignUpAlertDialog.signUpErrorDialog(
          context, 'Please enter a mess more then 5 character!!');
    } else if (messName.length > 100) {
      SignUpAlertDialog.signUpErrorDialog(
          context, 'Please enter a mess name less then 100 character!!');
    } else {
      creatMess.getMessId(context, messName);
    }
  }

  void joinMessNameValidator(String? messName, BuildContext context) {
    if (messName != null && messName.isNotEmpty) {
    } else {
      SignUpAlertDialog.signUpErrorDialog(
          context, 'Please enter a mess name!!');
    }
  }
}

class CreatMess {
  Future<void> getMessId(
    BuildContext context,
    String messName,
  ) async {
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await FirebaseFirestore.instance
            .collection('Required variable')
            .doc('Mess id')
            .get();
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection('Required variable')
        .doc('Mess id');
    Map<String, dynamic> messId;
    if (documentSnapshot.exists) {
      messId = documentSnapshot.data()!;
      await creatMessWithMessId(messName, context, messId['mess_Id']);
      documentReference.update({'mess_Id': messId['mess_Id'] + 1});
    }
  }

  Future<void> creatMessWithMessId(
      String messName, BuildContext context, int messId) async {
    //Map<String,dynamic> messId =  ( FirebaseFirestore.instance.collection('Required variable').doc('Mess id').get() as Map<String,dynamic>);
    //creat mess
    try {
      await FirebaseFirestore.instance
          .collection('All_Mess')
          .doc('$messId')
          .set({'messName': messName, 'mess': 'Ok', 'manager': 'mess manager'});
      await updateUserMessStatus(context, messId);
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return const ManagerDashboard();
        },
      ));
    } on FirebaseFirestore catch (e) {
      SignUpAlertDialog.signUpErrorDialog(context, 'iefj');
    }
  }

  Future<void> updateUserMessStatus(BuildContext context, int messId) async {
    User? user = FirebaseAuth.instance.currentUser;
    try {
      await FirebaseFirestore.instance
          .collection('User')
          .doc(user?.email)
          .update({'mess': messId});
    } catch (e) {
      SignUpAlertDialog.signUpErrorDialog(context, 'message');
    }
  }
}
