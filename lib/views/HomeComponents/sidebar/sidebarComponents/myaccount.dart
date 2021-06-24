import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:zerowaste/bloc_navigation_bloc/navigation_bloc.dart';
import 'package:zerowaste/models/user.dart' as U;
import 'package:zerowaste/models/userSetUp.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:zerowaste/views/HomeComponents/location.dart';

class MyAccount extends StatefulWidget with NavigationStates {
  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  var addr;
  String uid = FirebaseAuth.instance.currentUser.uid.toString();
  List<U.User> items;
  String errorMessage;

  @override
  void initState() {
    super.initState();
  }

  Widget checkEmail(snapshot) {
    if (snapshot.data['emailVerified'] == false) {
      return GestureDetector(
        onTap: () {
          Navigator.of(context).pushReplacementNamed('/verifyEmail');
        },
        child: Text(
          "  (Tap to verifie)",
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w300, color: Colors.red),
        ),
      );
    } else {
      return Text(
        "  (Verified)",
        style: TextStyle(
            fontSize: 16, fontWeight: FontWeight.w400, color: Colors.green),
      );
    }
  }

  Widget checkContact(snapshot) {
    if (snapshot.data['phoneVerified'] == false) {
      return GestureDetector(
        onTap: () {
          Navigator.of(context).pushReplacementNamed('/phoneAuth');
        },
        child: Text(
          "  (Tap to verifie)",
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w300, color: Colors.red),
        ),
      );
    } else {
      return Text(
        "  (Verified)",
        style: TextStyle(
            fontSize: 16, fontWeight: FontWeight.w400, color: Colors.green),
      );
    }
  }

  Widget checkAddress(snapshot) {
    if (snapshot.data['address'].toString() == 'null') {
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Location()),
          );
        },
        child: Text(
          "  (Tap to add address)",
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w300, color: Colors.red),
        ),
      );
    } else {
      return Text(
        "  (Address selected)",
        style: TextStyle(
            fontSize: 16, fontWeight: FontWeight.w400, color: Colors.green),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Icon(
              Icons.verified_user,
              color: Colors.black,
            ),
            SizedBox(
              width: 3,
            ),
            Text(
              'User profile',
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
          ],
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.green[400],
            size: 18,
          ),
          onPressed: () {
            Navigator.of(context).pushReplacementNamed('/SideBarLayout');
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 100,
              width: 100,
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'assets/myprofile.jpg',
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .doc(uid)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Text('data is loading');
                      }
                      return Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Welcome!  ",
                                style: TextStyle(fontSize: 22),
                              ),
                              Text(
                                snapshot.data['name'],
                                style: TextStyle(fontSize: 22),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: new Container(
                              height: 8.0,
                              color: Colors.grey[100],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Row(
                              children: [
                                Text(
                                  "email : ",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w300),
                                ),
                                Text(
                                  snapshot.data['email'].toString(),
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w300),
                                ),
                                checkEmail(snapshot),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Row(
                              children: [
                                Text(
                                  "phone number : ",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w300),
                                ),
                                Text(
                                  snapshot.data['contactNo'].toString(),
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w300),
                                ),
                                checkContact(snapshot),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Row(
                              children: [
                                Text(
                                  "address : ",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w300),
                                ),
                                // Text(
                                //   snapshot.data['address'],
                                //   style: TextStyle(
                                //       fontSize: 16,
                                //       fontWeight: FontWeight.w300),
                                // ),
                                checkAddress(snapshot),
                              ],
                            ),
                          )
                        ],
                      );
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
