import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:zerowaste/bloc_navigation_bloc/navigation_bloc.dart';
import 'package:zerowaste/views/HomeComponents/Result/display_item_OrderProduct.dart';
import 'package:zerowaste/views/HomeComponents/Result/display_item_card.dart';
import 'package:zerowaste/views/HomeComponents/Result/display_orderDetails.dart';
import 'package:zerowaste/views/HomeComponents/Result/item_card.dart';

class MyOrders extends StatefulWidget with NavigationStates {
  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  String uid = FirebaseAuth.instance.currentUser.uid.toString();
  String oid;
  @override
  void initState() {
    super.initState();
  }

  Widget displaylist(List list) {
    return Text(list.length.toString());
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
              'Your orders',
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
                height: MediaQuery.of(context).size.height,
                child: new ListView(
                  children: snapshot.data.docs.map((DocumentSnapshot document) {
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => OrderDeatils(
                                          oUID: document.id,
                                        )));
                          },
                          child: Card(
                            //  color: Colors.red,
                            child: ListTile(
                              leading: SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: Icon(
                                    Icons.bookmark,
                                    color: Colors.green[400],
                                    size: 35,
                                  )),
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text('Order Id'),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 26.0, right: 4.0),
                                        //child: Text('\u{20B9}'),
                                      ),
                                      //  Text(document['productCost'])
                                    ],
                                  ),
                                ],
                              ),
                              subtitle: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(document.id),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text('Date of ordering: ',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black)),
                                  getTimingDet(document['dateOfOrder']),
                                  Text('Date of Delivery: ',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black)),
                                  getTimingDet(document['dateOfDeliver']),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text('Total Items: ',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black)),
                                      displaylist(document['orderItems'])
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text('Total cost: ',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black)),
                                      Text("Rs " +
                                          document['totalCostOfOrder']
                                              .toString())
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  )
                                ],
                              ),
                              isThreeLine: true,
                            ),
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
    );
  }
}
