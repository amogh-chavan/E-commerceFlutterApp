// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:zerowaste/views/HomeComponents/ProductDetails/details_screen.dart';
import 'package:zerowaste/views/HomeComponents/Result/item_card.dart';

import 'package:zerowaste/views/HomeComponents/categories.dart';

// Future<void> catResult(
//     {String productCategorie}) async {

//   FirebaseAuth auth = FirebaseAuth.instance;
//   String uid = auth.currentUser.uid.toString();
//   //CollectionReference usersCol =
//   FirebaseFirestore.instance.collection('products').doc(uid).set(

//       //usersCol.add
//       {
//         'productCategorie': productCategorie,
//       });
// }
const kDefaultPaddin = 20.0;

class CategoriesResult extends StatefulWidget {
  final String cat;
  const CategoriesResult({Key key, this.cat}) : super(key: key);

  @override
  _CategoriesResultState createState() => _CategoriesResultState(cat);
}

class _CategoriesResultState extends State<CategoriesResult> {
  String cat;
  _CategoriesResultState(this.cat);

  //CollectionReference
  // Query prod = FirebaseFirestore.instance
  //     .collection('products')
  //     .where('productCategorie', isEqualTo: CategoriesResult().cat);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 18.0),
                  child: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.of(context)
                          .pushReplacementNamed('/SideBarLayout');
                    },
                  ),
                ),
                Text(
                  cat,
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Categories(),
          ),
          ItemCard(
            cate: cat,
          ),

          // Expanded(
          //   child: StreamBuilder<QuerySnapshot>(
          //     stream: FirebaseFirestore.instance
          //         .collection('products')
          //         .where('productCategorie', isEqualTo: cat)
          //         .snapshots(),
          //     builder: (context, snapshot) {
          //       if (snapshot.hasError) {
          //         return Text(' error : ${snapshot.error} ');
          //       }
          //       switch (snapshot.connectionState) {
          //         case ConnectionState.waiting:
          //           return SizedBox(
          //             child: Center(
          //               child: CircularProgressIndicator(
          //                 backgroundColor: Colors.green,
          //               ),
          //             ),
          //           );
          //         case ConnectionState.none:
          //           return Text('No results found');
          //         case ConnectionState.done:
          //           return Text('connection done');

          //         default:
          //           return new ListView(
          //             children:
          //                 snapshot.data.docs.map((DocumentSnapshot document) {
          //               return GestureDetector(
          //                 onTap: () {
          //                   print('clicked');
          //                   print(document['productName']);
          //                   Navigator.push(
          //                       context,
          //                       MaterialPageRoute(
          //                           builder: (context) => DetailsScreen(
          //                                 product: document['productName'],
          //                               )));
          //                 },
          //                 child: Card(
          //                   child: ListTile(
          //                     leading: SizedBox(
          //                       width: 100,
          //                       height: 100,
          //                       child: Image.network(
          //                         document['url1'],
          //                         errorBuilder: (BuildContext context,
          //                             Object exception, StackTrace stackTrace) {
          //                           return new CircularProgressIndicator();
          //                         },
          //                       ),
          //                     ),
          //                     title: Column(
          //                       crossAxisAlignment: CrossAxisAlignment.start,
          //                       mainAxisAlignment: MainAxisAlignment.start,
          //                       children: [
          //                         Text(document['productName']),
          //                         Row(
          //                           children: [
          //                             Padding(
          //                               padding: const EdgeInsets.only(
          //                                   left: 26.0, right: 4.0),
          //                               child: Text('\u{20B9}'),
          //                             ),
          //                             Text(document['productCost'])
          //                           ],
          //                         ),
          //                       ],
          //                     ),
          //                     subtitle: Text(document['productDescription']),
          //                     trailing: Text(
          //                       document['averageRating'],
          //                       style: TextStyle(
          //                           backgroundColor: Colors.amber,
          //                           fontWeight: FontWeight.bold),
          //                     ),
          //                     isThreeLine: true,
          //                   ),
          //                 ),
          //               );
          //             }).toList(),
          //           );
          //       }
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}
