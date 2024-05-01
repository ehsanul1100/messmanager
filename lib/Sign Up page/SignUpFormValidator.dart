import 'dart:async';

import 'package:flutter/material.dart';
import 'package:messmanager/FirebaseAuthenticaion/FirebaseAuthenticaion.dart';
import 'package:messmanager/Managerdashboard/ManagerDashboard.dart';

class SignUpAlertDialog {
  static UserAuth? userAuth;
  static late Future<bool> isUserCreat;
  static Future<void> signUpErrorDialog(
      BuildContext context, String message) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Got it'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static void signUpFormValidator(
    String userName,
    String password,
    String email,
    String phone,
    String confirmPassword,
    BuildContext context,
  ) {
    // bool emailValidatr = false;
    // for (var i = 0; email?[i] != null; i++) {
    //   if(email?[i] == '@') emailValidatr = true;
    // }
    if (userName.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty ||
        phone.isEmpty) {
      signUpErrorDialog(context, 'Please enter every information!!');
    } else {
      if (password != confirmPassword || password.length < 6) {
        signUpErrorDialog(context,
            'Please enter same Password and Confirem Password!!\n\nPlease enter more then 5 character as your password!!');
      } else if (phone.length != 11 || phone[0] != '0' || phone[1] != '1') {
        signUpErrorDialog(context, 'Please enter a valid number!!');
      }
      // else if(emailValidatr == false){
      //   signUpErrorDialog(context, 'Please enter a valid Email!!');
      // }
      else {
        isUserCreat =
            UserAuth.creatUser(email, password, context, userName, phone);

        if (UserAuth.isUserCreat) {
          if(context.mounted){Navigator.pop(context);}
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) {
              debugPrint('Sign in compleat');
              return const ManagerDashboard();
            },
          ));
        }
        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        //     print('Sign in compleat');
        //     return ManagerDashboard();
        //   },));
      }
    }
  }
}
