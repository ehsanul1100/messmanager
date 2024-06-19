import 'package:flutter/material.dart';
import 'package:messmanager/FirebaseAuthenticaion/network_status.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>  with SingleTickerProviderStateMixin{
 late AnimationController _animationController;
late Animation<double> _animation;
    @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
  @override
  void initState() {
    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this);
      _animation = Tween(begin: 0.0,end: 1.0).animate(_animationController);
      _animationController.forward();
      _animationController.addStatusListener((status){
        if (status == AnimationStatus.completed) {
          _animationController.reverse().then((onValue){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const NetworkStatus(),));
          });
        }
      });
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
            child: Image.asset('images/loginLogo.png'),
            ),
        ),
      ),
    );
  }
}
