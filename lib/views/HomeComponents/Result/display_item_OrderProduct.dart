import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:zerowaste/views/HomeComponents/ProductDetails/details_screen.dart';

class DisplayOrderItems extends StatefulWidget {
  final String pid;
  const DisplayOrderItems({Key key, this.pid}) : super(key: key);

  @override
  _DisplayOrderItemsState createState() => _DisplayOrderItemsState();
}

class _DisplayOrderItemsState extends State<DisplayOrderItems> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('products')
          .where('uid', isEqualTo: widget.pid)
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
              child: new Column(
                children: snapshot.data.docs.map((DocumentSnapshot document) {
                  return GestureDetector(
                    onTap: () {
                      print('clicked');
                      print(document['productName']);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailsScreen(
                                    product: document['productName'],
                                  )));
                    },
                    child: Column(
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
                            // subtitle: Text(document['productDescription']),
                            subtitle: Text(''),
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
                    ),
                  );
                }).toList(),
              ),
            );
        }
      },
    );
  }
}
