import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:page_transition/page_transition.dart';
import 'package:zerowaste/views/HomeComponents/PlaceOrder/billing.dart';
import 'package:zerowaste/views/HomeComponents/PlaceOrder/placeOrder.dart';
import 'package:zerowaste/views/HomeComponents/ProductDetails/naturalResource.dart';

import 'package:zerowaste/views/HomeComponents/location.dart';
import 'package:zerowaste/views/HomeComponents/sidebar/sidebarComponents/mycart.dart';

import 'package:zerowaste/views/HomeComponents/sidebar/sidebarComponents/wishlist.dart';

class DetailsScreen extends StatefulWidget {
  final String product;

  const DetailsScreen({Key key, this.product}) : super(key: key);

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  int cost = 0;
  IconData newIcon = Icons.favorite_outline;
  List<String> itemList = [];
  List<String> cartList = [];
  List<String> itemToForward = [];
  String uid = FirebaseAuth.instance.currentUser.uid.toString();
  final auth = FirebaseAuth.instance;
  User user;

  @override
  void initState() {
    user = auth.currentUser;
    itemList.clear();
    cartList.clear();
    if (itemToForward != null || itemToForward.isNotEmpty) {
      itemToForward.clear();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // each product have a color
      // backgroundColor: product.color,
      appBar: buildAppBar(context),
      // body: CategoriesResult(product: product),
      //body: CategoriesResult(product : product),
      body: Column(
        children: <Widget>[
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('products')
                  .where('productName', isEqualTo: widget.product)
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
                    return new ListView(
                      children:
                          snapshot.data.docs.map((DocumentSnapshot document) {
                        return Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    document['productName'],
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    ' (${document['productCategorie']})',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            ),
                            new Container(
                              height: 10.0,
                              color: Colors.grey[100],
                            ),
                            Container(
                              height: 300,
                              width: double.infinity,
                              child: Image.network(
                                document['url1'],
                                errorBuilder: (BuildContext context,
                                    Object exception, StackTrace stackTrace) {
                                  return new CircularProgressIndicator();
                                },
                              ),
                            ),
                            new Container(
                              height: 10.0,
                              color: Colors.grey[100],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // SizedBox(
                                  //   width: 5.0,
                                  // ),
                                  Text(
                                    " \u{20B9} " + document['productCost'],
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  //amogh like button

                                  // SizedBox(
                                  //   width: 1.0,
                                  // ),
                                  IconButton(
                                    iconSize: 30,
                                    splashColor: Colors.green[400],
                                    color: Colors.green[400],
                                    onPressed: () async {
                                      setState(() {
                                        newIcon = Icons.favorite_sharp;
                                      });

                                      DocumentSnapshot ds =
                                          await FirebaseFirestore.instance
                                              .collection('users')
                                              .doc(uid)
                                              .get();

                                      List cartIt = ds['wishlistItems'];

                                      if (cartIt.contains(document.id)) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          duration: Duration(seconds: 1),
                                          content: Text(
                                              'Item already added to widhlist !'),
                                          backgroundColor: Colors.redAccent,
                                        ));
                                      } else {
                                        print('pressed');
                                        itemList.add(document.id);
                                        FirebaseFirestore.instance
                                            .collection('users')
                                            .doc(uid)
                                            .update({
                                          'wishlistItems':
                                              FieldValue.arrayUnion(itemList)
                                        });

                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          duration: Duration(seconds: 1),
                                          content:
                                              Text('Item added to wishlist !'),
                                          backgroundColor: Colors.redAccent,
                                        ));
                                      }
                                    },
                                    icon:
                                        Icon(newIcon, color: Colors.redAccent),
                                    //label: Text("Add To WishList"),
                                  ),

                                  //amogh like button
                                ],
                              ),
                            ),
                            new Container(
                              height: 10.0,
                              color: Colors.grey[100],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text(
                                    'Rating: ',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    document['averageRating'],
                                    style: TextStyle(
                                        backgroundColor: Colors.amber,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text(
                                    'Delivered in 15 to 20 days',
                                    style: TextStyle(color: Colors.blue),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 5.0,
                                  ),
                                  Text(
                                    '\Product Description: ',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        document['productDescription'],
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w300),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            new Container(
                              height: 10.0,
                              color: Colors.grey[100],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 5.0,
                                  ),
                                  Text(
                                    'Product Categorie: ',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                  Text(
                                    document['productCategorie'],
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 5.0,
                                  ),
                                  Text(
                                    'Items remaning: ',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                  Text(
                                    document['productQuantity'],
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 5.0,
                                  ),
                                  Text(
                                    'seller Name: ',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                  Text(
                                    document['sellerName'],
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ],
                              ),
                            ),
                            new Container(
                              height: 10.0,
                              color: Colors.grey[100],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 5.0,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 12.0),
                                    child: Text(
                                      'Products natural elements: ',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ),
                                  MaterialButton(
                                    onPressed: () {
                                      print('pressed');
                                      Navigator.push(
                                          context,
                                          PageTransition(
                                              child: NaturalResource(
                                                url: document['url2'],
                                                naturalResorce: document[
                                                    'naturalResourceI'],
                                                elementsOfProduct: document[
                                                    'elementsOfProduct'],
                                              ),
                                              type: PageTransitionType
                                                  .leftToRight));
                                    },
                                    child: Text(
                                      "Read more",
                                      style: TextStyle(
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            new Container(
                              height: 10.0,
                              color: Colors.grey[100],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: FlatButton.icon(
                                    splashColor: Colors.redAccent,
                                    height: 50,
                                    color: Colors.green[400],
                                    onPressed: () async {
                                      // print('pressed');
                                      // print(document.id);

                                      DocumentSnapshot ds =
                                          await FirebaseFirestore.instance
                                              .collection('users')
                                              .doc(uid)
                                              .get();

                                      int dbCartCost = ds['cartTotalCost'];
                                      List cartIt = ds['cartItems'];

                                      if (cartIt.contains(document.id)) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          duration: Duration(seconds: 1),
                                          content: Text(
                                              'Item already added to cart !'),
                                          backgroundColor: Colors.redAccent,
                                        ));
                                      } else {
                                        cost +=
                                            int.parse(document['productCost']);
                                        cartList.add(document.id);
                                        FirebaseFirestore.instance
                                            .collection('users')
                                            .doc(uid)
                                            .update({
                                          'cartItems':
                                              FieldValue.arrayUnion(cartList),
                                          'cartTotalCost': cost + dbCartCost
                                        });

                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          duration: Duration(seconds: 1),
                                          content: Text('Item added to cart !'),
                                          backgroundColor: Colors.redAccent,
                                        ));
                                      }
                                      //cost

                                      //cost

                                      //imp code by amogh to place order pass the product id to class
                                      // Navigator.push(
                                      //     context,
                                      //     PageTransition(
                                      //         child: PlaceOrder(
                                      //           productId: document.id,
                                      //         ),
                                      //         type: PageTransitionType
                                      //             .leftToRight));
                                    },
                                    icon: Icon(Icons.add_shopping_cart,
                                        color: Colors.white),
                                    label: Text(
                                      "Add To Cart",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: FlatButton.icon(
                                      icon: Icon(Icons.book_online,
                                          color: Colors.white),
                                      label: Text(
                                        "Place order",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      splashColor: Colors.redAccent,
                                      height: 50,
                                      color: Colors.green[400],
                                      onPressed: () async {
                                        // print('pressed');
                                        print(document.id);

                                        DocumentSnapshot ds =
                                            await FirebaseFirestore.instance
                                                .collection('users')
                                                .doc(uid)
                                                .get();

                                        if (!itemToForward
                                            .contains(document.id)) {
                                          itemToForward.add(document.id);
                                        }

                                        //int dbCartCost = ds['cartTotalCost'];

                                        // Navigator.push(
                                        //     context,
                                        //     PageTransition(
                                        //         child: PlaceOrder(
                                        //           productId: document.id,
                                        //         ),
                                        //         type: PageTransitionType
                                        //             .leftToRight));

                                        Navigator.push(
                                                context,
                                                PageTransition(
                                                    child: Billing(
                                                      tCost: int.parse(document[
                                                          'productCost']),
                                                      itemsToOrder:
                                                          itemToForward,
                                                    ),
                                                    type: PageTransitionType
                                                        .leftToRight))
                                            .whenComplete(
                                                () => itemToForward.clear());
                                      }),
                                ),
                              ],
                            ),
                          ],
                        );
                      }).toList(),
                    );
                }
              },
            ),
          ),
        ],
      ),
    );
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
            color: Colors.black,
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
                        child: MyCart(), type: PageTransitionType.fade));
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
}
