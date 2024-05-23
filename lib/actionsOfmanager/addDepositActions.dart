import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:messmanager/Appbar/Appbar.dart';
import 'package:messmanager/LoginPage/textfildStyle.dart';
import 'package:messmanager/Managerdashboard/ManagerDashboard.dart';
import 'package:messmanager/Mess/add_cost.dart';
import 'package:messmanager/Mess/add_diopsit.dart';
import 'package:messmanager/Mess/add_meal.dart';

class AddDepositActions extends StatefulWidget {
  const AddDepositActions({super.key});

  @override
  State<AddDepositActions> createState() => _AddDepositActionsState();
}

class _AddDepositActionsState extends State<AddDepositActions> {
  DateTime dipositDate = DateTime.now();
  AddMeal addMeal = AddMeal();
  AddDiposit addDiposit = AddDiposit();
  Map<String,dynamic>? memberList;
  List<String> member = [];
  List members = [];
  String? dropdownValueForMemver;
  AddCost addCost = AddCost();
  final _dipositAmount = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double widgetHight = MediaQuery.of(context).size.height;
    double widgetWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: appBarForManagerActionPages('Add Deposit'),
      body: Stack(children: [
        Container(
          height: widgetHight,
          decoration: BoxDecoration(
            gradient: linearGradient,
          ),
        ),
        SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(height: widgetHight * .01),
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [boxShadow]),
                  height: widgetHight * .06,
                  width: widgetWidth * .92,
                  child: ElevatedButton(
                      onPressed: () async {
                        DateTime? dateTimePicker = await showDatePicker(
                            context: context,
                            firstDate: DateTime(2000),
                            initialDate: DateTime.now(),
                            lastDate: DateTime(2030));

                        if (dateTimePicker != null) {
                          setState(() {
                            dipositDate = dateTimePicker;
                          });
                        }
                      },
                      child: Text(DateFormat('yMMMMd').format(dipositDate)))),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Container(
                  height: widgetHight * .6,
                  width: widgetWidth * .92,
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            boxShadow,
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: StreamBuilder(
                            stream: addMeal.getMessMemberList(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                members = snapshot.data!.docs;
                                return DropdownButton(
                                  icon: Icon(Icons.arrow_drop_down),
                                  value: dropdownValueForMemver,
                                  hint: Text('Select Member'),
                                  items: snapshot.data!.docs
                                      .map((DocumentSnapshot document) {
                                    return DropdownMenuItem<String>(
                                      value: document.id.toString(),
                                      child:
                                          Text(document['userName'].toString()),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      dropdownValueForMemver = value;
                                    });
                                  },
                                );
                              } else {
                                return DropdownButtonMemberList(
                                    memberList: member,
                                    hint: Text('Select Member'));
                              }
                            },
                          ),
                        ),
                      ),
                      Container(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [boxShadow]),
                        child: TextField(
                          controller: _dipositAmount,
                          decoration: Style.textFieldStyle(
                              'Enter amount', Icon(Icons.money)),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 3, bottom: 3),
                        child: Container(
                          decoration: BoxDecoration(
                              boxShadow: [boxShadow],
                              borderRadius: BorderRadius.circular(30)),
                          child: ElevatedButton(
                              onPressed: () {
                                addDipositToDatabase();
                              },
                              child: Text('ADD')),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
  
  void addDipositToDatabase() {
    double diopsitAmount;
    if (_dipositAmount.text.isEmpty) {
      diopsitAmount = 0;
    } else {
      try {
        diopsitAmount = double.parse(_dipositAmount.text);
      } catch (e) {
        diopsitAmount = 0;
      }
    }
    addDiposit.addDipositValidator(
        dropdownValueForMemver, diopsitAmount, dipositDate, context,members);
  }
}
