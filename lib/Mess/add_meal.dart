import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:messmanager/UserInfo/current_user_information.dart';

class AddMeal {
  CurrentUserInformation currentUserInformation = CurrentUserInformation();
   Future<int> getMessId()async{
      DocumentSnapshot<Map<String,dynamic>> documentSnapshot =await currentUserInformation.getUserInformatio();
      Map<String , dynamic>? managerMessInfo = documentSnapshot.data()!;
      return managerMessInfo['mess'];
    }
    int messId = 4;
    Future<void>setMessId()async{
      messId = await getMessId();
    }
  Stream<QuerySnapshot> getMessMemberList(
  ) {
    setMessId();
    Stream<QuerySnapshot<Map<String, dynamic>>> querySnapshot =
        FirebaseFirestore.instance
            .collection('All_Mess')
            .doc('$messId')
            .collection('Mess_Member_table')
            .snapshots();
    return querySnapshot;
  }

  

}
