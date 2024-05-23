
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:messmanager/Managerdashboard/ManagerDashboard.dart';
import 'package:messmanager/Mess/add_meal.dart';
import 'package:messmanager/Sign%20Up%20page/SignUpFormValidator.dart';

class AddDiposit{
  AddMeal addMeal = AddMeal();
  void addDipositValidator(
    String? memberDocId,
    double dipositAmount,
    DateTime dipositDate,
    BuildContext context,
    List memberList
  ){
    showDialog(
        context: context,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));
    if(memberDocId != null){
      addDiposit(memberDocId, dipositAmount, dipositDate, context);
      for (var element in memberList) {
        DocumentSnapshot documentSnapshot = element;
        String memberId = documentSnapshot.id;
         addMeal.updateTotalMeal(context, memberId, 'Diposit_Table', 'Monthly_diposit_table',
        'Diposit', dipositDate,'Mess_Member_table','diposit');
      }
      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(builder: (context) => const ManagerDashboard(),));
    }
    else{
      Navigator.pop(context);
      SignUpAlertDialog.signUpErrorDialog(context, 'Pleage select a member');
    }
  }
  Future<void> addDiposit(
    String memberDocId,
    double costAmount,
    DateTime costDate,
    BuildContext context
  ) async{
    int messId = await addMeal.getMessId();
    DocumentReference messdocumentReference =
        FirebaseFirestore.instance.collection("All_Mess").doc('$messId');
    addMeal.addMealToMember(messdocumentReference,
        'Diposit_Table', 'Monthly_diposit_table', 'Diposit', memberDocId,costAmount,costDate);
  }
}