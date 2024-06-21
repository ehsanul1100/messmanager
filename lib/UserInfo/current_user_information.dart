import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CurrentUserInformation {
  User? currentUser = FirebaseAuth.instance.currentUser;
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserInformation() async {
    return await FirebaseFirestore.instance
        .collection('User')
        .doc(currentUser!.email)
        .get();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>>
      getUserInformationAsStream() async* {
    yield* FirebaseFirestore.instance
        .collection('User')
        .doc(currentUser!.email)
        .snapshots();
  }

  Future<dynamic> currentUserParticularInformation(
    String informationName,
  ) async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    DocumentSnapshot<Map<String, dynamic>> currentUserDocument =
        await FirebaseFirestore.instance
            .collection('User')
            .doc(currentUser!.email)
            .get();

    Map<String, dynamic>? userInfo = currentUserDocument.data();
    return userInfo![informationName];
  }
}

// class CurrentUserInformationAsString {
//   Map<String,dynamic>? user;
//   CurrentUserInformation currentUserInformation = CurrentUserInformation();
//   String getUserInformatio(BuildContext context){
//     FutureBuilder(
//       future: currentUserInformation.getUserInformatio(),
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           user = snapshot.data?.data();
//         } else {
//           SignUpAlertDialog.signUpErrorDialog(context, '');
//         }
//       },);
//   }
// }
