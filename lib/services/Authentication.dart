import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
//import 'package:apple_sign_in/apple_sign_in.dart';
import 'package:zerowaste/models/user.dart' as U;
import 'package:zerowaste/models/userSetUp.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zerowaste/views/HomeComponents/sidebar/sidebar.dart';
import 'package:zerowaste/views/HomeComponents/sidebar/sidebar_layout.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Stream<String> get onAuthStateChanged => _firebaseAuth.authStateChanges().map(
        (User user) => user?.uid,
      );

  // GET UID
  Future<String> getCurrentUID() async {
    return (_firebaseAuth.currentUser).uid;
  }

  // GET CURRENT USER
  Future getCurrentUser() async {
    return _firebaseAuth.currentUser;
  }

  //amogh added method1
  //@override
  Future<String> currentUser() async {
    final User user = await _firebaseAuth.currentUser;
    return user?.uid;
  }

  //amogh added method2 to check email is verified or not

  // Future<bool> isUserEmailVerified() async {
  //   final User useremail = await _firebaseAuth.currentUser;
  //   return useremail?.emailVerified;
  // }

  // Email & Password Sign Up
  Future<String> createUserWithEmailAndPassword(
      String email, String password, String name) async {
    final authResult = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    // Update the username
    await updateUserName(name, authResult.user);
    return authResult.user.uid;
  }

  Future updateUserName(String name, User currentUser) async {
    await currentUser.updateProfile(displayName: name);
    await currentUser.reload();
  }

  // Email & Password Sign In
  Future<String> signInWithEmailAndPassword(
      String email, String password) async {
    return (await _firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password))
        .user
        .uid;

    // try {
    //   UserCredential userCredential = await FirebaseAuth.instance
    //       .signInWithEmailAndPassword(email: emaill, password: passwordd);
    // } on FirebaseAuthException catch (e) {
    //   if (e.code == 'user-not-found') {
    //     print('No user found for that email.');
    //   } else if (e.code == 'wrong-password') {
    //     print('Wrong password provided for that user.');
    //   }
    // }
  }

//amogh

  // instead of returning true or false
// returning user to directly access UserID
// Future<User> signin(
//     String email, String password, BuildContext context) async {
//   try {
//     UserCredential userCredential =
//         await _firebaseAuth.signInWithEmailAndPassword(email: email, password: email);
//     User user = userCredential.user;
//     // return Future.value(true);
//     return Future.value(user);
//   } catch (e) {
//     // simply passing error code as a message
//     print(e.code);
//     switch (e.code) {
//       case 'ERROR_INVALID_EMAIL':
//         //showErrDialog(context, e.code);

//         break;
//       case 'ERROR_WRONG_PASSWORD':
//         showErrDialog(context, e.code);
//         break;
//       case 'ERROR_USER_NOT_FOUND':
//         showErrDialog(context, e.code);
//         break;
//       case 'ERROR_USER_DISABLED':
//         showErrDialog(context, e.code);
//         break;
//       case 'ERROR_TOO_MANY_REQUESTS':
//         showErrDialog(context, e.code);
//         break;
//       case 'ERROR_OPERATION_NOT_ALLOWED':
//         showErrDialog(context, e.code);
//         break;
//     }
//     // since we are not actually continuing after displaying errors
//     // the false value will not be returned
//     // hence we don't have to check the valur returned in from the signin function
//     // whenever we call it anywhere
//     return Future.value(null);
//   }
// }

  // Sign Out
  signOut() async {
    return await _firebaseAuth.signOut();
  }

  // Reset Password
  Future sendPasswordResetEmail(String email) async {
    return _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  // Create Anonymous User
  Future singInAnonymously() {
    return _firebaseAuth.signInAnonymously();
  }

  Future convertUserWithEmail(
      String email, String password, String name) async {
    final currentUser = _firebaseAuth.currentUser;

    final credential =
        EmailAuthProvider.credential(email: email, password: password);
    await currentUser.linkWithCredential(credential);
    await updateUserName(name, currentUser);
  }

  Future convertWithGoogle() async {
    final currentUser = _firebaseAuth.currentUser;
    final GoogleSignInAccount account = await _googleSignIn.signIn();
    final GoogleSignInAuthentication _googleAuth = await account.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      idToken: _googleAuth.idToken,
      accessToken: _googleAuth.accessToken,
    );
    await currentUser.linkWithCredential(credential);
    await updateUserName(_googleSignIn.currentUser.displayName, currentUser);
  }

  // GOOGLE

  Future<User> signInWithGoogle(context) async {
    final GoogleSignInAccount account = await _googleSignIn.signIn();
    final GoogleSignInAuthentication authentication =
        await account.authentication;

    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
        idToken: authentication.idToken,
        accessToken: authentication.accessToken);

    final UserCredential authResult =
        await _firebaseAuth.signInWithCredential(credential);
    final User user = authResult.user;

    //U.User(uid: user.uid, email: user.email, fullName: user.displayName);

    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser.uid.toString();
    FirebaseFirestore.instance.collection('users').doc(uid).update({
      'emailVerified': true,
    }).catchError((e) {
      print(e);
      userSetUp(
          name: user.displayName,
          email: user.email,
          emailVerified: true,
          contactNo: user.phoneNumber,
          phoneVerified: false,
          cartTotalCost: 0,
          cartItems: [],
          wishlistItems: [],
          orderItems: [],
          previousItems: []);
    });

    if (user.uid != null) {
      Navigator.of(context).pushReplacementNamed('/SideBarLayout');
    }

    return user;
  }

  // APPLE
  // Future signInWithApple() async {
  //   final AuthorizationResult result = await AppleSignIn.performRequests([
  //     AppleIdRequest(requestedScopes: [Scope.email, Scope.fullName])
  //   ]);

  //   switch (result.status) {
  //     case AuthorizationStatus.authorized:
  //       final AppleIdCredential _auth = result.credential;
  //       final OAuthProvider oAuthProvider = new OAuthProvider("apple.com");

  //       final AuthCredential credential = oAuthProvider.credential(
  //         idToken: String.fromCharCodes(_auth.identityToken),
  //         accessToken: String.fromCharCodes(_auth.authorizationCode),
  //       );

  //       await _firebaseAuth.signInWithCredential(credential);

  //       // update the user information
  //       if (_auth.fullName != null) {
  //         await _firebaseAuth.currentUser.updateProfile(
  //             displayName:
  //                 "${_auth.fullName.givenName} ${_auth.fullName.familyName}");
  //       }

  //       break;

  //     case AuthorizationStatus.error:
  //       print("Sign In Failed ${result.error.localizedDescription}");
  //       break;

  //     case AuthorizationStatus.cancelled:
  //       print("User Cancled");
  //       break;
  //   }
  // }

  // Future createUserWithPhone(String phone, BuildContext context) async {
  //   _firebaseAuth.verifyPhoneNumber(
  //       phoneNumber: phone,
  //       timeout: Duration(seconds: 0),
  //       verificationCompleted: (AuthCredential authCredential) {
  //         _firebaseAuth
  //             .signInWithCredential(authCredential)
  //             .then((UserCredential result) {
  //           Navigator.of(context).pop(); // to pop the dialog box
  //           Navigator.of(context).pushReplacementNamed('/home');
  //         }).catchError((e) {
  //           return "error";
  //         });
  //       },
  //       verificationFailed: (FirebaseAuthException exception) {
  //         return "error";
  //       },
  //       codeSent: (String verificationId, [int forceResendingToken]) {
  //         final _codeController = TextEditingController();
  //         showDialog(
  //           context: context,
  //           barrierDismissible: false,
  //           builder: (context) => AlertDialog(
  //             title: Text("Enter Verification Code From Text Message"),
  //             content: Column(
  //               mainAxisSize: MainAxisSize.min,
  //               children: <Widget>[TextField(controller: _codeController)],
  //             ),
  //             actions: <Widget>[
  //               FlatButton(
  //                 child: Text("submit"),
  //                 textColor: Colors.white,
  //                 color: Colors.green,
  //                 onPressed: () {
  //                   var _credential = PhoneAuthProvider.credential(
  //                       verificationId: verificationId,
  //                       smsCode: _codeController.text.trim());
  //                   _firebaseAuth
  //                       .signInWithCredential(_credential)
  //                       .then((UserCredential result) {
  //                     Navigator.of(context).pop(); // to pop the dialog box
  //                     Navigator.of(context).pushReplacementNamed('/home');
  //                   }).catchError((e) {
  //                     return "error";
  //                   });
  //                 },
  //               )
  //             ],
  //           ),
  //         );
  //       },
  //       codeAutoRetrievalTimeout: (String verificationId) {
  //         verificationId = verificationId;
  //       });
  // }
}
