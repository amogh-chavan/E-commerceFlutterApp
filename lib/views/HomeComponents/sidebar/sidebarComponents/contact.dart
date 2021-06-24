import 'package:flutter/material.dart';
import 'package:zerowaste/bloc_navigation_bloc/navigation_bloc.dart';

class Contact extends StatefulWidget with NavigationStates {
  @override
  _ContactState createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Icon(
              Icons.call,
              color: Colors.black,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              'Customer care',
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
            SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'You can contact us through mail',
                    style: TextStyle(fontSize: 18),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '- If you want to inquire of order',
                    style: TextStyle(fontSize: 18),
                  ),
                  Row(
                    children: [
                      Text(
                        'Support Email: ',
                        style: TextStyle(fontSize: 18),
                      ),
                      Icon(
                        Icons.email,
                        color: Colors.green[400],
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Text(
                      '" productSupport@greentrends.com " ',
                      style: TextStyle(fontSize: 18),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '- If you want help with platform',
                    style: TextStyle(fontSize: 18),
                  ),
                  Row(
                    children: [
                      Text(
                        'Support Email: ',
                        style: TextStyle(fontSize: 18),
                      ),
                      Icon(
                        Icons.email,
                        color: Colors.green[400],
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Text(
                      '" generalSupport@greentrends.com " ',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '- Contact developer',
                          style: TextStyle(fontSize: 18),
                        ),
                        Row(
                          children: [
                            Text(
                              'Support Email: ',
                              style: TextStyle(fontSize: 18),
                            ),
                            Icon(
                              Icons.email,
                              color: Colors.lightBlue,
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Text(
                            '" chavanamogh1@gmail.com " ',
                            style: TextStyle(fontSize: 18),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
