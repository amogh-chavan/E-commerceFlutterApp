import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geocoding/geocoding.dart' as geoCo;
import 'package:zerowaste/models/user.dart' as U;

Future<void> userSetUp(
    {String name,
    String email,
    String address,
    String contactNo,
    int cartTotalCost,
    List<String> cartItems,
    List<String> wishlistItems,
    List<String> orderItems,
    List<String> previousItems,
    bool emailVerified,
    bool phoneVerified}) async {
  U.User(fullName: name);
  FirebaseAuth auth = FirebaseAuth.instance;
  String uid = auth.currentUser.uid.toString();
  //CollectionReference usersCol =
  FirebaseFirestore.instance.collection('users').doc(uid).set(

      //usersCol.add
      {
        'name': name,
        'uid': uid,
        'email': email,
        'address': address,
        'contactNo': contactNo,
        'cartItems': cartItems,
        'wishlistItems': wishlistItems,
        'orderItems': orderItems,
        'previousItems': previousItems,
        'emailVerified': emailVerified,
        'phoneVerified': phoneVerified,
        'cartTotalCost': cartTotalCost
      });
}
