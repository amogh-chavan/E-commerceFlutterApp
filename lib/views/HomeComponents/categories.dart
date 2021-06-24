import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:zerowaste/views/HomeComponents/Result/categoriesResult.dart';

class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> categories = [
      {"icon": Image.asset('assets/sale.jpg'), "text": "Offers"},
      {"icon": Image.asset('assets/home.png'), "text": "Furniture"},
      {"icon": Image.asset('assets/essential.jpg'), "text": "Essential"},
      {"icon": Image.asset('assets/man.jpg'), "text": "Men"},
      {"icon": Image.asset('assets/women.jpg'), "text": "Women"},
      {"icon": Image.asset('assets/shopping_bag.png'), "text": "Others"},
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...List.generate(
              categories.length,
              (index) => Card(
                elevation: 0,
                child: CategoryCart(
                    icon: categories[index]["icon"],
                    text: categories[index]["text"],
                    press: () {
                      if (categories[index]["text"] == "Men") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CategoriesResult(
                                    cat: 'Men',
                                  )),
                        );
                      } else if (categories[index]["text"] == "Women") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CategoriesResult(
                                    cat: 'Women',
                                  )),
                        );
                      } else if (categories[index]["text"] == "Others") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CategoriesResult(
                                    cat: 'Others',
                                  )),
                        );
                      } else if (categories[index]["text"] == "Essential") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CategoriesResult(
                                    cat: 'Essential',
                                  )),
                        );
                      } else if (categories[index]["text"] == "Furniture") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CategoriesResult(
                                    cat: 'Furniture',
                                  )),
                        );
                      } else if (categories[index]["text"] == "Offers") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CategoriesResult(
                                    cat: 'Offers',
                                  )),
                        );
                      }
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CategoryCart extends StatelessWidget {
  const CategoryCart({
    Key key,
    @required this.icon,
    @required this.text,
    @required this.press,
  }) : super(key: key);

  //final List<Map<String, dynamic>> categories;
  //final IconData icon;
  final Image icon;
  final String text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: SizedBox(
        width: 72,
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: FittedBox(
                fit: BoxFit.cover,
                child: Container(
                  //2
                  padding: EdgeInsets.all(20),

                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(0),
                      color: Colors.grey[100]),
                  child: icon,
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }
}
