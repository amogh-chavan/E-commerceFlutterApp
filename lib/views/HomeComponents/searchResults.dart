// import 'package:flutter/material.dart';

// class searchResults extends StatefulWidget {
//   final tempSearchStore;

//   const searchResults({
//     Key key,
//     @required this.tempSearchStore,
//   }) : super(key: key);

//   @override
//   _searchResultsState createState() => _searchResultsState();
// }

// class _searchResultsState extends State<searchResults> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: GridView.count(
//             padding: EdgeInsets.only(left: 10.0, right: 10.0),
//             crossAxisCount: 2,
//             crossAxisSpacing: 4.0,
//             mainAxisSpacing: 4.0,
//             primary: false,
//             shrinkWrap: true,
//             children: widget.tempSearchStore.map((element) {
//               return buildResultCard(element);
//             }).toList()),
//       ),
//     );
//   }
// }

// Widget buildResultCard(data) {
//   return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
//       elevation: 2.0,
//       child: Container(
//           child: Center(
//               child: Text(
//         data['businessName'],
//         textAlign: TextAlign.center,
//         style: TextStyle(
//           color: Colors.black,
//           fontSize: 20.0,
//         ),
//       ))));
// }
