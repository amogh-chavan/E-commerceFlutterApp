import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:zerowaste/views/HomeComponents/ProductDetails/details_screen.dart';

class SearchField extends StatefulWidget {
  @override
  _SearchFieldState createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  String searchString;
  final TextEditingController searchcontroller = TextEditingController();

  @override
  void dispose() {
    searchcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          //Container(
          //   padding: EdgeInsets.symmetric(horizontal: 18),
          //   margin: EdgeInsets.symmetric(horizontal: 18),
          //   width: double.infinity,
          //   height: 400,
          //   decoration: BoxDecoration(
          //       color: Colors.white10,
          //       border: Border.all(color: Colors.black12),
          //       //color: Color(0xffD3D3D3),
          //       //color: Colors.grey,
          //       borderRadius: BorderRadius.circular(30)),
          //   child:
          Column(
        children: <Widget>[
          SizedBox(
            height: 50,
          ),
          Container(
            height: 50,
            child: Padding(
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    searchString = value.toLowerCase();
                  });
                },
                controller: searchcontroller,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.green[100],
                  hintText: "search products",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                  focusedBorder: InputBorder.none,
                  prefixIcon: IconButton(
                    color: Colors.black,
                    icon: Icon(Icons.search),
                    iconSize: 20.0,
                    onPressed: () {
                      Future.delayed(Duration(microseconds: 500), () {
                        //call back after 500  microseconds
                        searchcontroller.clear(); // clear textfield
                      });
                    },
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: (searchString == null || searchString.trim() == '')
                  ? FirebaseFirestore.instance
                      .collection('products')
                      .snapshots()
                  : FirebaseFirestore.instance
                      .collection('products')
                      .where('searchIndex', arrayContains: searchString)
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
                        return GestureDetector(
                          onTap: () {
                            // print('clicked');
                            // print(document['productName']);
                            //
                            Navigator.push(
                                context,
                                PageTransition(
                                    child: DetailsScreen(
                                      product: document['productName'],
                                    ),
                                    type: PageTransitionType.fade));
                          },
                          child: new ListTile(
                            title: Text(document['productName']),
                          ),
                        );
                      }).toList(),
                    );
                }
              },
            ),
          ),
        ],
      ),
      //),
    );
  }
}
