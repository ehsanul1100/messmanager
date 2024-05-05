// add new fields in an existing collection!!


// import 'package:cloud_firestore/cloud_firestore.dart';

// void addField() async {
//   CollectionReference users = FirebaseFirestore.instance.collection('users');
//   DocumentReference userDocument = users.doc('user_id'); // replace 'user_id' with the actual user ID

//   await userDocument.set({
//     'new_field': 'new_value', // replace with actual field name and value
//     // add more fields as needed
//   }, SetOptions(merge: true));
// }

// add nested collection in cloud firestor
// import 'package:cloud_firestore/cloud_firestore.dart';

// void createNestedCollection() async {
//   CollectionReference users = FirebaseFirestore.instance.collection('users');
//   DocumentReference userDocument = users.doc('user_id'); // replace 'user_id' with the actual user ID

//   CollectionReference orders = userDocument.collection('orders');
//   await orders.add({
//     'order_id': 'order1', // replace with actual order ID
//     'items': ['item1', 'item2'], // replace with actual items
//     // add more fields as needed
//   });
// }


// read data form firebase firestore using function


// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// Future<void> readData() async {
//   var firebaseUser = await FirebaseAuth.instance.currentUser();
//   DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance.collection("users").doc(firebaseUser.uid).get();

//   if (documentSnapshot.exists) {
//     print("Document data: ${documentSnapshot.data()}");
//   } else {
//     print("Document does not exist");
//   }
// }

