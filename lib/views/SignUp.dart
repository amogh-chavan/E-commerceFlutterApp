import 'package:firebase_auth/firebase_auth.dart';
import 'package:zerowaste/models/user.dart' as U;
import 'package:zerowaste/models/userSetUp.dart';

import 'package:zerowaste/views/Login.dart';
import 'package:flutter/material.dart';
import 'package:zerowaste/widgets/widgets.dart';
import 'package:page_transition/page_transition.dart';
import 'package:zerowaste/services/Authentication.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
//import 'package:firebase_database/firebase_database.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  AuthService authentication = AuthService();
  UserCredential _userCredential;

  // TextStyle style = TextStyle(fontFamily: 'Overpass', fontSize: 20.0);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // DatabaseReference dbRef =
  //   FirebaseDatabase.instance.reference().child("User_Information");
  bool _success;
  String _userEmail;
  String _derror;
  final TextEditingController _nameController = new TextEditingController();
  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
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
                      Text("Sign Up",
                          style: TextStyle(
                              color: Colors.black87,
                              fontFamily: 'Overpass',
                              fontSize: 25))
                    ],
                  ),
                ),
                Container(
                  child: smallName("Please sign up to enter this app"),
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
                  child: smallName("or Sign up with email"),
                ),
                SizedBox(height: 25.0),

                //amogh
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextFormField(
                        textAlignVertical: TextAlignVertical.center,
                        textInputAction: TextInputAction.next,
                        controller: _nameController,
                        //decoration: const InputDecoration(labelText: 'Name'),
                        decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            hintText: "Name",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32.0),
                            )),
                        validator: (String value) {
                          if (value.isEmpty) {
                            return "Name can't be empty";
                          }
                          if (value.length < 2) {
                            return "Name must be at least 2 characters long";
                          }
                          if (value.length > 50) {
                            return "Name must be less than 50 characters long";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 25.0),
                      TextFormField(
                        textAlignVertical: TextAlignVertical.center,
                        textInputAction: TextInputAction.next,
                        controller: _emailController,
                        // decoration: const InputDecoration(labelText: 'Email'),
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
                        //decoration: const InputDecoration(labelText: 'Password'),
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
                          if (value.length < 8) {
                            return "Password must be at least 8 characters long";
                          }
                          if (value.length > 30) {
                            return "Name must be less than 30 characters long";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10.0),
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          _success == null
                              ? ''
                              : (_success
                                  ? 'Registration Success ' + _userEmail
                                  : _derror),
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                ),
                //amogh

                // SizedBox(
                //   height: 05.0,
                // ),
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
                            // if (_formKey.currentState.validate()) {
                            //   authentication
                            //       .createUserWithEmailAndPassword(
                            //           _emailController.text,
                            //           _passwordController.text,
                            //           _nameController.text)
                            //       .whenComplete(() {
                            //     setState(() {
                            //       _success = true;
                            //       _userEmail = _emailController.text;
                            //     });
                            //     try {
                            //       Navigator.of(context)
                            //           .pushReplacementNamed('/verifyEmail');
                            //     } catch (e) {
                            //       print(e);
                            //     }
                            //   });
                            // }
                            if (_formKey.currentState.validate()) {
                              try {
                                _userCredential = await FirebaseAuth.instance
                                    .createUserWithEmailAndPassword(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                );
                                await authentication.updateUserName(
                                    _nameController.text, _userCredential.user);

                                if (_userCredential.user.uid != null) {
                                  U.User(
                                      uid: _userCredential.user.uid,
                                      email: _userCredential.user.email,
                                      fullName: _nameController.text);

                                  userSetUp(
                                      name: _nameController.text,
                                      email: _userCredential.user.email,
                                      emailVerified: false,
                                      phoneVerified: false,
                                      cartTotalCost: 0,
                                      cartItems: [],
                                      wishlistItems: [],
                                      orderItems: [],
                                      previousItems: []);

                                  setState(() {
                                    _success = true;
                                    _userEmail = _emailController.text;
                                    _derror = "";
                                  });
                                  Navigator.of(context)
                                      .pushReplacementNamed('/verifyEmail');
                                }
                              } on FirebaseAuthException catch (e) {
                                if (e.code == 'email-already-in-use') {
                                  setState(() {
                                    _success = false;
                                    _userEmail = null;
                                    _derror = "Email is already registered";
                                  });
                                } else if (e.code == 'invalid-email') {
                                  setState(() {
                                    _success = false;
                                    _userEmail = null;
                                    _derror = "Invalid email";
                                  });
                                } else if (e.code == 'weak-password') {
                                  setState(() {
                                    _success = false;
                                    _userEmail = null;
                                    _derror = "Password is too weak";
                                  });
                                }
                              }
                            }
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
