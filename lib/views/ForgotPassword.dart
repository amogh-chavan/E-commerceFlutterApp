import 'package:flutter/material.dart';
import 'package:zerowaste/views/Login.dart';
import 'package:zerowaste/widgets/widgets.dart';
import 'package:page_transition/page_transition.dart';
import 'package:zerowaste/views/SignUp.dart';
import 'package:zerowaste/services/Authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  AuthService authentication = AuthService();
  Timer timer;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = new TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    timer.cancel();
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
                      Text("Forgot Password",
                          style: TextStyle(
                              color: Colors.black87,
                              fontFamily: 'Overpass',
                              fontSize: 25))
                    ],
                  ),
                ),

                SizedBox(height: 30),
                Container(
                  child: smallName(
                      "Enter email for the account you want to reset password"),
                ),
                SizedBox(height: 10.0),

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
                      SizedBox(height: 5.0),
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
                        child: Builder(builder: (context) {
                          return MaterialButton(
                            height: 50,
                            color: Color(0xff222222),
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                try {
                                  FirebaseAuth.instance
                                      .sendPasswordResetEmail(
                                    email: _emailController.text.trim(),
                                  )
                                      .catchError((onError) {
                                    final snackBar = SnackBar(
                                      content: Text("Error user not found"),
                                      duration: Duration(seconds: 3),
                                      action: SnackBarAction(
                                          label: "Login",
                                          onPressed: () => Navigator.of(context)
                                                  .pushReplacement(
                                                MaterialPageRoute(
                                                  builder: (context) => Login(),
                                                ),
                                              )
                                          // Navigator.push(
                                          //     context,
                                          //     PageTransition(
                                          //         child: Login(),
                                          //         type: PageTransitionType
                                          //             .leftToRight)),
                                          ),
                                    );
                                    Scaffold.of(context).showSnackBar(snackBar);
                                  });

                                  timer = Timer.periodic(Duration(seconds: 5),
                                      (timer) {
                                    Navigator.pop(context);
                                  });
                                } on FirebaseAuthException catch (e) {
                                  print(e);
                                }
                              }
                            },
                            child: Text(
                              "Submit",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          );
                        }),
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
                  height: 30.0,
                ),
                Container(
                  child: smallName(
                      "Registered account will recive a reset password link"),
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
