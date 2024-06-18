import 'package:flutter/material.dart';
import 'package:messmanager/Appbar/Appbar.dart';
import 'package:messmanager/Managerdashboard/ManagerDashBoardBody.dart';
import 'package:messmanager/Managerdashboard/ManagerDashboardDesign.dart';
import 'package:messmanager/Managerdashboard/ManagerDashboardProfileBody.dart';
import 'package:messmanager/Managerdashboard/ManagerDashboardSettingsBody.dart';
import 'package:messmanager/Managerdashboard/mess_members_details.dart';

class ManagerDashboard extends StatefulWidget {
  const ManagerDashboard({super.key});

  @override
  State<ManagerDashboard> createState() => _ManagerDashboardState();
}

class _ManagerDashboardState extends State<ManagerDashboard> {
  
  List managerDashboardBodys = [
    const ManagerDashboardBody(),
    const MessMembersDetails(),
    const ManagerDashboardProfileBody(),
  ];
  CreateAppBarForManagerDashboard createAppBarForManagerDashboard = CreateAppBarForManagerDashboard();
  int managerDashboardBodyIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const ManagerDrawer(),
      appBar: createAppBarForManagerDashboard.createAppBarForDashboard(),
      body: managerDashboardBodys[managerDashboardBodyIndex],
      bottomSheet: BottomNavigationBar(
        elevation: 1,
        selectedItemColor: Color.fromARGB(255, 255, 255, 255),
        unselectedItemColor: Colors.black,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        currentIndex: managerDashboardBodyIndex,
        backgroundColor: StyleOfBackground.bottomSheetColor,
        items: const [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home)),
          BottomNavigationBarItem(
            icon: Icon(Icons.filter_list_sharp),
            label: 'Member'),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile')
        ],
        onTap: (value) {
          setState(() {
            managerDashboardBodyIndex = value;
          });
        },
      )
    );
  }
}