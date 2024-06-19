import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:messmanager/FirebaseAuthenticaion/FirebaseAutometicNavigate.dart';

class NetworkStatus extends StatefulWidget {
  const NetworkStatus({super.key});

  @override
  State<NetworkStatus> createState() => _NetworkStatusState();
}

class _NetworkStatusState extends State<NetworkStatus> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: creatSteramBuilderForThisPage(),
    );
  }
  StreamBuilder creatSteramBuilderForThisPage(){
    return StreamBuilder(
        stream: Connectivity().onConnectivityChanged,
        builder: (context, snapshot) {
          if(snapshot.hasData){
            final connection = snapshot.data;
            if(connection == ConnectivityResult.none) {
              return const Center(child: Text('NO INTERNET CONNECTION!!'),);
            }else{
              return const AutomaticNavigate();
            }
          }else{
            return const Center(child: CircularProgressIndicator(),);
          }
        },);
  }
}
