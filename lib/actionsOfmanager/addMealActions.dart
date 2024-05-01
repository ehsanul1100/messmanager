
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:messmanager/Appbar/Appbar.dart';
import 'package:messmanager/LoginPage/textfildStyle.dart';

class AddMealActions extends StatefulWidget {
  const AddMealActions({super.key});

  @override
  State<AddMealActions> createState() => _AddMealActionsState();
}

class _AddMealActionsState extends State<AddMealActions> {
  DateTime? dateTime = DateTime.now();
  Future? res;
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
                child: ElevatedButton(onPressed: ()async{
                  DateTime? dateTimePicker = await showDatePicker(context: context,
                   firstDate: DateTime(2000),
                   initialDate: DateTime.now(),
                    lastDate: DateTime(2030));
                  
                  if (dateTimePicker != null) {
                    setState(() {
                      dateTime = dateTimePicker;
                    });
                  }
                },
                child: Text('${dateTime}'))
              ),
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
                      child: FutureBuilder(future: res,
                      builder: (context, snapshot) {
                        return ListView.builder(
                          itemCount: 20,
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
                          },);
                      },),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 3,bottom: 3),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                           child: Text('ADD')),
                      )
                      )
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