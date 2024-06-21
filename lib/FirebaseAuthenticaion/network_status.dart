import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:messmanager/FirebaseAuthenticaion/FirebaseAutometicNavigate.dart';
import 'package:messmanager/Managerdashboard/ManagerDashboardDesign.dart';
import 'package:messmanager/style/text_style.dart';

class NetworkStatus extends StatefulWidget {
  const NetworkStatus({super.key});

  @override
  State<NetworkStatus> createState() => _NetworkStatusState();
}

class _NetworkStatusState extends State<NetworkStatus> {
  StyleOfText styleOfText = StyleOfText();
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
            return Container(
              decoration: BoxDecoration(
                gradient: StyleOfBackground.backgroundColor
              ),
                child:  Center(child: Text('Checking your connectivity...',style: styleOfText.textStyleForTitle(context,Colors.white),),));
          }
        },);
  }
}
