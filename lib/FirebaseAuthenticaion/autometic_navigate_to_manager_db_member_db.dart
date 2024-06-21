import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:messmanager/Managerdashboard/ManagerDashboard.dart';
import 'package:messmanager/Mess/mess_information.dart';
import 'package:messmanager/Resident/resident_dashboard.dart';
import 'package:messmanager/style/text_style.dart';

import '../Managerdashboard/ManagerDashboardDesign.dart';

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
    StyleOfText styleOfText = StyleOfText();
    MessDetails messDetails = MessDetails();
    return StreamBuilder <DocumentSnapshot<Map<String,dynamic>>>(
    stream: messDetails.getMemberInfo('Mess_Member_table'),
    builder: (context, snapshot) {
      if(snapshot.hasData){
        Map<String,dynamic>? memberData = snapshot.data?.data();
        if(memberData?['manager'] == true){
          //return to the manager dashboard
          return const ManagerDashboard();
        }
        else{
          // return to the member dashboard
          return const ResidentDashboard();
        }
      }
      else{
        return Container(
            decoration: BoxDecoration(
                gradient: StyleOfBackground.backgroundColor
            ),
            child:  Center(child: Text('Analysing data security...',style: styleOfText.textStyleForTitle(context,Colors.white),),));
      }
    },);
  }
}