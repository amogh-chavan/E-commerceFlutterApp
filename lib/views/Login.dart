import 'package:flutter/material.dart';
import 'package:zerowaste/models/user.dart' as U;
import 'package:zerowaste/models/userSetUp.dart';
import 'package:zerowaste/views/HomeComponents/sidebar/sidebar.dart';
import 'package:zerowaste/views/HomeComponents/sidebar/sidebar_layout.dart';
import 'package:zerowaste/widgets/widgets.dart';
import 'package:page_transition/page_transition.dart';
import 'package:zerowaste/views/SignUp.dart';
import 'package:zerowaste/views/ForgotPassword.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:zerowaste/services/Authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  AuthService authentication = AuthService();

  // TextStyle style = TextStyle(fontFamily: 'Overpass', fontSize: 20.0);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _success;
  String _derror;
  String _userEmail;
  UserCredential _userCredential;
  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
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
                      Text("Login",
                          style: TextStyle(
                              color: Colors.black87,
                              fontFamily: 'Overpass',
                              fontSize: 25))
                    ],
                  ),
                ),
                Container(
                  child: smallName("Please Login to enter this app"),
                ),
                SizedBox(height: 50),
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
                          //             child: SignUp(),
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
                SizedBox(height: 30),
                Container(
                  child: smallName("or Login with email"),
                ),
                SizedBox(height: 25.0),

                //amogh
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 25.0),
                      TextFormField(
                        textAlignVertical: TextAlignVertical.center,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                        decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            hintText: "Email",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32.0),
                            )),
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Please enter some text';
                          }
                          const pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
                          final regExp = RegExp(pattern);

                          if (!regExp.hasMatch(value)) {
                            return 'Invalid Email';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 25.0),
                      TextFormField(
                        textAlignVertical: TextAlignVertical.center,
                        controller: _passwordController,
                        decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            hintText: "Password",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32.0),
                            )),
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 5.0),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            MaterialButton(
                              onPressed: () {
                                print('pressed');
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        child: ForgotPassword(),
                                        type: PageTransitionType.fade));
                              },
                              child: Text(
                                "Forgot Password ?",
                                style: TextStyle(
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          _success == null
                              ? ''
                              : (_success
                                  ? 'Login Success ' + _userEmail
                                  : _derror),
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                ),
                //amogh

                Container(
                  height: 80,
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  margin: EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    children: [
                      Expanded(
                        child: MaterialButton(
                          height: 50,
                          color: Color(0xff222222),
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              try {
                                _userCredential = await FirebaseAuth.instance
                                    .signInWithEmailAndPassword(
                                  email: _emailController.text.trim(),
                                  password: _passwordController.text,
                                );

                                print("amogh output /n");
                                print(_userCredential);
                                if (_userCredential != null) {
                                  setState(() {
                                    _success = true;
                                    _userEmail = _emailController.text;
                                    _derror = "";
                                  });

                                  bool emailV =
                                      _userCredential.user.emailVerified;
                                  if (emailV == true) {
                                    FirebaseAuth auth = FirebaseAuth.instance;
                                    String uid =
                                        auth.currentUser.uid.toString();
                                    FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(uid)
                                        .update({
                                      'emailVerified': true,
                                    });

                                    Navigator.of(context)
                                        .pushReplacementNamed('/SideBarLayout');
                                  } else {
                                    Navigator.of(context)
                                        .pushReplacementNamed('/verifyEmail');
                                  }
                                }
                              } on FirebaseAuthException catch (e) {
                                if (e.code == 'user-not-found') {
                                  setState(() {
                                    _success = false;
                                    _userEmail = null;
                                    _derror = "No user found for that email";
                                  });
                                } else if (e.code == 'wrong-password') {
                                  setState(() {
                                    _success = false;
                                    _userEmail = null;
                                    _derror =
                                        "Wrong password provided for that user";
                                  });
                                } else if (e.code == 'user-not-found') {
                                  setState(() {
                                    _success = false;
                                    _userEmail = null;
                                    _derror = "No user found for that email";
                                  });
                                } else if (e.code == 'user-disabled') {
                                  setState(() {
                                    _success = false;
                                    _userEmail = _emailController.text;
                                    _derror = "Something went worng";
                                  });
                                } else if (e.code == 'too-many-requests') {
                                  setState(() {
                                    _success = false;
                                    _userEmail = _emailController.text;
                                    _derror =
                                        "Too many requests, Please try again later";
                                  });
                                }
                              }
                            }
                          },
                          child: Text(
                            "Login",
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
                      smallName("Dont have an account?"),
                      MaterialButton(
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
