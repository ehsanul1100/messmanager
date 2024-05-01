import 'package:flutter/material.dart';
import 'package:messmanager/LoginPage/textfildStyle.dart';
import 'package:messmanager/UserInfo/current_user_information.dart';

class ManagerDashboardProfileBody extends StatefulWidget {
  const ManagerDashboardProfileBody({super.key});

  @override
  State<ManagerDashboardProfileBody> createState() =>
      _ManagerDashboardProfileBodyState();
}

class _ManagerDashboardProfileBodyState
    extends State<ManagerDashboardProfileBody> {
      Map<String, dynamic>? user ;
  CurrentUserInformation currentUserInformation = CurrentUserInformation();
  @override
  Widget build(BuildContext context) {
    //double widget_height = MediaQuery.of(context).size.height;
    double widgetWidth = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        gradient: linearGradient,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child:  Icon(
                Icons.person_sharp,
                size: 200,
                shadows: [
                  boxShadow,
                ],
                color: Colors.white60,
              ),
            ),
            Container(
              width: widgetWidth * .92,
              decoration: BoxDecoration(
                color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [boxShadow]),
              child: FutureBuilder(future: currentUserInformation.getUserInformatio(),
               builder: (context, snapshot) {
                 if (snapshot.hasData) {
                  user = snapshot.data?.data();
                   return Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Column(
                      children: [
                        Text(user?['userName']),
                        Text(user?['email'])
                      ],
                     ),
                   );
                 } else {
                   return const Center(child: CircularProgressIndicator());
                 }
               },)
              ),
          ],
        ),
      ),
    );
  }
}
