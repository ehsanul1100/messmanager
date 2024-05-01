import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
      creatMess.creatMessWithEmail(messName, context);
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
  Future<void> creatMessWithEmail(
    String messName,
    BuildContext context,
  ) async {
    try {
      await FirebaseFirestore.instance
        .collection('All_Mess')
        .doc(messName)
        .set({
          'mess': 'Ok',
          'manager' : 'mess manager'});
    } catch (e){
      SignUpAlertDialog.signUpErrorDialog(context, 'message');
    }
  }
}
