import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:zerowaste/models/user.dart' as U;
import 'package:zerowaste/views/Login.dart';
import 'package:zerowaste/widgets/widgets.dart';

class VerifyEmail extends StatefulWidget {
  @override
  _VerifyEmailState createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  final auth = FirebaseAuth.instance;
  User user;
  Timer timer;
  @override
  void initState() {
    user = auth.currentUser;

    user.sendEmailVerification();
    timer = Timer.periodic(Duration(seconds: 8), (timer) {
      Navigator.of(context).pushReplacementNamed('/Login');
    });
    // timer = Timer.periodic(Duration(seconds: 2), (timer) {
    //   checkEmailVerified(context);
    // });
    auth.signOut();
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 70,
                ),
                brandName("Almost there!"),
                SizedBox(height: 20),
                Divider(
                  color: Colors.black,
                  thickness: 1.0,
                ),
                SizedBox(height: 20),
                Container(
                  height: 30,
                  child: Text(
                    'Please verify An email verification link has been sent to ${user.email} ',
                    overflow: TextOverflow.visible,
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
                Center(
                  child: SizedBox(
                    height: 250.0,
                    width: 300.0,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      margin: EdgeInsets.symmetric(horizontal: 24),
                      //  child: Image.asset('assets/Email.png')

                      child: Icon(
                        Icons.email_outlined,
                        size: 55,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 20,
                      child: Text(
                        'After verification Please',
                        overflow: TextOverflow.visible,
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    MaterialButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) => Login()));
                        print('pressed');
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    Container(
                      height: 20,
                      child: Text(
                        'again',
                        overflow: TextOverflow.visible,
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 20,
                      child: Text(
                        'Check your spam mail or',
                        overflow: TextOverflow.visible,
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    MaterialButton(
                      onPressed: () {
                        print('pressed');
                        //resendEmail();
                        user.sendEmailVerification();
                      },
                      child: Text(
                        "Resend Email",
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Container(
                  height: 20,
                  child: Text(
                    'For any queries or assistance, please email support@GreenTrends.com',
                    overflow: TextOverflow.visible,
                    style: TextStyle(fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> checkEmailVerified(BuildContext context) async {
    user = auth.currentUser;
    await user.reload();
    if (user.emailVerified) {
      U.User(emailVerified: true);
      FirebaseAuth auth = FirebaseAuth.instance;
      String uid = auth.currentUser.uid.toString();
      FirebaseFirestore.instance.collection('users').doc(uid).update({
        'emailVerified': true,
      });
      timer.cancel();
    }
  }

  void resendEmail() {
    user.sendEmailVerification();
  }
}
