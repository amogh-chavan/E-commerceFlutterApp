import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OfferBanner extends StatefulWidget {
  // const OfferBanner({
  //   Key key,
  // }) : super(key: key);

  @override
  _OfferBannerState createState() => _OfferBannerState();
}

class _OfferBannerState extends State<OfferBanner> {
  Card displayHomeAdvertisementBanner(String imgName) {
    return Card(
      elevation: 0,
      child: Container(
        color: Colors.white,
        child: FutureBuilder(
          future: _getImage(context, imgName),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return FittedBox(
                fit: BoxFit.contain,
                child: Container(
                  //color: Colors.grey,
                  //width: 300,
                  //height: 100,
                  child: snapshot.data,
                ),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Padding(
                padding: const EdgeInsets.all(120.0),
                child: Container(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }

  // Reference to a document with id "alovelace" in the collection "users"
//DocumentReference document = db.collection("users").document("alovelace");

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.amber,
      padding: EdgeInsets.symmetric(horizontal: 0),
      height: 160,

      width: double.infinity,
      child: displayHomeAdvertisementBanner("offerBanner.png"),
    );
  }
}

Future<Widget> _getImage(BuildContext context, String imageName) async {
  Image image;
  await FireStorageService.loadImage(context, imageName).then((value) {
    image = Image.network(
      value.toString(),
      fit: BoxFit.scaleDown,
    );
  });
  return image;
}

class FireStorageService extends ChangeNotifier {
  FireStorageService();
  static Future<dynamic> loadImage(BuildContext context, String image) async {
    return await FirebaseStorage.instance
        .ref('HomeAdvertisementBanner')
        .child(image)
        .getDownloadURL();
  }
}

class NaviForAdd {
  final CollectionReference navs =
      FirebaseFirestore.instance.collection("advertismentBannerNavigations");

  Future getNavs() async {
    try {
      // final data = await navs.where();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
