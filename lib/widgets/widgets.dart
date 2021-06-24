import 'package:flutter/material.dart';

Widget brandName(String name) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Text(
        name,
        style: TextStyle(
            color: Colors.black87, fontFamily: 'Overpass', fontSize: 25),
      )
    ],
  );
}

Widget smallName(String name) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Text(name,
          style: TextStyle(
              color: Colors.black38, fontFamily: 'Overpass', fontSize: 12))
    ],
  );
}

Widget mediumName(String name) {
  return Row(
    children: <Widget>[
      Text(name,
          style: TextStyle(
              color: Colors.black, fontFamily: 'Overpass', fontSize: 18))
    ],
  );
}

Widget displayError(BuildContext context, String error) {
  return AlertDialog(
    title: Text(error),
    actions: <Widget>[
      TextButton(
        child: Text("ok"),
        onPressed: () {
          Navigator.of(context).pop();
        },
      )
    ],
  );
}
