import 'package:flutter/material.dart';
import 'package:zerowaste/bloc_navigation_bloc/navigation_bloc.dart';
import 'package:zerowaste/views/HomeComponents/body.dart';
import 'package:zerowaste/views/HomeComponents/location.dart';
import 'package:zerowaste/views/HomeComponents/sidebar/sidebarComponents/mycart.dart';
import 'package:zerowaste/views/HomeComponents/sidebar/sidebarComponents/myorders.dart';
import 'package:page_transition/page_transition.dart';
import 'package:zerowaste/views/HomeComponents/sidebar/sidebarComponents/wishlist.dart';
import 'package:zerowaste/views/HomeComponents/search.dart';

class Home extends StatefulWidget with NavigationStates {
  const Home({this.onSignedOut});
  final VoidCallback onSignedOut;
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController searchcontroller = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(width: 5),
        title: Text(
          "GreenTrends",
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w300,
              fontFamily: 'Pacifico'),
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              icon: Icon(Icons.location_pin),
              color: Colors.black54,
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
                color: Colors.black54,
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
      ),
      body: Body(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SearchField()),
          );
        },
        child: Icon(Icons.search),
        backgroundColor: Colors.green[400],
      ),
    );
  }
}
