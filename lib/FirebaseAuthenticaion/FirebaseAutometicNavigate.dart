import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messmanager/LoginPage/loginPage.dart';
import 'package:messmanager/Managerdashboard/ManagerDashboard.dart';

class AutometicNavigate extends StatefulWidget {
  const AutometicNavigate({super.key});

  @override
  State<AutometicNavigate> createState() => _AutometicNavigateState();
}

class _AutometicNavigateState extends State<AutometicNavigate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
         builder: (context, snapshot) {
           if (snapshot.hasData) {
             return const ManagerDashboard();
           } else {
             return const LoginPage();
           }
         },),
    );
  }
}