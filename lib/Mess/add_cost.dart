import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:messmanager/Managerdashboard/ManagerDashboard.dart';
import 'package:messmanager/Mess/add_meal.dart';
import 'package:messmanager/Sign%20Up%20page/SignUpFormValidator.dart';

class AddCost{
  AddMeal addMeal = AddMeal();
  void addCostValidator(
    String? memberDocId,
    double costAmount,
    DateTime costDate,
    BuildContext context,
    List members,
  ){
    showDialog(
        context: context,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));
    if(memberDocId != null){
      addCost(memberDocId, costAmount, costDate, context);
      for (var element in members) {
        DocumentSnapshot documentSnapshot = element;
        String memberId = documentSnapshot.id;
         addMeal.updateTotalCost(context, memberId, 'Cost_Table', 'Monthly_cost_table',
        'Cost', costDate);
      }
      Navigator.pop(context);
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ManagerDashboard(),
        ));
    }
    else{
      Navigator.pop(context);
      SignUpAlertDialog.signUpErrorDialog(context, 'Pleage select a member');
    }
  }
  Future<void> addCost(
    String memberDocId,
    double costAmount,
    DateTime costDate,
    BuildContext context
  ) async{
    int messId = await addMeal.getMessId();
    DocumentReference messdocumentReference =
        FirebaseFirestore.instance.collection("All_Mess").doc('$messId');
    addMeal.addMealToMember(messdocumentReference,
        'Cost_Table', 'Monthly_cost_table', 'Cost', memberDocId,costAmount,costDate);
  }
}