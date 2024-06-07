import 'package:flutter/material.dart';
import 'package:messmanager/FirebaseAuthenticaion/FirebaseAuthenticaion.dart';
import 'package:messmanager/LoginPage/textfildStyle.dart';
import 'package:messmanager/Sign%20Up%20page/SignUpPage.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  Color color = Colors.grey;
  bool passwordShower = true;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient: linearGradient
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * .1,
            ),
            Container(
            height: MediaQuery.of(context).size.height * .5,
            width: MediaQuery.of(context).size.width * .7,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
             children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: Text('Login',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30
                ),),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                    boxShadow,
                    ]
                  ),
                  child: TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: Style.textFieldStyle('Email', Icon(Icons.person)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 40,),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                     boxShadow,
                    ]
                  ),
                  child: TextField(
                    controller: _passwordController,
                    obscureText: passwordShower,
                    obscuringCharacter: '*',
                    decoration: InputDecoration(
                      suffixIconColor: color,
                      suffixIcon: IconButton(onPressed: (){
                          setState(() {
                            if(passwordShower == true) {
                              passwordShower = false;
                              color = Colors.blue;
                            } 
                            else if(passwordShower == false) {
                              passwordShower = true;
                              color = Colors.grey;
                            }
                          });
                      },
                       icon: Icon(Icons.remove_red_eye)),
                      prefixIconColor: Color.fromARGB(255, 18, 11, 100),
                      focusColor: Color.fromARGB(255, 196, 196, 196),
                      filled: true,
                      fillColor: Color.fromARGB(255, 255, 255, 255),
                      hintText: 'Password',
                      prefixIcon: Icon(Icons.key),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(20)
                      )
                    ),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color.fromARGB(255, 91, 79, 215),
                    boxShadow: [
                    boxShadow2,
                    ]
                  ),
                child: TextButton(onPressed: () {
                  UserLogin.userLogin(_emailController.text, _passwordController.text, context);
                }, child: Text('Login',
                style: TextStyle(color: Colors.white),)),
              ),
              TextButton(onPressed: (){},
              child: Text('Forgot your Password?',
               selectionColor: Color.fromARGB(222, 17, 52, 205),
               style: TextStyle(color: Colors.white),),)
             ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * .1,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: Container(
              width: MediaQuery.of(context).size.width * .7,
              child: Column(
                children: [
                  Text('or connect with',
                  style: TextStyle(color: const Color.fromARGB(255, 255, 255, 255)),),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                        width: MediaQuery.of(context).size.width * .3,
                        height: MediaQuery.of(context).size.height * .05,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color.fromARGB(255, 41, 50, 173),
                          boxShadow: [
                             boxShadow2,
                            ]
                      ),
                          
                          child: TextButton(onPressed: (){},
                           child: Image.asset('images/image1.png'),
                            ),
                        ),
                          Container(
                            width: MediaQuery.of(context).size.width * .3,
                        height: MediaQuery.of(context).size.height * .05,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color.fromARGB(255, 41, 50, 173),
                          boxShadow: [
                             boxShadow2,
                            ]
                      ),
                            child: TextButton(onPressed: (){},
                              child: Image.asset('images/image2.png'),
                            ),
                          )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Don't have account?",
              style: TextStyle(color: Colors.white),),
              TextButton(onPressed: (){
                Navigator.push(context, 
                MaterialPageRoute(builder: (context) {
                  return SignUpPage();
                },));
              },
               child: Text('Sign up',
               style: TextStyle(color: const Color.fromARGB(255, 0, 80, 146)),))
            ],
          )
          ]),
      ),
    );
  }
}