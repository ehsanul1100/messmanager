import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:messmanager/Managerdashboard/ManagerDashboard.dart';
import 'package:messmanager/Mess/mess_information.dart';
import 'package:messmanager/Resident/resident_dashboard.dart';

class AutometicNavigateToManagerDbMemberDb extends StatefulWidget {
  const AutometicNavigateToManagerDbMemberDb({super.key});

  @override
  State<AutometicNavigateToManagerDbMemberDb> createState() => _AutometicNavigateToManagerDbMemberDbState();
}

class _AutometicNavigateToManagerDbMemberDbState extends State<AutometicNavigateToManagerDbMemberDb> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: streamBuilderForThisPage(),
    );
  }

  StreamBuilder<DocumentSnapshot<Map<String,dynamic>>>streamBuilderForThisPage(){
    MessDtails messDtails = MessDtails();
    return StreamBuilder <DocumentSnapshot<Map<String,dynamic>>>(
    stream: messDtails.getMemberInfo('Mess_Member_table'),
    builder: (context, snapshot) {
      if(snapshot.hasData){
        Map<String,dynamic>? memberData = snapshot.data?.data();
        if(memberData?['manager'] == true){
          return const ManagerDashboard();
        }
        else{
          return const ResidentDashboard();
        }
      }
      else{
        return const Center(child: CircularProgressIndicator());
      }
    },);
  }
}