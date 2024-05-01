
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:messmanager/FirebaseAuthenticaion/FirebaseAutometicNavigate.dart';
import 'package:messmanager/LoginPage/loginPage.dart';
import 'package:messmanager/LoginPage/textfildStyle.dart';
import 'package:messmanager/actionsOfmanager/addCostActions.dart';
import 'package:messmanager/actionsOfmanager/addDepositActions.dart';
import 'package:messmanager/actionsOfmanager/addMealActions.dart';
import 'package:messmanager/actionsOfmanager/addMessMemberActions.dart';
import 'package:messmanager/actionsOfmanager/changeManagerActions.dart';

class DrawerManagerActions extends StatefulWidget {
  
  const DrawerManagerActions({super.key});

  @override
  State<DrawerManagerActions> createState() => _DrawerManagerActionsState();
}

class _DrawerManagerActionsState extends State<DrawerManagerActions> {
  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
    Container(
      alignment: Alignment.centerLeft,
      height: MediaQuery.of(context).size.height * .15,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [boxShadow],
      ),
      child: const ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue,
        ),
        title: Text('User name'),
        subtitle: Text('Email'),
      ),
    ),
    Padding(
      padding: const EdgeInsets.only(top: 20,bottom: 6,right: 6,left: 6),
      child: creatManagerActionIconGlassContainer(const Icon(Icons.food_bank,color: Colors.black,), const Text('Add meal'),AddMealActions()),
    ),
    Padding(
      padding: const EdgeInsets.only(bottom: 6,right: 6,left: 6),
      child: creatManagerActionIconGlassContainer(const Icon(Icons.attach_money,color: Colors.black,), const Text('Add cost'),AddCostActions()),
    ),
    Padding(
      padding: const EdgeInsets.only(bottom: 6,right: 6,left: 6),
      child: creatManagerActionIconGlassContainer(const Icon(Icons.money,color: Colors.black,), const Text('Add deposit'),AddDepositActions()),
    ),
    Padding(
      padding: const EdgeInsets.only(bottom: 6,right: 6,left: 6),
      child: creatManagerActionIconGlassContainer(const Icon(Icons.person_add,color: Colors.black,), const Text('Add Mess Member'),AddMessMemberActions()),
    ),
    Padding(
      padding: const EdgeInsets.only(bottom: 6,right: 6,left: 6),
      child: creatManagerActionIconGlassContainer(const Icon(Icons.change_circle_outlined,color: Colors.black,), const Text('Change Manager'),ChangeManagerActions()),
    ),
    Padding(
      padding: const EdgeInsets.only(bottom: 6,right: 6,left: 6),
      child: userSignoutFunction(const Icon(Icons.logout,color: Colors.black,), const Text('Logout'),AutometicNavigate()),
    )
    
        ],
      );
  }

  GlassContainer creatManagerActionIconGlassContainer(Icon actionicondata,Text actioniconName,dynamic navigateToPageName){
  return GlassContainer(
    opacity: .2,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          flex: 2,
          child: IconButton(
            onPressed: (){
              Navigator.push(context,
               MaterialPageRoute(builder: (context) {
                 return navigateToPageName;
               },));
            },
             icon: actionicondata)),
        Expanded(
          flex: 8,
          child: actioniconName),
      ],
    ),
  ) ;

}

GlassContainer userSignoutFunction(Icon actionicondata,Text actioniconName,dynamic navigateToPageName){
  return GlassContainer(
    opacity: .2,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          flex: 2,
          child: IconButton(
            onPressed: (){
              FirebaseAuth.instance.signOut();
              Navigator.push(context,
               MaterialPageRoute(builder: (context) {
                 return navigateToPageName;
               },));
            },
             icon: actionicondata)),
        Expanded(
          flex: 8,
          child: actioniconName),
      ],
    ),
  ) ;

}
}