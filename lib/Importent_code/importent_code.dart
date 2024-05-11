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

//get collection all document as a list

// import 'package:cloud_firestore/cloud_firestore.dart';

// Future<void> getData() async {
//   CollectionReference _collectionRef = FirebaseFirestore.instance.collection('your_collection_name');

//   // Get docs from collection reference
//   QuerySnapshot querySnapshot = await _collectionRef.get();

//   // Get data from docs and convert map to List
//   final allData = querySnapshot.docs.map((doc) => doc.data()).toList();

//   print(allData);
// }



// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Dropdown List with StreamBuilder and QuerySnapshot in Flutter'),
//         ),
//         body: Center(
//           child: DropdownWidget(),
//         ),
//       ),
//     );
//   }
// }

// class DropdownWidget extends StatefulWidget {
//   @override
//   _DropdownWidgetState createState() => _DropdownWidgetState();
// }

// class _DropdownWidgetState extends State<DropdownWidget> {
//   String dropdownValue;

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: FirebaseFirestore.instance.collection('your_collection').snapshots(),
//       builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//         if (!snapshot.hasData) return CircularProgressIndicator();
//         return DropdownButton<String>(
//           value: dropdownValue,
//           icon: Icon(Icons.arrow_downward),
//           iconSize: 24,
//           elevation: 16,
//           style: TextStyle(color: Colors.deepPurple),
//           underline: Container(
//             height: 2,
//             color: Colors.deepPurpleAccent,
//           ),
//           onChanged: (String newValue) {
//             setState(() {
//               dropdownValue = newValue;
//             });
//           },
//           items: snapshot.data!.docs.map((DocumentSnapshot document) {
//             return DropdownMenuItem<String>(
//               value: document['your_field'].toString(),
//               child: Text(document['your_field'].toString()),
//             );
//           }).toList(),
//         );
//       },
//     );
//   }
// }
