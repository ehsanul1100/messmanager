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

