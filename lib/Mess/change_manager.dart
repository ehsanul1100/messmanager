import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:messmanager/Mess/add_meal.dart';
import 'package:messmanager/UserInfo/current_user_information.dart';

class ChangeManager {
  AddMeal addMeal = AddMeal();
  Future<void> changeManager(
    String memberDocId,
  ) async {
    CurrentUserInformation currentUserInformation = CurrentUserInformation();
    String managerId =
        await currentUserInformation.currentUserParticularInformation('email');
    int messId =
        await currentUserInformation.currentUserParticularInformation('mess');
    updateManagerState(messId, memberDocId, 'All_Mess', 'Mess_Member_table', true);
    updateManagerState(messId, managerId, 'All_Mess', 'Mess_Member_table', false);
  }
  Future<void> updateManagerState(
    int messId,
    String memberDocId,
    String mainTable,
    String secondTableName,
    bool whatStat
  )async{
    DocumentReference messdocumentReference =
        FirebaseFirestore.instance.collection(mainTable).doc('$messId');
    messdocumentReference.collection(secondTableName).doc(memberDocId).update({
      'manager' : whatStat
    });
  }
}
