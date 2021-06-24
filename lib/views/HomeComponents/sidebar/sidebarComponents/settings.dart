import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zerowaste/bloc_navigation_bloc/navigation_bloc.dart';

class Settings extends StatelessWidget with NavigationStates {
  String uid = FirebaseAuth.instance.currentUser.uid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 1,
          backgroundColor: Colors.white,
          title: Row(
            children: [
              Icon(
                Icons.settings,
                color: Colors.black,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                'Settings',
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
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: FlatButton.icon(
                splashColor: Colors.red,
                onPressed: () {
                  print('deleted');
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text("ARE YOU SURE ?"),
                    action: SnackBarAction(
                      label: 'Confirm',
                      onPressed: () {
                        if (uid != null) {
                          FirebaseAuth.instance.signOut();
                          FirebaseFirestore.instance
                              .collection('users')
                              .doc(uid)
                              .delete();

                          FirebaseAuth.instance.currentUser
                              .delete()
                              .whenComplete(() {
                            Navigator.of(context)
                                .pushReplacementNamed('/Welcome')
                                .catchError((e) {
                              print(e);
                            });
                          });
                        }
                      },
                    ),
                  ));
                },
                icon: Icon(Icons.delete),
                color: Colors.grey[200],
                label: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Text(
                    "Delete Account",
                    style: TextStyle(fontSize: 18, color: Colors.red[300]),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
