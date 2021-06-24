import 'package:flutter/material.dart';
import 'package:zerowaste/views/HomeComponents/sidebar/sidebar.dart';

import 'package:zerowaste/views/HomeComponents/sidebar/sidebar_layout.dart';

import 'package:zerowaste/widgets/provider_widget.dart';
import 'package:zerowaste/services/Authentication.dart';
import 'package:zerowaste/views/SliderTile.dart';
import 'package:firebase_auth/firebase_auth.dart';

String redirect;

class HomeController extends StatefulWidget {
  @override
  _HomeControllerState createState() => _HomeControllerState();
}

enum AuthStatus {
  notDetermined,
  notSignedIn,
  signedIn,
}

class _HomeControllerState extends State<HomeController> {
  AuthStatus authStatus = AuthStatus.notDetermined;

  User user = FirebaseAuth.instance.currentUser;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final AuthService auth = AuthProvider.of(context).auth;
    auth.currentUser().then((String userId) {
      setState(() {
        authStatus =
            userId == null ? AuthStatus.notSignedIn : AuthStatus.signedIn;
      });
    }).catchError((onError) {
      authStatus = AuthStatus.notSignedIn;
    });
  }

  void _signedIn() {
    setState(() {
      authStatus = AuthStatus.signedIn;
    });
  }

  void _signedOut() {
    setState(() {
      authStatus = AuthStatus.notSignedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (authStatus) {
      case AuthStatus.notDetermined:
        return _buildWaitingScreen();
      case AuthStatus.notSignedIn:
        return SliderTile(
          onSignedIn: _signedIn,
        );
      case AuthStatus.signedIn:
        return SideBarLayout(
          onSignedOut: _signedOut,
        );
    }
    return null;
  }

  Widget _buildWaitingScreen() {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ),
    );
  }
}
