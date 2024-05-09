import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:intl/intl.dart';
import 'package:messmanager/Appbar/Appbar.dart';
import 'package:messmanager/LoginPage/textfildStyle.dart';
import 'package:messmanager/Mess/add_meal.dart';
import 'package:messmanager/UserInfo/current_user_information.dart';

class AddMealActions extends StatefulWidget {
  const AddMealActions({super.key});

  @override
  State<AddMealActions> createState() => _AddMealActionsState();
}

class _AddMealActionsState extends State<AddMealActions> {
  DateTime? dateTime = DateTime.now();
  AddMeal addMeal = AddMeal();
  @override
  Widget build(BuildContext context) {
    double widgetHight = MediaQuery.of(context).size.height;
    double widgetWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: appBarForManagerActionPages('Add Meal'),
      body: Container(
        decoration: BoxDecoration(
          gradient: linearGradient,
        ),
        child: Column(
          children: [
            Container(
              height: widgetHight * .01,
            ),
            GlassContainer(
              height: widgetHight * .08,
              width: widgetWidth * .92,
              child: Container(
                  child: ElevatedButton(
                      onPressed: () async {
                        DateTime? dateTimePicker = await showDatePicker(
                            context: context,
                            firstDate: DateTime(2000),
                            initialDate: DateTime.now(),
                            lastDate: DateTime(2030));

                        if (dateTimePicker != null) {
                          setState(() {
                            dateTime = dateTimePicker;
                          });
                        }
                      },
                      child: Text(DateFormat('yMMMMd').format(dateTime!)))),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: GlassContainer(
                height: widgetHight * .6,
                width: widgetWidth * .92,
                child: Column(
                  children: [
                    Expanded(
                      flex: 10,
                      child: StreamBuilder<
                          QuerySnapshot>(
                        stream: addMeal.getMessMemberList(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                             List members = snapshot.data!.docs;
                            return ListView.builder(
                              itemCount: members.length,
                              itemBuilder: (context, index) {
                        //get every member
                                DocumentSnapshot member = members[index];
                                String docId = member.id;
                        //fetching every member's data
                                Map<String,dynamic> membersData = member.data() as Map<String,dynamic>;
                                return  Card(
                                  elevation: 6,
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      backgroundColor: Colors.lightBlue,
                                    ),
                                    title: Text(membersData['userName']),
                                    
                                  ),
                                );
                              },
                            );
                          } else {
                            return ListView.builder(
                              itemCount: 6,
                              itemBuilder: (context, index) {
                                return const Card(
                                  elevation: 6,
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      backgroundColor: Colors.lightBlue,
                                    ),
                                    title: Text('Name'),
                                  ),
                                );
                              },
                            );
                          }
                        },
                      ),
                    ),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.only(top: 3, bottom: 3),
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('ADD')),
                    ))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
