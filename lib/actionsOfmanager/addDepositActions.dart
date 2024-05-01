import 'package:flutter/material.dart';
import 'package:messmanager/Appbar/Appbar.dart';
import 'package:messmanager/LoginPage/textfildStyle.dart';

class AddDepositActions extends StatefulWidget {
  const AddDepositActions({super.key});

  @override
  State<AddDepositActions> createState() => _AddDepositActionsState();
}

class _AddDepositActionsState extends State<AddDepositActions> {
  DateTime? dateTime = DateTime.now();
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
      appBar: appBarForManagerActionPages('Add Deposit'),
      body: Container(
        height: widgetHight,
        decoration: BoxDecoration(
          gradient: linearGradient,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: widgetHight * .08,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [boxShadow]
                ),
                height: widgetHight*.06,
                width: widgetWidth*.92,
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
                      child: Text('${dateTime}'))),
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
                          child: FutureBuilder(
                            future: res,
                            builder: (context, snapshot) {
                              return DropdownButtonMemberList
                              (memberList: memberList,
                               hint: Text('Select Member'));
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
                          boxShadow: [
                            boxShadow
                          ]
                        ),
                        child: TextField(
                          decoration: Style.textFieldStyle('Enter amount', Icon(Icons.money)),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 3, bottom: 3),
                        child: Container(
                          decoration: BoxDecoration(
                            boxShadow: [boxShadow],
                            borderRadius: BorderRadius.circular(30)
                          ),
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
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
      ),
    );
  }
}