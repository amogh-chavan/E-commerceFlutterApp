import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zerowaste/views/HomeComponents/ProductDetails/details_screen.dart';

class ItemCard extends StatelessWidget {
  final String cate;
  const ItemCard({Key key, this.cate}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('products')
            .where('productCategorie', isEqualTo: cate)
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
                    child: Card(
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
                        subtitle: Text(document['productDescription']),
                        trailing: Text(
                          document['averageRating'],
                          style: TextStyle(
                              backgroundColor: Colors.amber,
                              fontWeight: FontWeight.bold),
                        ),
                        isThreeLine: true,
                      ),
                    ),
                  );
                }).toList(),
              );
          }
        },
      ),
    );
  }
}
