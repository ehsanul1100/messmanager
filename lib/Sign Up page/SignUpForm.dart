import 'package:flutter/material.dart';
import 'package:messmanager/LoginPage/loginPage.dart';
import 'package:messmanager/LoginPage/textfildStyle.dart';
import 'package:messmanager/Managerdashboard/ManagerDashboardDesign.dart';
import 'package:messmanager/Sign%20Up%20page/SignUpFormValidator.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  SignUpAlertDialog? signUpAlertDialog ;
  //final formkey = GlobalKey<FormState>();
  final _userName = TextEditingController();
  final _email = TextEditingController();
  final _phone = TextEditingController();
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();
  bool passwordShower = true;
  bool confirmPasswordShower = true;
  Color color = Colors.grey;
  Color confirmPcolor = Colors.grey;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(gradient: StyleOfBackground.backgroundColor),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          Container(
            height: MediaQuery.of(context).size.height * .02,
          ),
          Image.asset('images/loginLogo.png',scale: 2,),
          SizedBox(
            height: MediaQuery.of(context).size.height * .65,
            width: MediaQuery.of(context).size.width * .7,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Text(
                    'Sign Up',
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          boxShadow,
                        ]),
                    child: TextFormField(
                      keyboardType: TextInputType.name,
                      controller: _userName,
                      decoration:
                          Style.textFieldStyle('User Name', const Icon(Icons.person)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          boxShadow,
                        ]),
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: _email,
                      decoration:
                          Style.textFieldStyle('Email', const Icon(Icons.email)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          boxShadow,
                        ]),
                    child: TextFormField(
                      keyboardType: TextInputType.phone,
                      controller: _phone,
                      decoration:
                          Style.textFieldStyle('Phone', const Icon(Icons.phone)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 20,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          boxShadow,
                        ]),
                    child: TextFormField(
                      controller: _password,
                      obscureText: passwordShower,
                      obscuringCharacter: '*',
                      decoration: InputDecoration(
                          suffixIconColor: color,
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  if (passwordShower == true) {
                                    passwordShower = false;
                                    color = Colors.blue;
                                  } else if (passwordShower == false) {
                                    passwordShower = true;
                                    color = Colors.grey;
                                  }
                                });
                              },
                              icon: const Icon(Icons.remove_red_eye_sharp)),
                          prefixIconColor: const Color.fromARGB(255, 18, 11, 100),
                          focusColor: const Color.fromARGB(255, 196, 196, 196),
                          filled: true,
                          fillColor: const Color.fromARGB(255, 255, 255, 255),
                          hintText: 'Password',
                          prefixIcon: const Icon(Icons.key_outlined),
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(20))),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 20,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          boxShadow,
                        ]),
                    child: TextFormField(
                      controller: _confirmPassword,
                      obscureText: confirmPasswordShower,
                      obscuringCharacter: '*',
                      decoration: InputDecoration(
                          suffixIconColor: confirmPcolor,
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  if (confirmPasswordShower == true) {
                                    passwordShower = false;
                                    confirmPasswordShower = false;
                                    color = Colors.blue;
                                    confirmPcolor = Colors.blue;
                                  } else if (confirmPasswordShower == false) {
                                    passwordShower = true;
                                    confirmPasswordShower = true;
                                    color = Colors.grey;
                                    confirmPcolor = Colors.grey;
                                  }
                                });
                              },
                              icon: const Icon(Icons.remove_red_eye_sharp)),
                          prefixIconColor: const Color.fromARGB(255, 18, 11, 100),
                          focusColor: const Color.fromARGB(255, 196, 196, 196),
                          filled: true,
                          fillColor: const Color.fromARGB(255, 255, 255, 255),
                          hintText: 'Confirm Password',
                          prefixIcon: const Icon(Icons.key),
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(20))),
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
                      ]),
                  child: TextButton(
                      onPressed: () {
                        SignUpAlertDialog.signUpFormValidator(
                            _userName.text,
                            _password.text,
                            _email.text,
                            _phone.text,
                            _confirmPassword.text,
                            context);
                      },
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(color: Colors.white),
                      )),
                ),
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'or connect with',
                    style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255)),
                  ),
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
                              ]),
                          child: TextButton(
                            onPressed: () {},
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
                              ]),
                          child: TextButton(
                            onPressed: () {},
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
              const Text(
                "Already have account.",
                style: TextStyle(color: Colors.white),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return const LoginPage();
                      },
                    ));
                  },
                  child: const Text(
                    'Login',
                    style:
                        TextStyle(color: Color.fromARGB(255, 0, 80, 146)),
                  ))
            ],
          )
        ]),
      ),
    );
  }
}
