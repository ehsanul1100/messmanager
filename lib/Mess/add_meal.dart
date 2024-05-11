import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:messmanager/Managerdashboard/ManagerDashboard.dart';
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

  Future<void> addMesl(
    String docId,
    double? mealCount,
    BuildContext context,
    DateTime mealCountDate
  ) async {
    messId = await getMessId();
    DocumentReference messdocumentReference =
        FirebaseFirestore.instance.collection("All_Mess").doc('$messId');
      addMealToMember(messdocumentReference,
        'Meal_Table', 'Monthly_meal_table', 'Meal', docId,mealCount!,mealCountDate);
    }
    

  Future<void> addMealToMember(
      DocumentReference documentReference,
      String baseTableName,
      String secondBaseTableName,
      String tableName,
      String? userEmail,
      double mealCount,
      DateTime mealCountDate) async {
    DocumentReference yeardocumentReference = 
        documentReference.collection(baseTableName).doc('${mealCountDate.year}');
       await yeardocumentReference
        .collection(secondBaseTableName)
        .doc('${mealCountDate.month}')
        .collection(tableName)
        .doc('${mealCountDate.day}')
        .set({
      "$userEmail": mealCount,
    }, SetOptions(merge: true));
  }
}
