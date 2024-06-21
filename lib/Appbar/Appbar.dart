import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:messmanager/Appbar/DrawerDesign.dart';
import 'package:messmanager/Managerdashboard/ManagerDashboardDesign.dart';
import 'package:messmanager/UserInfo/current_user_information.dart';
import 'package:messmanager/style/text_style.dart';

class CreateAppBarForManagerDashboard{
  StyleOfText styleOfText = StyleOfText();
  Map<String, dynamic>? user ;
  CurrentUserInformation currentUserInformation = CurrentUserInformation();
  AppBar createAppBarForDashboard() {
    return AppBar(
      centerTitle: true,
      backgroundColor: StyleOfBackground.appBarColor,
      title: StreamBuilder<DocumentSnapshot<Map<String,dynamic>>>(
        stream: currentUserInformation.getUserInformationAsStream(),
         builder: (context, snapshot) {
           if (snapshot.hasData) {
             user = snapshot.data?.data();
             return Text(user?['userName'],style: styleOfText.textStyleForTitle(context, Colors.black),);
           } else {
             return const Text('');
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
      child: const DrawerManagerActions()
    );
  }
}

class MemberDrawer extends StatefulWidget {
  const MemberDrawer({super.key});

  @override
  State<MemberDrawer> createState() => _MemberDrawerState();
}

class _MemberDrawerState extends State<MemberDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        width: MediaQuery.of(context).size.width*.6,
        child: const CreateMemberDrawer()
    );
  }
}


AppBar appBarForManagerActionPages(String appBarTitle){
  return AppBar(
    title: Text(appBarTitle),
    backgroundColor: StyleOfBackground.appBarColor,
    centerTitle: true,
  );
}