import 'dart:ui';

import 'package:adminpanel_gt/OrderToHandel/orderToHandel.dart';
import 'package:adminpanel_gt/ProductList/productList.dart';
import 'package:adminpanel_gt/ReturnedOrders/ReturnedOrder.dart';
import 'package:adminpanel_gt/getValues/orderCount.dart';
import 'package:adminpanel_gt/getValues/productsCount.dart';
import 'package:adminpanel_gt/getValues/userCount.dart';
import 'package:adminpanel_gt/manageCategories/addProducts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

enum Page { dashboard, manage }

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Page _selectedPage = Page.dashboard;
  MaterialColor active = Colors.red;
  MaterialColor notActive = Colors.grey;
  TextEditingController categoryController = TextEditingController();
  TextEditingController brandController = TextEditingController();
  GlobalKey<FormState> _categoryFormKey = GlobalKey();
  GlobalKey<FormState> _brandFormKey = GlobalKey();

  Future<String> signInWithEmailAndPassword(
      String email, String password) async {
    return (await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password))
        .user
        .uid;
  }

  Stream<QuerySnapshot> ds =
      FirebaseFirestore.instance.collection('users').snapshots();

  @override
  void initState() {
    signInWithEmailAndPassword(
        'TheAdmin@GreenTrends.com', 'Theageofaibegins@9');

    print(ds.length);
    super.initState();
  }

  //BrandService _brandService = BrandService();
  //CategoryService _categoryService = CategoryService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: <Widget>[
              Expanded(
                  child: FlatButton.icon(
                      onPressed: () {
                        setState(() => _selectedPage = Page.dashboard);
                      },
                      icon: Icon(
                        Icons.dashboard,
                        color: _selectedPage == Page.dashboard
                            ? active
                            : notActive,
                      ),
                      label: Text('Dashboard'))),
              Expanded(
                  child: FlatButton.icon(
                      onPressed: () {
                        setState(() => _selectedPage = Page.manage);
                      },
                      icon: Icon(
                        Icons.sort,
                        color:
                            _selectedPage == Page.manage ? active : notActive,
                      ),
                      label: Text('Manage'))),
            ],
          ),
          elevation: 0.0,
          backgroundColor: Colors.white,
        ),
        body: _loadScreen());
  }

  Widget _loadScreen() {
    switch (_selectedPage) {
      case Page.dashboard:
        return Column(
          children: <Widget>[
            ListTile(
              subtitle: Text("Rs " + '12,000',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 30.0, color: Colors.green)),
              title: Text(
                'Revenue',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24.0, color: Colors.grey),
              ),
            ),
            Expanded(
              child: GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Card(
                      child: ListTile(
                          title: FlatButton.icon(
                              onPressed: null,
                              icon: Icon(Icons.people_outline),
                              label: Text("Users")),
                          subtitle: UserCount()),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Card(
                      child: ListTile(
                          title: FlatButton.icon(
                              onPressed: null,
                              icon: Icon(Icons.category),
                              label: Text("Categories")),
                          subtitle: Text(
                            '6',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: active, fontSize: 60.0),
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Card(
                      child: ListTile(
                          title: FlatButton.icon(
                              onPressed: null,
                              icon: Icon(Icons.track_changes),
                              label: Text("Producs")),
                          subtitle: ProductCount()),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Card(
                      child: ListTile(
                          title: FlatButton.icon(
                              onPressed: null,
                              icon: Icon(Icons.tag_faces),
                              label: Text("Sold")),
                          subtitle: OrderCount()),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Card(
                      child: ListTile(
                          title: FlatButton.icon(
                              onPressed: null,
                              icon: Icon(Icons.shopping_cart),
                              label: Text("Orders")),
                          subtitle: OrderCount()),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Card(
                      child: ListTile(
                          title: FlatButton.icon(
                              onPressed: null,
                              icon: Icon(Icons.close),
                              label: Text("Return")),
                          subtitle: Text(
                            '0',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: active, fontSize: 60.0),
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
        break;
      case Page.manage:
        return ListView(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.add),
              title: Text("Add product"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddProducts(),
                    ));
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.change_history,
                color: Colors.blue,
              ),
              title: Text(
                "Products list",
                style: TextStyle(color: Colors.blue),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductList(),
                    ));
              },
            ),
            // Divider(),
            // ListTile(
            //   leading: Icon(Icons.add_circle),
            //   title: Text("Add category"),
            //   onTap: () {
            //     //  _categoryAlert();
            //   },
            // ),
            // Divider(),
            // ListTile(
            //   leading: Icon(Icons.category),
            //   title: Text("Category list"),
            //   onTap: () {},
            // ),
            // Divider(),
            // ListTile(
            //   leading: Icon(Icons.add_circle_outline),
            //   title: Text("Add brand"),
            //   onTap: () {
            //     //  _brandAlert();
            //   },
            // ),
            Divider(),
            ListTile(
              leading: Icon(Icons.keyboard_return, color: Colors.green),
              title: Text(
                "Returned Orders",
                style: TextStyle(color: Colors.green),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ReturnedOrder(),
                    ));
              },
            ),
            // Divider(),
            // ListTile(
            //   leading: Icon(Icons.library_books),
            //   title: Text("brand list"),
            //   onTap: () {},
            // ),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.library_books,
                color: Colors.red,
              ),
              title: Text(
                "Oders To Handel",
                style: TextStyle(color: Colors.red),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrderToHandel(),
                    ));
              },
            ),
            Divider(),
          ],
        );
        break;
      default:
        return Container();
    }
  }

//   void _categoryAlert() {
//     var alert = new AlertDialog(
//       content: Form(
//         key: _categoryFormKey,
//         child: TextFormField(
//           controller: categoryController,
//           validator: (value) {
//             if (value.isEmpty) {
//               return 'category cannot be empty';
//             }
//           },
//           decoration: InputDecoration(hintText: "add category"),
//         ),
//       ),
//       actions: <Widget>[
//         FlatButton(
//             onPressed: () {
//               if (categoryController.text != null) {
//                 //  _categoryService.createCategory(categoryController.text);
//               }
//               // Fluttertoast.showToast(msg: 'category created');
//               Navigator.pop(context);
//             },
//             child: Text('ADD')),
//         FlatButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             child: Text('CANCEL')),
//       ],
//     );

//     showDialog(context: context, builder: (_) => alert);
//   }

//   void _brandAlert() {
//     var alert = new AlertDialog(
//       content: Form(
//         key: _brandFormKey,
//         child: TextFormField(
//           controller: brandController,
//           validator: (value) {
//             if (value.isEmpty) {
//               return 'category cannot be empty';
//             }
//           },
//           decoration: InputDecoration(hintText: "add brand"),
//         ),
//       ),
//       actions: <Widget>[
//         FlatButton(
//             onPressed: () {
//               if (brandController.text != null) {
//                 // _brandService.createBrand(brandController.text);
//               }
//               // Fluttertoast.showToast(msg: 'brand added');
//               Navigator.pop(context);
//             },
//             child: Text('ADD')),
//         FlatButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             child: Text('CANCEL')),
//       ],
//     );

//     showDialog(context: context, builder: (_) => alert);
//   }
}
