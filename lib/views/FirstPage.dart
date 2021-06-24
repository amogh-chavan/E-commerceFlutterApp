import 'dart:async';
import 'package:flutter/material.dart';
import 'package:zerowaste/services/HomeController.dart';

import 'package:zerowaste/widgets/provider_widget.dart';
import 'package:zerowaste/services/Authentication.dart';

String redirect;

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  void initState() {
    print(redirect);
    Timer(
      Duration(seconds: 3),
      // () => Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => HomeController(),
      //     )),

      () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => HomeController(),
          //builder: (context) => SideBarLayout(),
        ),
      ),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AuthProvider(
      auth: AuthService(),
      child: Scaffold(
        backgroundColor: Color(0xffEFFFE0),
        body: Container(
          child: Center(
              child: Padding(
            padding: const EdgeInsets.all(50.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 300,
                  child: Image.asset('assets/icon.png'),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 60.0),
                  child: CircularProgressIndicator(
                    backgroundColor: Color(0xff222222),
                  ),
                )
              ],
            ),
          )),
        ),
      ),
    );
  }
}
