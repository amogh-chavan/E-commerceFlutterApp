import 'package:adminpanel_gt/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ReturnedOrder extends StatefulWidget {
  @override
  _ReturnedOrderState createState() => _ReturnedOrderState();
}

class _ReturnedOrderState extends State<ReturnedOrder> {
  String uid = FirebaseAuth.instance.currentUser.uid.toString();

  Widget displaylist(List list) {
    return Text(list.toString());
  }

  Widget getTimingDet(Timestamp time) {
    return Column(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DateTime.fromMicrosecondsSinceEpoch(time.microsecondsSinceEpoch)
                      .toLocal()
                      .day
                      .toString() +
                  '/' +
                  DateTime.fromMicrosecondsSinceEpoch(
                          time.microsecondsSinceEpoch)
                      .toLocal()
                      .month
                      .toString() +
                  '/' +
                  DateTime.fromMicrosecondsSinceEpoch(
                          time.microsecondsSinceEpoch)
                      .toLocal()
                      .year
                      .toString(),
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ],
        )
      ],
    );
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
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Home()));
          },
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('AdminRecordForReturnedOrders')
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
                height: MediaQuery.of(context).size.height,
                child: new ListView(
                  children: snapshot.data.docs.map((DocumentSnapshot document) {
                    return Column(
                      children: [
                        Card(
                          //  color: Colors.red,
                          child: ListTile(
                            leading: SizedBox(
                                width: 100,
                                height: 100,
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.bookmark,
                                      color: Colors.green[400],
                                      size: 35,
                                    ),
                                  ],
                                )),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text('Order Id',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black)),
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 26.0, right: 4.0),
                                    ),
                                    Text(document['OrderID'])
                                  ],
                                ),
                              ],
                            ),
                            subtitle: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Text(document.id),
                                SizedBox(
                                  height: 5,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Customer UID: ',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black)),
                                    Text(
                                      document['CustomerID'].toString(),
                                      //'',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),

                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('This Document ID: ',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black)),
                                    Text(
                                      document.id.toString(),
                                      //'',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 15,
                                    ),
                                    FlatButton.icon(
                                      color: Colors.grey[300],
                                      label: Text('Delete Order'),
                                      icon: Icon(
                                        Icons.delete_forever,
                                        color: Colors.red,
                                      ),
                                      onPressed: () {
                                        Scaffold.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text('Are you sure?'),
                                          action: SnackBarAction(
                                            label: 'YES',
                                            onPressed: () {
                                              FirebaseFirestore.instance
                                                  .collection(
                                                      'AdminRecordForReturnedOrders')
                                                  .doc(document.id)
                                                  .delete();
                                            },
                                          ),
                                        ));
                                      },
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                            isThreeLine: true,
                          ),
                        ),
                      ],
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
