import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:messmanager/Sign%20Up%20page/SignUpFormValidator.dart';
import 'package:messmanager/UserInfo/current_user_information.dart';

class AddMessMember {
// current user information for geting mess id
  CurrentUserInformation currentUserInformation = CurrentUserInformation();
//date time indicator

  int dateTimeInYear = DateTime.now().year;
  int dateTimeInMonth = DateTime.now().month;
  int dateTimeInDate = DateTime.now().day;
  DateTime dateTime = DateTime.now();

//user validator

  Future<void> addMessMemberValidator(
    String emailAddress,
    BuildContext context,
  ) async {
//mess Id
    DocumentSnapshot<Map<String, dynamic>> currentUser =
        await currentUserInformation.getUserInformation();

//Show a circular loading
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );

// if we found the member then add him to mess
      Map<String, dynamic> member;
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await FirebaseFirestore.instance
              .collection('User')
              .doc(emailAddress)
              .get();
      if (documentSnapshot.exists) {
        member = documentSnapshot.data()!;
        addMessMember(currentUser['mess'], member['email'],member['userName']);
        if (context.mounted) {
          Navigator.pop(context);
        }
      } else {
        if (context.mounted) {
          Navigator.pop(context);
          SignUpAlertDialog.signUpErrorDialog(context, 'Member not found!!');
        }
      }
  }

  //add mess member
  Future<void> addMessMember(
    int messId,
    String emailAddress,
    String memberUserName,
  ) async {
    //get mess document using mess id

    DocumentReference messdocumentReference =
        FirebaseFirestore.instance.collection('All_Mess').doc('$messId');
    
   await messdocumentReference.collection('Mess_Member_table').doc('$emailAddress').set({
            'userName' : memberUserName,
            'manager' : false,
            'meal' : 0,
            'cost' : 0,
            'diposit' : 0,
          });
    
   await addMemberToEveryTableInDatabase(messdocumentReference, 'Meal_Table','Monthly_meal_table','Meal',emailAddress);
   await addMemberToEveryTableInDatabase(messdocumentReference, 'Diposit_Table','Monthly_diposit_table','Diposit',emailAddress);
   await addMemberToEveryTableInDatabase(messdocumentReference, 'Cost_Table','Monthly_cost_table','Cost',emailAddress);
  await updateUserMessInformation(messId, emailAddress);


  }

  Future<void> addMemberToEveryTableInDatabase(
    DocumentReference documentReference,
    String baseTableName,
    String secondBaseTableName,
    String tableName,
    String? userEmail
  )async{
    DocumentReference yeardocumentReference = documentReference.collection(baseTableName).doc('$dateTimeInYear');
    yeardocumentReference.collection(secondBaseTableName).doc('$dateTimeInMonth').collection(tableName).doc('$dateTimeInDate').set({
      "$userEmail" : 0,
    }, SetOptions(merge: true) );
    
  }
  Future<void> updateUserMessInformation(
    int messId,
    String emailAddress
  ) async {
    await FirebaseFirestore.instance.collection('User').doc(emailAddress).update({
      'mess' : messId
    });
  }
}
