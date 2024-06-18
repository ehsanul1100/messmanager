import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messmanager/FirebaseAuthenticaion/autometic_navigate_to_manager_db_member_db.dart';
import 'package:messmanager/Managerdashboard/ManagerDashboardSettingsBody.dart';

class AutometicNavigatToManagerDbOrCreatJoinMessPage extends StatefulWidget {
  const AutometicNavigatToManagerDbOrCreatJoinMessPage({super.key});

  @override
  State<AutometicNavigatToManagerDbOrCreatJoinMessPage> createState() => _AutometicNavigatToManagerDbOrCreatJoinMessPageState();
}

class _AutometicNavigatToManagerDbOrCreatJoinMessPageState extends State<AutometicNavigatToManagerDbOrCreatJoinMessPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: streamBuilderForThisPage()
    );
  }

  StreamBuilder<DocumentSnapshot<Map<String,dynamic>>> streamBuilderForThisPage(){
    User? user = FirebaseAuth.instance.currentUser;
    return StreamBuilder<DocumentSnapshot<Map<String,dynamic>>>(
    stream: FirebaseFirestore.instance.collection('User').doc(user?.email).snapshots(),
    builder: (context, snapshot) {
      if(snapshot.hasData){
        Map<String,dynamic>? userData = snapshot.data?.data();
        if(userData?['mess'] == 0){
          return const ManagerDashboardSettingsBody();
        }
        else{
          return const AutometicNavigateToManagerDbMemberDb();
        }
      }
      else{
        return  const Center(child: CircularProgressIndicator());
      }
    },);
  }

}