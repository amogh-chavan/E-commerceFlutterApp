import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddProducts extends StatefulWidget {
  @override
  _AddProductsState createState() => _AddProductsState();
}

class _AddProductsState extends State<AddProducts> {
  TextEditingController addController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController costController = TextEditingController();
  TextEditingController sellerController = TextEditingController();
  TextEditingController sellerAddController = TextEditingController();
  TextEditingController sellerContactController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController averageRatingController = TextEditingController();
  TextEditingController naturalResourceController = TextEditingController();
  TextEditingController elementsOfProductController = TextEditingController();
  TextEditingController url1 = TextEditingController();
  TextEditingController url2 = TextEditingController();

  List<ListItem> _dropdownItems = [
    ListItem(1, "Men"),
    ListItem(2, "Women"),
    ListItem(3, "Furniture"),
    ListItem(4, "Others"),
    ListItem(5, "Essential"),
  ];

  List<DropdownMenuItem<ListItem>> _dropdownMenuItems;
  ListItem _selectedItem;
  String StrSelectedItem = 'Others';

  void initState() {
    super.initState();
    _dropdownMenuItems = buildDropDownMenuItems(_dropdownItems);
    _selectedItem = _dropdownMenuItems[0].value;
  }

  List<DropdownMenuItem<ListItem>> buildDropDownMenuItems(List listItems) {
    List<DropdownMenuItem<ListItem>> items = List();
    for (ListItem listItem in listItems) {
      items.add(
        DropdownMenuItem(
          child: Text(listItem.name),
          value: listItem,
        ),
      );
    }
    return items;
  }

  final database = FirebaseFirestore.instance;

  @override
  void dispose() {
    addController.dispose();
    descriptionController.dispose();
    costController.dispose();
    sellerController.dispose();
    sellerAddController.dispose();
    sellerContactController.dispose();
    quantityController.dispose();
    averageRatingController.dispose();
    naturalResourceController.dispose();
    elementsOfProductController.dispose();
    url1.dispose();
    url2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    uploadData(
        String name,
        String description,
        String cost,
        String seller,
        String sellerAdd,
        String sellerContact,
        String quantity,
        String averageRating,
        String productCategorie,
        String naturalResource,
        String elementsOfProduct,
        String url1,
        String url2) {
      List<String> splitList = name.split(' ');
      List<String> indexList = [];

      for (int i = 0; i < splitList.length; i++) {
        for (int j = 0; j < splitList[i].length; j++) {
          indexList.add(splitList[i].substring(0, j).toLowerCase());
        }
      }

      database.collection('products').add({
        'productName': name,
        'searchIndex': indexList,
        'productDescription': description,
        'productCost': cost,
        'sellerName': seller,
        'sellerAddress': sellerAdd,
        'sellerContact': sellerContact,
        'productQuantity': quantity,
        'averageRating': averageRating,
        'productCategorie': productCategorie,
        'naturalResourceInfo': naturalResource,
        'elementsOfProduct': elementsOfProduct,
        'url1': url1,
        'url2': url2
      });
    }

    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(builder: (context) => AddImage()),
      //     );
      //   },
      //   child: Icon(Icons.add_a_photo),
      // ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      'Add Prdoucts',
                      style: TextStyle(fontSize: 20, color: Colors.green),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Divider(
                thickness: 5,
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextField(
                  controller: addController,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () => addController.clear(),
                    ),
                    hintText: 'Product Name',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () => descriptionController.clear(),
                    ),
                    hintText: 'Product Description (4 to 6 lines)',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextField(
                  controller: costController,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(Icons.money),
                      onPressed: () => costController.clear(),
                    ),
                    hintText: 'Cost of product',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextField(
                  controller: sellerController,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(Icons.emoji_emotions),
                      onPressed: () => sellerController.clear(),
                    ),
                    hintText: 'Seller',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextField(
                  controller: sellerAddController,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(Icons.pin_drop),
                      onPressed: () => sellerAddController.clear(),
                    ),
                    hintText: 'Seller address',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextField(
                  controller: sellerContactController,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(Icons.phone),
                      onPressed: () => sellerContactController.clear(),
                    ),
                    hintText: 'Seller contact information',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextField(
                  controller: quantityController,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(Icons.shopping_cart_rounded),
                      onPressed: () => quantityController.clear(),
                    ),
                    hintText: 'Quantity',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextField(
                  controller: averageRatingController,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(Icons.star),
                      onPressed: () => averageRatingController.clear(),
                    ),
                    hintText: 'Average rating',
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextField(
                  controller: naturalResourceController,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(Icons.nature),
                      onPressed: () => naturalResourceController.clear(),
                    ),
                    hintText: 'Natural resource info',
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextField(
                  controller: elementsOfProductController,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(Icons.analytics),
                      onPressed: () => elementsOfProductController.clear(),
                    ),
                    hintText: 'Elements of product',
                  ),
                ),
              ),

              //amogh
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextField(
                  controller: url1,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(Icons.link),
                      onPressed: () => url1.clear(),
                    ),
                    hintText: 'product image URL 1',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextField(
                  controller: url2,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(Icons.link),
                      onPressed: () => url2.clear(),
                    ),
                    hintText: 'Product image URL 2',
                  ),
                ),
              ),
              //amogh
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    Text(
                      'Select Categorie: ',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    DropdownButton<ListItem>(
                        value: _selectedItem,
                        items: _dropdownMenuItems,
                        onChanged: (value) {
                          setState(() {
                            _selectedItem = value;
                            // print(_selectedItem.value);
                            switch (_selectedItem.value) {
                              case 1:
                                this.StrSelectedItem = 'Men';
                                break;
                              case 2:
                                this.StrSelectedItem = 'Women';
                                break;
                              case 3:
                                this.StrSelectedItem = 'Furniture';
                                break;
                              case 4:
                                this.StrSelectedItem = 'Others';
                                break;

                              case 5:
                                this.StrSelectedItem = 'Essential';

                                break;
                              default:
                                this.StrSelectedItem = 'Others';
                            }
                            //this.StrSelectedItem = _selectedItem.toString();
                            //print(StrSelectedItem);
                          });
                        }),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Builder(
                builder: (context) => Center(
                  child: MaterialButton(
                    color: Colors.green,
                    child: Text('Submit'),
                    onPressed: () async {
                      if (addController.text.isEmpty ||
                          descriptionController.text.isEmpty ||
                          costController.text.isEmpty ||
                          sellerController.text.isEmpty ||
                          sellerAddController.text.isEmpty ||
                          sellerContactController.text.isEmpty ||
                          quantityController.text.isEmpty ||
                          averageRatingController.text.isEmpty ||
                          naturalResourceController.text.isEmpty ||
                          elementsOfProductController.text.isEmpty ||
                          url1.text.isEmpty ||
                          url2.text.isEmpty ||
                          this.StrSelectedItem.isEmpty) {
                        Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text("Please enter all fields"),
                          duration: Duration(seconds: 3),
                        ));
                      } else {
                        uploadData(
                          addController.text,
                          descriptionController.text,
                          costController.text,
                          sellerController.text,
                          sellerAddController.text,
                          sellerContactController.text,
                          quantityController.text,
                          averageRatingController.text,
                          this.StrSelectedItem,
                          naturalResourceController.text,
                          elementsOfProductController.text,
                          url1.text,
                          url2.text,
                        );

                        addController.clear();
                        descriptionController.clear();
                        costController.clear();
                        sellerController.clear();
                        sellerAddController.clear();
                        sellerContactController.clear();
                        quantityController.clear();
                        averageRatingController.clear();
                        naturalResourceController.clear();
                        elementsOfProductController.clear();
                        url1.clear();
                        url2.clear();

                        Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text("Product uploaded to database"),
                          duration: Duration(seconds: 5),
                        ));
                      }
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ListItem {
  int value;
  String name;

  ListItem(this.value, this.name);
}
