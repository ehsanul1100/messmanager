import 'package:flutter/material.dart';
import 'package:messmanager/Appbar/Appbar.dart';
import 'package:messmanager/Managerdashboard/ManagerDashBoardBody.dart';
import 'package:messmanager/Managerdashboard/ManagerDashboardProfileBody.dart';
import 'package:messmanager/Managerdashboard/ManagerDashboardSettingsBody.dart';

class ManagerDashboard extends StatefulWidget {
  const ManagerDashboard({super.key});

  @override
  State<ManagerDashboard> createState() => _ManagerDashboardState();
}

class _ManagerDashboardState extends State<ManagerDashboard> {
  
  List managerDashboardBodys = [
    const ManagerDashboardBody(),
    const ManagerDashboardSettingsBody(),
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
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        currentIndex: managerDashboardBodyIndex,
        backgroundColor: const Color.fromARGB(255, 55, 118, 150),
        items: [
          const BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home)),
          const BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings'),
          const BottomNavigationBarItem(
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