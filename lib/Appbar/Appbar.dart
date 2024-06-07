import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:messmanager/Appbar/DrawerDesign.dart';
import 'package:messmanager/UserInfo/current_user_information.dart';

class CreateAppBarForManagerDashboard{
  Map<String, dynamic>? user ;
  CurrentUserInformation currentUserInformation = CurrentUserInformation();
  AppBar createAppBarForDashboard() {
    return AppBar(
      centerTitle: true,
      backgroundColor: Color.fromARGB(255, 55, 118, 150),
      title: FutureBuilder<DocumentSnapshot<Map<String,dynamic>>>(
        future: currentUserInformation.getUserInformatio(),
         builder: (context, snapshot) {
           if (snapshot.hasData) {
             user = snapshot.data?.data();
             return Text(user?['userName']);
           } else {
             return Text('Mess Manager');
           }
         },),
    );
}
}


class ManagerDrawer extends StatefulWidget {
  const ManagerDrawer({super.key});

  @override
  State<ManagerDrawer> createState() => _ManagerDrawerState();
}

class _ManagerDrawerState extends State<ManagerDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width*.6,
      backgroundColor: Color.fromARGB(255, 55, 118, 150),
      child: DrawerManagerActions()
    );
  }
}

AppBar appBarForManagerActionPages(String appBarTitle){
  return AppBar(
    title: Text(appBarTitle),
    backgroundColor: Color.fromARGB(255, 55, 118, 150),
    centerTitle: true,
  );
}