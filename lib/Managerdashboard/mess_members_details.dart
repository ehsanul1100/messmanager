import 'package:flutter/material.dart';
import 'package:messmanager/Managerdashboard/ManagerDashboardDesign.dart';

class MessMembersDetails extends StatefulWidget {
  const MessMembersDetails({super.key});

  @override
  State<MessMembersDetails> createState() => _MessMembersDetailsState();
}

class _MessMembersDetailsState extends State<MessMembersDetails> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: StyleOfBackground.backgroundColor
      ),
    );
  }
}