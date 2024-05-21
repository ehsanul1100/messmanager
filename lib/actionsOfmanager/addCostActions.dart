import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:messmanager/Appbar/Appbar.dart';
import 'package:messmanager/LoginPage/textfildStyle.dart';
import 'package:messmanager/Mess/add_cost.dart';
import 'package:messmanager/Mess/add_meal.dart';

class AddCostActions extends StatefulWidget {
  const AddCostActions({super.key});

  @override
  State<AddCostActions> createState() => _AddCostActionsState();
}

class _AddCostActionsState extends State<AddCostActions> {
  DateTime costDate = DateTime.now();
  AddMeal addMeal = AddMeal();
  List<String> memberList = [];
  String? dropdownValueForMemver;
  AddCost addCost = AddCost();
  final _costAmount = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double widgetHight = MediaQuery.of(context).size.height;
    double widgetWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: appBarForManagerActionPages('Add Cost'),
      body: Stack(children: [
        Container(
          height: widgetHight,
          decoration: BoxDecoration(
            gradient: linearGradient,
          ),
        ),
        SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: widgetHight * .01,
              ),
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
                            costDate = dateTimePicker;
                          });
                        }
                      },
                      child:
                          Text('${DateFormat('yMMMMd').format(costDate!)}'))),
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
                          child: StreamBuilder<QuerySnapshot>(
                            stream: addMeal.getMessMemberList(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return DropdownButton(
                                  icon: Icon(Icons.arrow_drop_down),
                                  hint: Text('Select member'),
                                  value: dropdownValueForMemver,
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
                                      debugPrint(value);
                                    });
                                  },
                                );
                              } else {
                                return DropdownButtonMemberList(
                                    memberList: memberList,
                                    hint: Text('Select member'));
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
                          controller: _costAmount,
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
                                addCostToDatabase();
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

  void addCostToDatabase() {
    
    double costAmount;
    if (_costAmount.text.isEmpty) {
      costAmount = 0;
    } else {
      try {
        costAmount = double.parse(_costAmount.text);
      } catch (e) {
        costAmount = 0;
      }
    }
    addCost.addCostValidator(
        dropdownValueForMemver, costAmount, costDate, context);
    
  }
}
