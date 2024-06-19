import 'package:flutter/material.dart';
import 'package:messmanager/Appbar/Appbar.dart';
import 'package:messmanager/LoginPage/textfildStyle.dart';
import 'package:messmanager/Mess/creat_and_join_mess_page_validator.dart';

class ManagerDashboardSettingsBody extends StatefulWidget {
  const ManagerDashboardSettingsBody({super.key});

  @override
  State<ManagerDashboardSettingsBody> createState() => _ManagerDashboardSettingsBodyState();
}

class _ManagerDashboardSettingsBodyState extends State<ManagerDashboardSettingsBody> {
  final _messNameController = TextEditingController();
  final _joinMessNameController = TextEditingController();
  CreatAndJoinMessValidator creatAndJoinMessValidator = CreatAndJoinMessValidator();
  CreateAppBarForManagerDashboard appBarForManagerDashboard = CreateAppBarForManagerDashboard();
  @override
  Widget build(BuildContext context) {
    //double widgetheight = MediaQuery.of(context).size.height;
    double widgetWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: appBarForManagerDashboard.createAppBarForDashboard(),
      body: Container(
          decoration: BoxDecoration(
            gradient: linearGradient,
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        boxShadow
                      ],
                      borderRadius: BorderRadius.circular(20)
                    ),
                    width: widgetWidth*.8,
                    child: TextField(
                      controller: _messNameController,
                      decoration:
                          Style.textFieldStyle('Mess name', const Icon(Icons.house)),
                    ),
                  ),
                  // creat mess button
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [boxShadow]),
                    child: ElevatedButton(
                      onPressed: () {
                        creatAndJoinMessValidator.creatMessNameValidator(_messNameController.text, context);
                      },
                      child: Text('Creat mess'),
                    ),
                  ),
                  Container(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        boxShadow
                      ],
                      borderRadius: BorderRadius.circular(20)
                    ),
                    width: widgetWidth * .8,
                    child: TextField(
                      controller: _joinMessNameController,
                      decoration:
                          Style.textFieldStyle('Mess name', const Icon(Icons.home)),
                    ),
                  ),
                  // join mess button
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [boxShadow]),
                    child:
                        ElevatedButton(onPressed: () {
                          creatAndJoinMessValidator.joinMessNameValidator(_joinMessNameController.text, context);
                        }, child: Text('Join mess')),
                  )
                ],
              ),
            ),
          ),
        ),
    );
  }
}