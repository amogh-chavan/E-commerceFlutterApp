import 'package:zerowaste/services/Authentication.dart';

import 'package:zerowaste/views/Login.dart';
import 'package:zerowaste/views/SignUp.dart';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:zerowaste/views/VerifyEmail.dart';
import 'package:zerowaste/widgets/widgets.dart';
import 'package:page_transition/page_transition.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  AuthService authentication = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 50,
                ),
                Container(
                  //orignal 16 amogh changed to 8
                  height: 30,
                  margin: EdgeInsets.all(14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Welcome",
                          style: TextStyle(
                              color: Colors.black87,
                              fontFamily: 'Overpass',
                              fontSize: 25))
                    ],
                  ),
                ),
                Container(
                  child: smallName(
                      "Please login or sign up to continue using our app"),
                ),
                SizedBox(
                  height: 250.0,
                  width: 300.0,
                  child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      margin: EdgeInsets.symmetric(horizontal: 24),
                      child: Image.asset('assets/welcomepage2.jpg')),
                ),
                Container(child: smallName("Enter via social networks")),
                Container(
                    height: 100.0,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // FlatButton.icon(
                          //   height: 50,
                          //   color: Colors.lightBlue,
                          //   onPressed: () {
                          //     print('pressed');
                          //     Navigator.push(
                          //         context,
                          //         PageTransition(
                          //             child: VerifyEmail(),
                          //             type: PageTransitionType.leftToRight));
                          //   },
                          //   icon: Icon(EvaIcons.facebook, color: Colors.white),
                          //   label: Text("facebook"),
                          // ),
                          FlatButton.icon(
                            height: 50,
                            color: Color(0xff222222),
                            onPressed: () async {
                              await authentication.signInWithGoogle(context);

                              print('pressed');
                            },
                            icon: Icon(EvaIcons.google, color: Colors.white),
                            label: Text(
                              "google",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ])),
                SizedBox(height: 50),
                Container(
                  child: smallName("or login with email"),
                ),
                Container(
                  height: 100,
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  margin: EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    children: [
                      Expanded(
                        child: MaterialButton(
                          height: 50,
                          color: Color(0xff222222),
                          onPressed: () {
                            print('pressed');
                            Navigator.push(
                                context,
                                PageTransition(
                                    child: SignUp(),
                                    type: PageTransitionType.leftToRight));
                          },
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      smallName("Already have an account?"),
                      MaterialButton(
                        onPressed: () {
                          print('pressed');
                          Navigator.push(
                              context,
                              PageTransition(
                                  child: Login(),
                                  type: PageTransitionType.leftToRight));
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 80.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
