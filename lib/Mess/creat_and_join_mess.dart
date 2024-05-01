import 'package:flutter/material.dart';
import 'package:messmanager/LoginPage/textfildStyle.dart';

class CreatAndJoinMessPage extends StatefulWidget {
  const CreatAndJoinMessPage({super.key});

  @override
  State<CreatAndJoinMessPage> createState() => _CreatAndJoinMessPageState();
}

class _CreatAndJoinMessPageState extends State<CreatAndJoinMessPage> {
  final _messNameController = TextEditingController();
  final _joinMessNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return 
    Container(
        decoration: BoxDecoration(
          gradient: linearGradient,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                decoration:
                    Style.textFieldStyle('Mess name', const Icon(Icons.house)),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [boxShadow]),
                child: ElevatedButton(
                  onPressed: () {
                    
                  },
                  child: Text('Creat mess'),
                ),
              ),
              Container(
                height: 10,
              ),
              TextField(
                decoration:
                    Style.textFieldStyle('Mess name', const Icon(Icons.home)),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [boxShadow]),
                child:
                    ElevatedButton(onPressed: () {}, child: Text('Join mess')),
              )
            ],
          ),
        ),
      );
  }
}
