import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messmanager/Managerdashboard/ManagerDashboard.dart';
import 'package:messmanager/Mess/creat_and_join_mess_helper.dart';
import 'package:messmanager/Sign%20Up%20page/SignUpFormValidator.dart';
import 'package:messmanager/UserInfo/current_user_information.dart';

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
    //Current user information for userName  and other information
    CurrentUserInformation currentUserInformation = CurrentUserInformation();
    //for User Email address
    User? currentUser = FirebaseAuth.instance.currentUser;
    //for unique id
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await FirebaseFirestore.instance
            .collection('Required variable')
            .doc('Mess id')
            .get();
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection('Required variable')
        .doc('Mess id');
    DocumentSnapshot<Map<String, dynamic>> currentUserInformationForMess = await currentUserInformation.getUserInformatio();
    Map<String, dynamic> messId;
    Map<String,dynamic> userInfo;
    if (documentSnapshot.exists && currentUserInformationForMess.exists) {
      messId = documentSnapshot.data()!;
      userInfo = currentUserInformationForMess.data()!;
      await creatMessWithMessId(messName, context, messId['mess_Id'],currentUser?.email,userInfo['userName']);
      documentReference.update({'mess_Id': messId['mess_Id'] + 1});
    }
  }
  //creat mess with unique id and

  Future<void> creatMessWithMessId(
      String messName, BuildContext context, int messId,
      String? userEmail,
      String userName) async {
    
    CreatMessTableOnDatabse creatMessTableOnDatabse = CreatMessTableOnDatabse();
    DocumentReference messdocumentReference =  FirebaseFirestore.instance.collection('All_Mess').doc('$messId');
    
    try {
      await FirebaseFirestore.instance
          .collection('All_Mess')
          .doc('$messId')
          .set({'messName': messName, 'mess': 'Ok', 'manager': 'mess manager'});
          messdocumentReference.collection('Mess_Member_table').doc('$userEmail').set({
            'userName' : userName,
            'manager' : true,
            'meal' : 0,
            'cost' : 0,
            'diposit' : 0,
          });
          creatMessTableOnDatabse.creatTable(messdocumentReference, 'Meal_Table','Monthly_meal_table','Meal',userEmail);
          creatMessTableOnDatabse.creatTable(messdocumentReference, 'Diposit_Table','Monthly_diposit_table','Diposit',userEmail);
          creatMessTableOnDatabse.creatTable(messdocumentReference, 'Cost_Table','Monthly_cost_table','Cost',userEmail);
          
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
