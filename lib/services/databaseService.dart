// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class DatabaseManager {
//    DocumentSnapshot result =
//          FirebaseFirestore.instance.collection('users').doc(uid).get();
//   Future getUsersList() async {
//     List itemsList = [];

//     try {
//       await profile.doc().then((querySnapshot) {
//         querySnapshot.documents.forEach((element) {
//           itemsList.add(element.data);
//         });
//       });
//       return itemsList;
//     } catch (e) {
//       print(e.toString());
//       return null;
//     }
//   }
// }
