import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messmanager/FirebaseAuthenticaion/autometic_navigat_to_manager_db_or_creat_join_mess_page.dart';
import 'package:messmanager/LoginPage/loginPage.dart';

class AutomaticNavigate extends StatefulWidget {
  const AutomaticNavigate({super.key});

  @override
  State<AutomaticNavigate> createState() => _AutomaticNavigateState();
}

class _AutomaticNavigateState extends State<AutomaticNavigate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
         builder: (context, snapshot) {
           if (snapshot.hasData) {
             User? user = snapshot.data;
             if(user == null){
               return const LoginPage();
             }else{
               return const AutomaticNavigateToManagerDbOrCreateJoinMessPage();
             }
           } else {
             return const Center(child: CircularProgressIndicator(),);
           }
         },),
    );
  }
}