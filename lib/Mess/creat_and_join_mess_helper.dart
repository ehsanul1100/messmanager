import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class CreatMessTableOnDatabse{
  int dateTimeInYear = DateTime.now().year;
  int dateTimeInMonth = DateTime.now().month;
  int dateTimeInDate = DateTime.now().day;
  DateTime dateTime = DateTime.now();

  Future<void> creatTable(
    DocumentReference documentReference,
    String baseTableName,
    String secondBaseTableName,
    String tableName,
    String? userEmail
  )async{
    DocumentReference yeardocumentReference = documentReference.collection(baseTableName).doc('$dateTimeInYear');
    yeardocumentReference.set({
      'Month' : DateFormat('MMM').format(dateTime),
    });
    yeardocumentReference.collection(secondBaseTableName).doc('$dateTimeInMonth').set({
      tableName : 0,
    });
    yeardocumentReference.collection(secondBaseTableName).doc('$dateTimeInMonth').collection(tableName).doc('$dateTimeInDate').set({
      "$userEmail" : 0,
    });
    
  }
}