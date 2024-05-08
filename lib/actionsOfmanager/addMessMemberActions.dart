import 'package:flutter/material.dart';
import 'package:messmanager/Appbar/Appbar.dart';
import 'package:messmanager/LoginPage/textfildStyle.dart';
import 'package:messmanager/Mess/add_mess_member.dart';

class AddMessMemberActions extends StatefulWidget {
  const AddMessMemberActions({super.key});

  @override
  State<AddMessMemberActions> createState() => _AddMessMemberActionsState();
}

class _AddMessMemberActionsState extends State<AddMessMemberActions> {
  AddMessMember addMessMember = AddMessMember();
  final _memberEmailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double widgetWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: appBarForManagerActionPages('Add member'),
      body: Stack(
        children: [
          Center(
            child: Container(
              decoration: BoxDecoration(
                gradient: linearGradient
              ),
            ),
          ),
          Center(
            child:  Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: widgetWidth * .92,
                  decoration: BoxDecoration(
                    boxShadow: [boxShadow],
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: TextField(
                    controller: _memberEmailController,
                    decoration: Style.textFieldStyle('Email', const Icon(Icons.email)),
                  ),
                ),
                ElevatedButton(onPressed: () {
                  addMessMember.addMessMemberValidator(_memberEmailController.text, context);
                }, child: Text("Add member"))
              ],
            ),
          )
        ],
      ),
    );
  }
}