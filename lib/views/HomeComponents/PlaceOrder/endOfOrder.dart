import 'dart:async';

import 'package:flutter/material.dart';

class EndOfOrder extends StatefulWidget {
  @override
  _EndOfOrderState createState() => _EndOfOrderState();
}

class _EndOfOrderState extends State<EndOfOrder> {
  Timer timer;
  @override
  void initState() {
    timer = Timer.periodic(Duration(seconds: 3), (timer) {
      Navigator.of(context).pushReplacementNamed('/SideBarLayout');
    });
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
        body: Column(mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
          SizedBox(height: 50),
          Center(
            child: Text(
              "Thank you !!",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w300,
                  fontFamily: 'Pacifico',
                  fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ),
          Center(
            child: Text(
              "Your order is placed",
              style: TextStyle(
                color: Colors.green[400],
                fontWeight: FontWeight.w300,
                fontFamily: 'Pacifico',
                fontSize: 25,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Center(
            child: Text(
              "GreenTrends",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w300,
                  fontFamily: 'Pacifico',
                  fontSize: 25),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Padding(
              padding: const EdgeInsets.all(16.0),
              child: FlatButton.icon(
                  label: Text("Go to Home"),
                  splashColor: Colors.white,
                  height: 50,
                  icon: Icon(Icons.home),
                  color: Colors.green[400],
                  onPressed: () async {
                    Navigator.of(context)
                        .pushReplacementNamed('/SideBarLayout');
                  }))
        ]));
  }
}
