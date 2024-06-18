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
            SizedBox(height: MediaQuery.of(context).size.height * .05,),
            Image.asset('images/loginLogo.png',scale: 2,),
            SizedBox(
            height: MediaQuery.of(context).size.height * .5,
            width: MediaQuery.of(context).size.width * .7,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
             children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 40),
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
                    decoration: Style.textFieldStyle('Email', const Icon(Icons.person)),
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
                       icon: const Icon(Icons.remove_red_eye)),
                      prefixIconColor: const Color.fromARGB(255, 18, 11, 100),
                      focusColor: const Color.fromARGB(255, 196, 196, 196),
                      filled: true,
                      fillColor: const Color.fromARGB(255, 255, 255, 255),
                      hintText: 'Password',
                      prefixIcon: const Icon(Icons.key),
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
                  color: const Color.fromARGB(255, 91, 79, 215),
                    boxShadow: [
                    boxShadow2,
                    ]
                  ),
                child: TextButton(onPressed: () {
                  UserLogin.userLogin(_emailController.text, _passwordController.text, context);
                }, child: const Text('Login',
                style: TextStyle(color: Colors.white),)),
              ),
              TextButton(onPressed: (){},
              child: const Text('Forgot your Password?',
               selectionColor: Color.fromARGB(222, 17, 52, 205),
               style: TextStyle(color: Colors.white),),)
             ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * .01,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: Container(
              width: MediaQuery.of(context).size.width * .7,
              child: Column(
                children: [
                  const Text('or connect with',
                  style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),),
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
                          color: const Color.fromARGB(255, 41, 50, 173),
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
                          color: const Color.fromARGB(255, 41, 50, 173),
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
              const Text("Don't have account?",
              style: TextStyle(color: Colors.white),),
              TextButton(onPressed: (){
                Navigator.push(context, 
                MaterialPageRoute(builder: (context) {
                  return const SignUpPage();
                },));
              },
               child: const Text('Sign up',
               style: TextStyle(color: Color.fromARGB(255, 0, 80, 146)),))
            ],
          )
          ]),
      ),
    );
  }
}