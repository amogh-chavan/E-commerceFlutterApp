import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserCount extends StatefulWidget {
  @override
  _UserCountState createState() => _UserCountState();
}

class _UserCountState extends State<UserCount> {
  MaterialColor active = Colors.red;
  String uid = FirebaseAuth.instance.currentUser.uid.toString();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text(' error : ${snapshot.error} ');
          }
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return SizedBox(
                child: Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.green,
                  ),
                ),
              );
            case ConnectionState.none:
              return Text('No results found');
            case ConnectionState.done:
              return Text('connection done');

            default:
              return Text(
                snapshot.data.size.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(color: active, fontSize: 60.0),
              );
          }
        },
      ),
    );
  }
}
