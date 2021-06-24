import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OrderDeatils extends StatefulWidget {
  final String oUID;
  const OrderDeatils({Key key, this.oUID}) : super(key: key);

  @override
  _OrderDeatilsState createState() => _OrderDeatilsState();
}

class _OrderDeatilsState extends State<OrderDeatils> {
  String uid = FirebaseAuth.instance.currentUser.uid.toString();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Icon(
              Icons.shopping_bag_sharp,
              color: Colors.black,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              'Orders Details',
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
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('orders')
            .doc(uid)
            .collection('user_orders')
            .where('customerUID', isEqualTo: uid)
            .snapshots(),
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
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey[200],
                ),
                padding: EdgeInsets.all(12.0),
                margin: EdgeInsets.all(8.0),
                height: 180,
                child: new ListView(
                  children: snapshot.data.docs.map((DocumentSnapshot document) {
                    return GestureDetector(
                      onTap: () {
                        //print('clicked');
                        //print(document['productName']);
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => DetailsScreen(
                        //               product: document['productName'],
                        //             )));
                      },
                      child: Column(
                        children: [
                          Text(document.id),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              );
          }
        },
      ),
      // Text(widget.oUID),
    );
  }
}
