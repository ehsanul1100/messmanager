import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:messmanager/LoginPage/textfildStyle.dart';
import 'package:messmanager/Managerdashboard/ManagerDashboardDesign.dart';
import 'package:messmanager/Mess/mess_information.dart';
import 'package:messmanager/Sign%20Up%20page/get_and_upload_image.dart';
import 'package:messmanager/UserInfo/current_user_information.dart';
import 'package:messmanager/style/text_style.dart';
import 'package:rxdart/rxdart.dart';

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
  StyleOfText styleOfText = StyleOfText();
  @override
  Widget build(BuildContext context) {
    double widgetHeight = MediaQuery.of(context).size.height;
    double widgetWidth = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        gradient: StyleOfBackground.backgroundColor,
      ),
      child: Center(
        child: Stack(
          children:[
            Column(
              children: [
                Expanded(
                  flex: 2,
                    child: Container()),
                Expanded(
                  flex: 12,
                    child: Container(
                      width: widgetWidth * .92,
                  height: widgetHeight * .4,
                  decoration: BoxDecoration(
                    color: StyleOfBackground.bottomSheetColor,
                    borderRadius: BorderRadius.circular(20),
                    //boxShadow: [boxShadow2]
                  ),
                ))
              ],
            ),
            createStreamBuilder(),
       ] ),
      ),
    );
  }
  StreamBuilder<CombinedData2> createStreamBuilder(){
    MessDetails messDetails = MessDetails();
    CurrentUserInformation currentUserInformation = CurrentUserInformation();
    Stream<DocumentSnapshot<Map<String,dynamic>>> stream1 = currentUserInformation.getUserInformationAsStream();
    Stream<DocumentSnapshot<Map<String,dynamic>>> stream2 = messDetails.getMemberInfo('Mess_Member_table');
    return StreamBuilder<CombinedData2>(
        stream: Rx.combineLatest2(stream1, stream2, (DocumentSnapshot<Map<String, dynamic>> snapshot1,
        DocumentSnapshot<Map<String, dynamic>> snapshot2){
          return CombinedData2(snapshot1.data(), snapshot2.data());
        }),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Map<String,dynamic>? userData = snapshot.data?.data1;
            Map<String,dynamic>? memberData = snapshot.data?.data2;
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(width: double.maxFinite,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Stack(
                    children: [
                      if(userData?['profilePic'] != null)
                      Container(
                          decoration: BoxDecoration(
                              boxShadow: [boxShadow],
                              borderRadius: BorderRadius.circular(80)
                          ),
                          child:
                           CircleAvatar(
                            radius: 80,
                            backgroundImage: NetworkImage(userData?['profilePic']),
                          )
                      ),
                      if(userData?['profilePic'] == null)
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
                        backgroundColor: Colors.white,
                        child: IconButton(onPressed: (){
                          Navigator.push(context,MaterialPageRoute(builder: (context) =>  GetAndUploadImage(previousPage: 'Profile',),));
                        }, icon: Icon(Icons.camera_alt)),
                      )
                    ],
                  ),
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(userData?['userName'],style: styleOfText.textStyleForTitle(context,Colors.white),),
                        ),
                        textOfSubtitle(userData?['email']),
                        if(memberData?['manager'])
                          textOfSubtitle('Manager')
                      ],
                    ),
                  ),
                )
              ],
            );
          } else{
           return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(width: double.maxFinite,),
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
                          CircleAvatar(
                            radius: 80,
                          )
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        child: IconButton(onPressed: (){
                          Navigator.push(context,MaterialPageRoute(builder: (context) =>  GetAndUploadImage(previousPage: 'Profile',),));
                        }, icon: Icon(Icons.camera_alt)),
                      )
                    ],
                  ),
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(),
                        ),
                        Container(),
                        Container()
                      ],
                    ),
                  ),
                )
              ],
            );
          }
        }
    );
  }
  Text textOfSubtitle(
      String valueName,
      ){
    return Text(valueName,style: styleOfText.textStyleForSubTitle(),);
  }
}
class CombinedData2 {
  final Map<String, dynamic>? data1;
  final Map<String, dynamic>? data2;

  CombinedData2(this.data1, this.data2);
}