import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:zerowaste/bloc_navigation_bloc/navigation_bloc.dart';
import 'package:zerowaste/views/HomeComponents/PlaceOrder/billing.dart';
import 'package:zerowaste/views/HomeComponents/Result/display_item_card.dart';
import 'package:zerowaste/views/HomeComponents/Result/display_item_cardWishList.dart';
import 'package:zerowaste/views/HomeComponents/Result/item_card.dart';

class WishList extends StatefulWidget with NavigationStates {
  @override
  _WishListState createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  String uid = FirebaseAuth.instance.currentUser.uid.toString();

  Widget displaylist(List list) {
    if (list.isNotEmpty || list == null) {
      return Expanded(
        child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            return DisplayItemCardWishList(
              cate: list[index],
              uid: uid,
            );
          },
        ),
      );
    } else {
      return Column(
        children: [
          Center(
            heightFactor: 5,
            child: Text(
              'You have no items in wishlist',
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
              Icons.favorite_border_rounded,
              color: Colors.red,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              'Wishlist',
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
                      displaylist(snapshot.data['wishlistItems']),
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
