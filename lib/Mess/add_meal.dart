import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:messmanager/Mess/mess_information.dart';
import 'package:messmanager/UserInfo/current_user_information.dart';

class AddMeal {
  CurrentUserInformation currentUserInformation = CurrentUserInformation();
  Future<int> getMessId() async {
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await currentUserInformation.getUserInformatio();
    Map<String, dynamic>? managerMessInfo = documentSnapshot.data()!;
    return managerMessInfo['mess'];
  }

  int messId = 0;

  Stream<QuerySnapshot> getMessMemberList() async* {
    messId = await getMessId();
    Stream<QuerySnapshot<Map<String, dynamic>>> querySnapshot =
        FirebaseFirestore.instance
            .collection('All_Mess')
            .doc('$messId')
            .collection('Mess_Member_table')
            .snapshots();
    yield* querySnapshot;
  }

  Future<void> addMesl(String docId, double? mealCount, BuildContext context,
      DateTime mealCountDate) async {
    messId = await getMessId();
    DocumentReference messdocumentReference =
        FirebaseFirestore.instance.collection("All_Mess").doc('$messId');
    addMealToMember(messdocumentReference, 'Meal_Table', 'Monthly_meal_table',
        'Meal', docId, mealCount!, mealCountDate);
  }

  Future<void> addMealToMember(
      DocumentReference documentReference,
      String baseTableName,
      String secondBaseTableName,
      String tableName,
      String? userEmail,
      double mealCount,
      DateTime mealCountDate) async {
    DocumentReference yeardocumentReference = documentReference
        .collection(baseTableName)
        .doc('${mealCountDate.year}');
    await yeardocumentReference
        .collection(secondBaseTableName)
        .doc('${mealCountDate.month}')
        .collection(tableName)
        .doc('${mealCountDate.day}')
        .set({
      "$userEmail": mealCount,
    }, SetOptions(merge: true));
  }

  double totalMeal = 0;
  Future<void> updateTotalMeal(
    BuildContext context,
    String userDocId,
    String baseTableName,
    String secondBaseTableName,
    String tableName,
    DateTime mealCountDate,
    String messMembertable,
    String memberUpdageField
  ) async {
     MessDetails messDtails = MessDetails();
    double personalMeal = 0;
    int messId = await getMessId();
    DocumentReference messdocumentReference =
        FirebaseFirestore.instance.collection("All_Mess").doc('$messId');
    DocumentReference yeardocumentReference = messdocumentReference
        .collection(baseTableName)
        .doc('${mealCountDate.year}');
    QuerySnapshot<Map<String, dynamic>> getmonthLyMealList =
        await yeardocumentReference
            .collection(secondBaseTableName)
            .doc('${mealCountDate.month}')
            .collection(tableName)
            .get();
    List<Map<String, dynamic>> monthlyMealList =
        getmonthLyMealList.docs.map((doc) => doc.data()).toList();
    for (var element in monthlyMealList) {
      if (element[userDocId] != null) {
        personalMeal += element[userDocId];
      } else {
        personalMeal += 0;
      }
    }
    totalMeal += personalMeal;
    messDtails.updateMessInfo(messId, tableName, totalMeal, messdocumentReference,
        baseTableName, secondBaseTableName, mealCountDate);
    messDtails.updateMessInfoForMember(messId, userDocId, memberUpdageField, personalMeal,
        messdocumentReference, messMembertable);
  }

  Future<void> updateTotalCost(
    BuildContext context,
    String userDocId,
    String baseTableName,
    String secondBaseTableName,
    String tableName,
    DateTime mealCountDate,
    // String messMembertable,
    // String memberUpdageField
  ) async {
     MessDetails messDtails = MessDetails();
    double personalMeal = 0;
    int messId = await getMessId();
    DocumentReference messdocumentReference =
        FirebaseFirestore.instance.collection("All_Mess").doc('$messId');
    DocumentReference yeardocumentReference = messdocumentReference
        .collection(baseTableName)
        .doc('${mealCountDate.year}');
    QuerySnapshot<Map<String, dynamic>> getmonthLyMealList =
        await yeardocumentReference
            .collection(secondBaseTableName)
            .doc('${mealCountDate.month}')
            .collection(tableName)
            .get();
    List<Map<String, dynamic>> monthlyMealList =
        getmonthLyMealList.docs.map((doc) => doc.data()).toList();
    for (var element in monthlyMealList) {
      if (element[userDocId] != null) {
        personalMeal += element[userDocId];
      } else {
        personalMeal += 0;
      }
    }
    totalMeal += personalMeal;
    messDtails.updateMessInfo(messId, tableName, totalMeal, messdocumentReference,
        baseTableName, secondBaseTableName, mealCountDate);
    // messDtails.updateMessInfoForMember(messId, userDocId, memberUpdageField, personalMeal,
    //     messdocumentReference, messMembertable);
  }
}
