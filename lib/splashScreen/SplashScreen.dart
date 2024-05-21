import 'package:flutter/material.dart';
import 'package:messmanager/FirebaseAuthenticaion/FirebaseAutometicNavigate.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>  with TickerProviderStateMixin{
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1000))..repeat(reverse: true);
    late final Animation<double> _animation = CurvedAnimation(parent: _animationController, curve: Curves.linear);
    @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
  @override
  void initState() {
    Future.delayed(
      const Duration(milliseconds: 2000),
      () {
        Navigator.pushReplacement(
          context,
           MaterialPageRoute(
            builder: (context) {
              return const AutometicNavigate();
            },));
      },
    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white
        ),
        child: Center(
          child:
           FadeTransition(
            opacity: _animation,
            child: Image.asset('images/SplashScreenImage3.png'),
            ),
        ),
      ),
    );
  }
}