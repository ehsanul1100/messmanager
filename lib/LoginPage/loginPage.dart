import 'package:flutter/material.dart';
import 'package:messmanager/LoginPage/loginForm.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: LoginForm(),
    );
  }
}