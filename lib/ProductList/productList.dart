import 'package:adminpanel_gt/home.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductList extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
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
        stream: FirebaseFirestore.instance.collection('products').snapshots(),
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
                              child: Image.network(
                                document['url1'],
                                errorBuilder: (BuildContext context,
                                    Object exception, StackTrace stackTrace) {
                                  return new CircularProgressIndicator();
                                },
                              ),
                            ),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(document['productName']),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 26.0, right: 4.0),
                                      child: Text('\u{20B9}'),
                                    ),
                                    Text(document['productCost'])
                                  ],
                                ),
                              ],
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      Icons.delete_forever_outlined,
                                      color: Colors.red,
                                    ),
                                    onPressed: () {
                                      FirebaseFirestore.instance
                                          .collection('products')
                                          .doc(document.id)
                                          .delete();
                                    },
                                  )
                                ],
                              ),
                            ),
                            trailing: Text(
                              document['averageRating'],
                              style: TextStyle(
                                  backgroundColor: Colors.amber,
                                  fontWeight: FontWeight.bold),
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
    );
  }
}
