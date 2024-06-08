import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:messmanager/Mess/add_meal.dart';

class MessDtails {
  dynamic messWantedInformationByCall(
    int messId,
    String requiredInforName,
    DocumentReference documentReference,
    String baseTableName,
    String secondBaseTableName,
    DateTime monthName,
  ) async {
    DocumentReference yeardocumentReference =
        documentReference.collection(baseTableName).doc('${monthName.year}');
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await yeardocumentReference
            .collection(secondBaseTableName)
            .doc('${monthName.month}')
            .get();
    Map<String, dynamic> docInfo;
    if (documentSnapshot.data() != null) {
      docInfo = documentSnapshot.data()!;
      return docInfo[requiredInforName];
    } else {
      return 0.0;
    }
  }

  Future<DocumentSnapshot<Map<String,dynamic>>> messNameReturn() async {
      AddMeal addMeal = AddMeal();
      int messId = await addMeal.getMessId();
      return await FirebaseFirestore.instance.collection('All_Mess').doc('$messId').get();
  }

  void updateMessInfo(
    int messId,
    String updateFieldName,
    double updateFieldValue,
    DocumentReference documentReference,
    String baseTableName,
    String secondBaseTableName,
    DateTime monthName,
  ) async {
    DocumentReference yeardocumentReference =
        documentReference.collection(baseTableName).doc('${monthName.year}');
    try {
      await yeardocumentReference
          .collection(secondBaseTableName)
          .doc('${monthName.month}')
          .update({updateFieldName: updateFieldValue});
    } catch (e) {
      await yeardocumentReference
          .collection(secondBaseTableName)
          .doc('${monthName.month}')
          .set({updateFieldName: updateFieldValue});
    }
  }

  Future<void> updateMessInfoForMember(
    int messId,
    String userDocId,
    String updateFieldName,
    double updateFieldValue,
    DocumentReference documentReference,
    String baseTableName,
  ) async {
    try {
      await documentReference
          .collection(baseTableName)
          .doc(userDocId)
          .update({updateFieldName: updateFieldValue});
    } catch (e) {
      await documentReference
          .collection(baseTableName)
          .doc(userDocId)
          .set({updateFieldName: updateFieldValue});
    }
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getMessInfo(
      String baseTableName,
      String secondBaseTableName,
      String requiredInforName,
      DateTime currentDat
      ) async* {
    AddMeal addMeal = AddMeal();
    int messId = await addMeal.getMessId();
        yield* FirebaseFirestore.instance
        .collection('All_Mess')
        .doc('$messId')
        .collection(baseTableName)
        .doc('${currentDat.year}')
        .collection(secondBaseTableName)
        .doc('${currentDat.month}')
        .snapshots();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getMemberInfo(
      String baseTableName,
      ) async* {
    AddMeal addMeal = AddMeal();
    int messId = await addMeal.getMessId();
    User? userDocId = FirebaseAuth.instance.currentUser;
        yield* FirebaseFirestore.instance
        .collection('All_Mess')
        .doc('$messId')
        .collection(baseTableName)
        .doc(userDocId!.email)
        .snapshots();
  }
  
}
