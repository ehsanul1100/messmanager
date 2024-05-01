import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:messmanager/Appbar/Appbar.dart';
import 'package:messmanager/LoginPage/textfildStyle.dart';

class ChangeManagerActions extends StatefulWidget {
  const ChangeManagerActions({super.key});

  @override
  State<ChangeManagerActions> createState() => _ChangeManagerActionsState();
}
class _ChangeManagerActionsState extends State<ChangeManagerActions> {
  Future? res;
  List<String> memberList = [
    'name1',
    'name2',
    'name3',
    'name4',
    'name5',
    'name6',
  ];
  String? dropdownValueForMenver;
  @override
  Widget build(BuildContext context) {
    double widgetHight = MediaQuery.of(context).size.height;
    double widgetWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: appBarForManagerActionPages('Change Manager'),
      body: Container(
        decoration: BoxDecoration(
          gradient: linearGradient,
        ),
        child: Column(
          children: [
            Container(
              height: widgetHight * .01,
            ),
            Container(
              width: widgetWidth * .92,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  boxShadow
                ]
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: FutureBuilder(
                  future: res,
                   builder: (context, snapshot) {
                     return DropdownButtonMemberList(
                      memberList: memberList,
                      hint: Text('Select Manager'));
                   },),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    boxShadow
                  ]
                ),
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  child: Text('Change')),
              ),
            )
          ],
        ),
      ),
    );
  }
}