import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:zerowaste/bloc_navigation_bloc/navigation_bloc.dart';
import 'package:zerowaste/views/HomeComponents/PlaceOrder/billing.dart';
import 'package:zerowaste/views/HomeComponents/Result/display_item_card.dart';
import 'package:zerowaste/views/HomeComponents/Result/item_card.dart';

class MyCart extends StatefulWidget with NavigationStates {
  @override
  _MyCartState createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  double totalCost = 0;

  _MyCartState();

  String uid = FirebaseAuth.instance.currentUser.uid.toString();

  Widget displaylist(List list) {
    if (list.isNotEmpty || list == null) {
      return Expanded(
        child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            return DisplayItemCard(
              cate: list[index],
              uid: uid,
            );
          },
        ),
      );
    } else {
      FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .update({'cartTotalCost': 0});
      return Column(
        children: [
          Center(
            heightFactor: 5,
            child: Text(
              'You have no items in cart',
              style: TextStyle(fontSize: 18),
            ),
          ),
          MaterialButton(
            onPressed: () {
              print('pressed');
              Navigator.of(context).pushReplacementNamed('/SideBarLayout');
            },
            child: Text(
              "start shopping",
              style: TextStyle(
                color: Colors.blue,
              ),
            ),
          ),
          SizedBox(
            height: 50,
          )
        ],
      );
    }
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
              Icons.shopping_cart_rounded,
              color: Colors.black,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              'Shopping Cart',
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
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Text(' error : ${snapshot.error} ');
                  }
                  // return displaylist(snapshot.data['cartItems']);
                  return Column(
                    children: <Widget>[
                      displaylist(snapshot.data['cartItems']),
                      FlatButton.icon(
                        height: 50,
                        color: Colors.green[400],
                        onPressed: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  child: Billing(
                                    tCost: snapshot.data['cartTotalCost'],
                                    itemsToOrder: snapshot.data['cartItems'],
                                  ),
                                  type: PageTransitionType.fade));
                        },
                        icon: Icon(Icons.check_circle_outline,
                            color: Colors.white),
                        label: Text(
                          "Checkout",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      )
                    ],
                  );
                }),
          ),
        ],
      ),
    );
  }
}
