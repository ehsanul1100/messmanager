import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messmanager/FirebaseAuthenticaion/autometic_navigat_to_manager_db_or_creat_join_mess_page.dart';
import 'package:messmanager/LoginPage/loginPage.dart';
import 'package:messmanager/style/text_style.dart';

import '../Managerdashboard/ManagerDashboardDesign.dart';

class AutomaticNavigate extends StatefulWidget {
  const AutomaticNavigate({super.key});

  @override
  State<AutomaticNavigate> createState() => _AutomaticNavigateState();
}

class _AutomaticNavigateState extends State<AutomaticNavigate> {
  StyleOfText styleOfText = StyleOfText();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
         builder: (context, snapshot) {
           if(snapshot.connectionState == ConnectionState.waiting) {
             debugPrint('automatic Navigate to LoginPage and');
             return Container(
                 decoration: BoxDecoration(
                     gradient: StyleOfBackground.backgroundColor
                 ),
                 child:  Center(child: Text('Checking your connectivity...',style: styleOfText.textStyleForTitle(context,Colors.white),),));
           } else if (snapshot.hasData) {
               return const AutomaticNavigateToManagerDbOrCreateJoinMessPage();

           } else {
             return const LoginPage();
           }
         },),
    );
  }
}