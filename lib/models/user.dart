import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String uid;
  final String fullName;
  final String email;
  final String address;
  final String contactNo;
  final List<String> cartItems;
  final List<String> wishlistItems;
  final List<String> orderItems;
  final List<String> previousItems;
  final bool emailVerified;
  final bool phoneVerified;

  User(
      {this.uid,
      this.fullName,
      this.email,
      this.emailVerified,
      this.address,
      this.contactNo,
      this.cartItems,
      this.wishlistItems,
      this.orderItems,
      this.previousItems,
      this.phoneVerified});

  factory User.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data();
    return User(
      uid: doc.id,
      fullName: data["name"] ?? null,
      email: data["email"] ?? null,
      emailVerified: data["emailVerified"] ?? false,
      contactNo: data["contactNo"] ?? null,
      phoneVerified: data["phoneVerified"] ?? false,
    );
  }
  Map<String, dynamic> toMap() {
    return {
      "fullName": fullName,
      "email": email,
      "emailVerified": emailVerified,
      "contactNo": contactNo,
      "phoneVerified": phoneVerified,
    };
  }
}
