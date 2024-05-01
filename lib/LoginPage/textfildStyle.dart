import 'package:flutter/material.dart';

class Style {
  static InputDecoration textFieldStyle(String hintText, Icon prefixIcon) {
    return InputDecoration(
        prefixIconColor: Color.fromARGB(255, 18, 11, 100),
        focusColor: Color.fromARGB(255, 196, 196, 196),
        filled: true,
        fillColor: Color.fromARGB(255, 255, 255, 255),
        hintText: hintText,
        prefixIcon: prefixIcon,
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(20)));
  }
}

BoxShadow boxShadow3 = const BoxShadow(
    color: Color.fromARGB(82, 255, 255, 255),
    blurRadius: 6,
    blurStyle: BlurStyle.normal,
    offset: Offset(-4, -6),
    spreadRadius: 1.0);

BoxShadow boxShadow = const BoxShadow(
    color: Color.fromARGB(83, 8, 8, 60),
    blurRadius: 6,
    blurStyle: BlurStyle.normal,
    offset: Offset(4, 6),
    spreadRadius: 1.0);

BoxShadow boxShadow2 = BoxShadow(
    color: Color.fromARGB(150, 7, 7, 53),
    blurRadius: 6,
    blurStyle: BlurStyle.normal,
    offset: Offset(2, 2),
    spreadRadius: 1.0);

LinearGradient linearGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color.fromARGB(255, 222, 127, 159),
      Color.fromARGB(255, 88, 158, 216)
    ]);

@immutable
// ignore: must_be_immutable
class DropdownButtonMemberList extends StatefulWidget {
  List<String> memberList;
  Text hint; 
  DropdownButtonMemberList({super.key, required this.memberList,required this.hint});

  @override
  State<DropdownButtonMemberList> createState() =>
      _DropdownButtonMemberListState();
}

class _DropdownButtonMemberListState extends State<DropdownButtonMemberList> {
  String? memberSelect;
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
        value: memberSelect,
        hint: widget.hint,
        items: widget.memberList
            .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem(
                value: value,
                child: Text(value));
            })
            .toList(),
        onChanged: (value) {
          if(value != null){
            setState(() {
            memberSelect = value;
          });}
        },);
  }
}
