import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:messmanager/splashScreen/SplashScreen.dart';
import 'firebase_options.dart';

void main(List<String> args) async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SplashScreen(),
  );
  }
}