import 'package:flutter/material.dart';
import 'package:messmanager/Managerdashboard/ManagerDashBoardBody.dart';
import 'package:messmanager/Managerdashboard/ManagerDashboardProfileBody.dart';
import 'package:messmanager/Managerdashboard/ManagerDashboardSettingsBody.dart';

class ResidentDashboard extends StatefulWidget {
  const ResidentDashboard({super.key});

  @override
  State<ResidentDashboard> createState() => _ResidentDashboardState();
}

class _ResidentDashboardState extends State<ResidentDashboard> {
  List managerDashboardBodys = [
    const ManagerDashboardBody(),
    const ManagerDashboardSettingsBody(),
    const ManagerDashboardProfileBody(),
  ];
  int managerDashboardBodyIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      ),
    );
  }
}