import 'package:flutter/material.dart';
import 'package:messmanager/LoginPage/textfildStyle.dart';

Container creatContainer(String? titleOfTheMessInformationTableElemet,var amuntOfTheElement) {
  return Container(
    decoration: BoxDecoration(
      boxShadow: [boxShadow2],
      borderRadius: BorderRadius.circular(20),
      gradient: linearGradient
    ),
    child: Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 5,
            child: Text(titleOfTheMessInformationTableElemet!)),
          Expanded(
            flex: 5,
            child: Text('$amuntOfTheElement')),
        ],
      ),
    ),
  );
}

TextStyle textStyle = TextStyle(
  color: Colors.white,
);

class StyleOfBackground {
  static Color appBarColor =       Color.fromARGB(255, 255, 255, 255);
  static Color bottomSheetColor = Color.fromARGB(255, 102, 173, 203);
  static LinearGradient backgroundColor =  LinearGradient(
    stops: [
      .1,
     .7
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color.fromARGB(255, 255, 255, 255),
      Color.fromARGB(255, 102, 173, 203)
    ]);
}