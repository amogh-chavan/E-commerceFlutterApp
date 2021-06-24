import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:zerowaste/views/HomeComponents/location.dart';
import 'package:zerowaste/views/HomeComponents/sidebar/sidebarComponents/mycart.dart';
import 'package:zerowaste/views/HomeComponents/sidebar/sidebarComponents/wishlist.dart';

class NaturalResource extends StatefulWidget {
  final String url;
  final String naturalResorce;
  final String elementsOfProduct;

  const NaturalResource(
      {Key key, this.url, this.naturalResorce, this.elementsOfProduct})
      : super(key: key);

  @override
  _NaturalResourceState createState() => _NaturalResourceState();
}

class _NaturalResourceState extends State<NaturalResource> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          '',
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w300,
              fontFamily: 'Pacifico'),
        ),
        backgroundColor: Colors.green[400],
        elevation: 0.5,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              icon: Icon(Icons.location_pin),
              color: Colors.white,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Location()),
                );
              },
            ),
          ),
          InkWell(
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: IconButton(
                icon: Icon(Icons.shopping_cart_outlined),
                color: Colors.white,
                onPressed: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          child: MyCart(), type: PageTransitionType.fade));
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: IconButton(
              icon: Icon(Icons.favorite),
              color: Colors.pink,
              onPressed: () {
                Navigator.push(
                    context,
                    PageTransition(
                        child: WishList(), type: PageTransitionType.fade));
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 5,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Natural resource of this product',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
                  ),
                ],
              ),
            ),
            new Container(
              height: 10.0,
              color: Colors.grey[100],
            ),
            Container(
              padding: const EdgeInsets.all(20.0),
              height: 300,
              width: double.infinity,
              child: Image.network(
                widget.url,
                errorBuilder: (BuildContext context, Object exception,
                    StackTrace stackTrace) {
                  return new CircularProgressIndicator();
                },
              ),
            ),
            new Container(
              height: 10.0,
              color: Colors.grey[100],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 5.0,
                  ),
                  Text(
                    '\Natural Resource information: ',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        widget.naturalResorce,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            new Container(
              height: 10.0,
              color: Colors.grey[100],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 5.0,
                  ),
                  Text(
                    '\Natural elements used in this product: ',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        widget.elementsOfProduct,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check_circle,
                    color: Colors.green,
                  ),
                  Text(
                    'Recyclable',
                    style: TextStyle(
                        color: Colors.green, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
