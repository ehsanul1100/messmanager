import 'package:cloud_firestore/cloud_firestore.dart';

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

  void messNameReturn(int messId) async {}

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
}
