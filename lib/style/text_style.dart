
import 'package:flutter/material.dart';
import 'package:messmanager/LoginPage/textfildStyle.dart';

TextStyle textStyle =  TextStyle(
  backgroundColor: Colors.black,
  shadows: [boxShadow],
  color: Colors.black
);

class StyleOfText{
  TextStyle textStyleForTitle(BuildContext context,Color colors){
    return  TextStyle(
      //shadows: [boxShadow3],
      color: colors,
      fontSize: 24,
      //fontWeight: FontWeight.bold,
      fontFamily: 'OurFont',
      height: 0.8
    );
  }
  TextStyle textStyleForSubTitle(){
    return const TextStyle(
        //shadows: [boxShadow3],
        color: Colors.black,
        fontSize: 18,
        //fontWeight: FontWeight.bold,
        fontFamily: 'OurFont',
        height: 0.8
    );
  }
  TextStyle textStyleForDoubleNumber(){
    return const TextStyle(
      //shadows: [boxShadow3],
        color: Colors.tealAccent,
        fontSize: 24,
        fontWeight: FontWeight.bold,
        fontFamily: 'OurFont',
        height: 0.8
    );
  }
}