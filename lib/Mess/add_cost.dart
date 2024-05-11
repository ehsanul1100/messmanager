import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:messmanager/Mess/add_meal.dart';
import 'package:messmanager/Sign%20Up%20page/SignUpFormValidator.dart';

class AddCost{
  AddMeal addMeal = AddMeal();
  void addCostValidator(
    String? memberDocId,
    double costAmount,
    DateTime costDate,
    BuildContext context
  ){
    if(memberDocId != null){
      addCost(memberDocId, costAmount, costDate, context);
    }
    else{
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