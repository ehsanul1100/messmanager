import 'package:flutter/material.dart';
import 'package:messmanager/Appbar/Appbar.dart';
import 'package:messmanager/Managerdashboard/ManagerDashBoardBody.dart';
import 'package:messmanager/Managerdashboard/ManagerDashboardDesign.dart';
import 'package:messmanager/Managerdashboard/ManagerDashboardProfileBody.dart';
import 'package:messmanager/Managerdashboard/mess_members_details.dart';

class ResidentDashboard extends StatefulWidget {
  const ResidentDashboard({super.key});

  @override
  State<ResidentDashboard> createState() => _ResidentDashboardState();
}

class _ResidentDashboardState extends State<ResidentDashboard> {
  List managerDashboardBody = [
    const ManagerDashboardBody(),
    const MessMembersDetails(),
    const ManagerDashboardProfileBody(),
  ];
  int managerDashboardBodyIndex = 0;
  CreateAppBarForManagerDashboard appBarForManagerDashboard = CreateAppBarForManagerDashboard();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarForManagerDashboard.createAppBarForDashboard(),
      drawer: const MemberDrawer(),
      body: managerDashboardBody[managerDashboardBodyIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color.fromARGB(255, 255, 255, 255),
        unselectedItemColor: Colors.black,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        currentIndex: managerDashboardBodyIndex,
        backgroundColor: StyleOfBackground.bottomSheetColor,
        items:const [
           BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home)),
           BottomNavigationBarItem(
            icon: Icon(Icons.filter_list),
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
      ),
    );
  }
}