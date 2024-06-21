import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:messmanager/Appbar/Appbar.dart';
import 'package:messmanager/LoginPage/textfildStyle.dart';
import 'package:messmanager/Managerdashboard/ManagerDashboard.dart';
import 'package:messmanager/Managerdashboard/ManagerDashboardDesign.dart';
import 'package:messmanager/Mess/add_meal.dart';
import 'package:messmanager/Mess/change_manager.dart';
import 'package:messmanager/Sign%20Up%20page/SignUpFormValidator.dart';

class ChangeManagerActions extends StatefulWidget {
  const ChangeManagerActions({super.key});

  @override
  State<ChangeManagerActions> createState() => _ChangeManagerActionsState();
}
class _ChangeManagerActionsState extends State<ChangeManagerActions> {
    AddMeal addMeal = AddMeal();
    ChangeManager changeManager = ChangeManager();
    List<String> memberList = [];
  String? dropdownValueForMember;
  @override
  Widget build(BuildContext context) {
    double widgetHight = MediaQuery.of(context).size.height;
    double widgetWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: appBarForManagerActionPages('Change Manager'),
      body: Stack(
        children: [Container(
          decoration: BoxDecoration(
            gradient: StyleOfBackground.backgroundColor,
          ),),
          Column(
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
                  child: StreamBuilder(
                              stream: addMeal.getMessMemberList(),
                              builder: (context, snapshot) {
                                if(snapshot.hasData){
                                  return DropdownButton(
                                    icon: Icon(Icons.arrow_drop_down),
                                    value: dropdownValueForMember,
                                    hint: Text('Select Member'),
                                    items: snapshot.data!.docs.map((DocumentSnapshot document){
                                      return DropdownMenuItem<String>(
                                        value: document.id.toString(),
                                        child: Text(document['userName'].toString()),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        dropdownValueForMember = value;
                                      });
                                    },);
                                }
                                else{
                                  return DropdownButtonMemberList
                                (memberList: memberList,
                                 hint: Text('Select Member'));
                                }
                              },
                            ),
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
                    onPressed: () {
                      changeManagerInDatabase();
                    },
                    child: Text('Change')),
                ),
              )
            ],
          ),
        
      ]),
    );
  }

  void changeManagerInDatabase(){
    if(dropdownValueForMember == null){
      SignUpAlertDialog.signUpErrorDialog(context, 'Please select a manager');
    }
    else{
      changeManager.changeManager(dropdownValueForMember!);
      Navigator.push(context, MaterialPageRoute(builder: (context) => const ManagerDashboard(),));
    }
  }
}