import 'package:flutter/material.dart';
import 'package:messmanager/LoginPage/textfildStyle.dart';
import 'package:messmanager/Managerdashboard/ManagerDashboardDesign.dart';
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
    double widgetHeight = MediaQuery.of(context).size.height;
    double widgetWidth = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        gradient: StyleOfBackground.backgroundColor,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [boxShadow],
                      borderRadius: BorderRadius.circular(80)
                    ),
                    child:
                      const CircleAvatar(
                        radius: 80,
                      )
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.white60,
                    child: IconButton(onPressed: (){
                    }, icon: Icon(Icons.camera_alt)),
                  )
                ],
              ),
            ),
            Container(
              width: widgetWidth * .92,
              height: widgetHeight*.3,
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
