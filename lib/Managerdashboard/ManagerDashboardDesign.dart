import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Container creatContainer(String? titleOfTheMessInformationTableElemet,double? amuntOfTheElement) {
  return Container(
    decoration: BoxDecoration(
      // color: Colors.white,
      border: Border(bottom: BorderSide()),
      borderRadius: BorderRadius.zero,
      // boxShadow: [
      //   boxShadow
      // ]
    ),
    child: Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 7,
            child: Text(titleOfTheMessInformationTableElemet!)),
          Expanded(
            flex: 3,
            child: Text('${amuntOfTheElement!}')),
        ],
      ),
    ),
  );
}

TextStyle textStyle = TextStyle(
  color: Colors.white,
);

