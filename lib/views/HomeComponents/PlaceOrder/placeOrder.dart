import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'package:zerowaste/models/product.dart';
import 'package:zerowaste/views/HomeComponents/PlaceOrder/endOfOrder.dart';
import 'package:zerowaste/views/HomeComponents/Result/categoriesResult.dart';
import 'package:zerowaste/views/HomeComponents/location.dart';
import 'package:zerowaste/views/HomeComponents/sidebar/sidebarComponents/myaccount.dart';
import 'package:zerowaste/views/HomeComponents/sidebar/sidebarComponents/myorders.dart';
import 'package:zerowaste/views/HomeComponents/sidebar/sidebarComponents/wishlist.dart';
import 'package:slider_button/slider_button.dart';
import 'package:uuid/uuid.dart';

class PlaceOrder extends StatefulWidget {
  final List productIds;
  final int tCost;
  const PlaceOrder({Key key, this.productIds, this.tCost}) : super(key: key);

  @override
  _PlaceOrderState createState() => _PlaceOrderState();
}

class _PlaceOrderState extends State<PlaceOrder> {
  var uuid = Uuid();

  var orderDate = DateTime.now();
  var deliverDate = DateTime.now().add(const Duration(days: 15));
  List orderIdList = [];
  List<String> itemList = [];
  bool check1 = true;
  String payment;
  String uid = FirebaseAuth.instance.currentUser.uid.toString();
  final auth = FirebaseAuth.instance;
  User user;

  @override
  void initState() {
    user = auth.currentUser;

    super.initState();
  }

  Widget finalcheck(snapshot) {
    if (snapshot.data['emailVerified'] == false ||
        snapshot.data['phoneVerified'] == false ||
        snapshot.data['address'].toString() == 'null' ||
        check1 == false ||
        payment == null) {
      return Text(
        'Please verify all user details',
        style: TextStyle(fontSize: 18, color: Colors.red),
      );
    } else {
      return Center(
          child: SliderButton(
              vibrationFlag: true,
              backgroundColor: Colors.green[400],
              action: () {
                orderIdList.add(uuid.v4());
                //  itemList.add(widget.productIds);
                FirebaseFirestore.instance
                    .collection('users')
                    .doc(uid)
                    .update({'orderItems': FieldValue.arrayUnion(orderIdList)});

                FirebaseFirestore.instance
                    .collection('orders')
                    .doc(uid)
                    .collection('user_orders')
                    .doc(orderIdList[0])
                    .set({
                  'orderItems': FieldValue.arrayUnion(widget.productIds),
                  'dateOfOrder': orderDate,
                  'dateOfDeliver': deliverDate,
                  'customerUID': uid,
                  'totalCostOfOrder': widget.tCost,
                  'deliveryAddress': snapshot.data['address'],
                  'customerEmail': snapshot.data['email'],
                  'customerName': snapshot.data['name'],
                  'customerNumber': snapshot.data['contactNo']
                });

                FirebaseFirestore.instance
                    .collection('AdminRecordForOrders')
                    .doc()
                    .set({
                  'orderItems': FieldValue.arrayUnion(widget.productIds),
                  'dateOfOrder': orderDate,
                  'dateOfDeliver': deliverDate,
                  'customerUID': uid,
                  'totalCostOfOrder': widget.tCost,
                  'deliveryAddress': snapshot.data['address'],
                  'customerEmail': snapshot.data['email'],
                  'customerName': snapshot.data['name'],
                  'customerNumber': snapshot.data['contactNo']
                });

                Navigator.of(context).pushReplacementNamed('/endOfOrder');
              },
              label: Text(
                "Slide to place order",
                style: TextStyle(
                    color: Color(0xff4a4a4a),
                    fontWeight: FontWeight.w500,
                    fontSize: 17),
              ),
              // icon: Text(
              //   "x",
              //   style: TextStyle(
              //     color: Colors.white,
              //     fontWeight: FontWeight.w400,
              //     fontSize: 44,
              //   ),
              // ),
              icon: Icon(Icons.shopping_cart),
              boxShadow: BoxShadow(
                color: Colors.green,
                blurRadius: 4,
              )));
    }
  }

  Widget checkEmail(snapshot) {
    if (snapshot.data['emailVerified'] == false) {
      return GestureDetector(
        onTap: () {
          Navigator.of(context).pushReplacementNamed('/verifyEmail');
        },
        child: Text(
          "  (Tap to verifie)",
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w300, color: Colors.red),
        ),
      );
    } else {
      return Text(
        "  (Verified)",
        style: TextStyle(
            fontSize: 16, fontWeight: FontWeight.w400, color: Colors.green),
      );
    }
  }

  Widget checkContact(snapshot) {
    if (snapshot.data['phoneVerified'] == false) {
      return GestureDetector(
        onTap: () {
          Navigator.of(context).pushReplacementNamed('/phoneAuth');
        },
        child: Text(
          "  (Tap to verifie)",
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w300, color: Colors.red),
        ),
      );
    } else {
      return Text(
        "  (Verified)",
        style: TextStyle(
            fontSize: 16, fontWeight: FontWeight.w400, color: Colors.green),
      );
    }
  }

  Widget checkAddress(snapshot) {
    if (snapshot.data['address'].toString() == 'null') {
      return GestureDetector(
        onTap: () {
          Navigator.of(context).pushReplacementNamed('/location');
        },
        child: Text(
          "  (Tap to add address)",
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w300, color: Colors.red),
        ),
      );
    } else {
      return Text(
        "  (Address selected)",
        style: TextStyle(
            fontSize: 16, fontWeight: FontWeight.w400, color: Colors.green),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Row(
              children: [
                Checkbox(
                  value: check1,
                  onChanged: (bool value) {
                    setState(() {
                      check1 = value;
                    });
                  },
                ),
                Text(
                  "Confirm Order details",
                  style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w300),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Column(
                  children: <Widget>[
                    StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .doc(uid)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Text('data is loading');
                        }
                        return Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Welcome!  ",
                                  style: TextStyle(fontSize: 22),
                                ),
                                Text(
                                  snapshot.data['name'],
                                  style: TextStyle(fontSize: 22),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: new Container(
                                height: 8.0,
                                color: Colors.grey[100],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "email : ",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w300),
                                      ),
                                      checkEmail(snapshot),
                                    ],
                                  ),
                                  Text(
                                    snapshot.data['email'].toString(),
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "phone number : ",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w300),
                                      ),
                                      checkContact(snapshot),
                                    ],
                                  ),
                                  Text(
                                    snapshot.data['contactNo'].toString(),
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "address : ",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w300),
                                      ),
                                      checkAddress(snapshot),
                                    ],
                                  ),
                                  // Text(
                                  //   snapshot.data['address'],
                                  //   style: TextStyle(
                                  //       fontSize: 16,
                                  //       fontWeight: FontWeight.w300),
                                  // ),
                                ],
                              ),
                            ),
                            new Container(
                              height: 10.0,
                              color: Colors.grey[100],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Text('Select Payment Method',
                                      style: TextStyle(
                                          fontSize: 22.0,
                                          fontWeight: FontWeight.w300)),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Card(
                              elevation: 3,
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Radio(
                                          value: 'COD',
                                          groupValue: payment,
                                          onChanged: (val) {
                                            setState(() {
                                              payment = val;
                                            });
                                          }),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          'Cash On Delivery',
                                          style: TextStyle(fontSize: 18),
                                          textAlign: TextAlign.center,
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Card(
                              elevation: 3,
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Radio(
                                          value: 'CARD',

                                          //groupValue: payment,
                                          groupValue: null,
                                          onChanged: (val) {
                                            setState(() {
                                              // payment = val;
                                            });
                                          }),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          'Debit or Credit card ',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w300),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          '(Not available)',
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Card(
                              elevation: 3,
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Radio(
                                          value: 'UPI',
                                          // groupValue: payment,
                                          groupValue: payment,
                                          onChanged: (val) {
                                            setState(() {
                                              //  payment = val;
                                            });
                                          }),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          'UPI payment',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w300),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          '(Not available)',
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            finalcheck(snapshot),
                          ],
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    leading: IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    ),
    title: Text(
      '',
      style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w300,
          fontFamily: 'Pacifico'),
    ),
    backgroundColor: Colors.green[400],
    elevation: 0.5,
    actions: <Widget>[
      Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: IconButton(
          icon: Icon(Icons.location_pin),
          color: Colors.white,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Location()),
            );
          },
        ),
      ),
      InkWell(
        child: Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: IconButton(
            icon: Icon(Icons.shopping_cart_outlined),
            color: Colors.white,
            onPressed: () {
              Navigator.push(
                  context,
                  PageTransition(
                      child: MyOrders(), type: PageTransitionType.fade));
            },
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 20.0),
        child: IconButton(
          icon: Icon(Icons.favorite),
          color: Colors.pink,
          onPressed: () {
            Navigator.push(
                context,
                PageTransition(
                    child: WishList(), type: PageTransitionType.fade));
          },
        ),
      ),
    ],
  );
}
