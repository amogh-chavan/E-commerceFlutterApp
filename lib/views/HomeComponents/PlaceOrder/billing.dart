import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:zerowaste/views/HomeComponents/PlaceOrder/placeOrder.dart';
import 'package:zerowaste/views/HomeComponents/sidebar/sidebarComponents/mycart.dart';

class Billing extends StatefulWidget {
  final int tCost;
  final List itemsToOrder;
  const Billing({Key key, this.tCost, this.itemsToOrder}) : super(key: key);

  @override
  _BillingState createState() => _BillingState();
}

class _BillingState extends State<Billing> {
  int fivePer;
  int finalCost;

  Widget checkForItem(int checkForZeroCost) {
    if (checkForZeroCost != 0) {
      return FlatButton.icon(
          color: Colors.green[400],
          icon: Icon(Icons.navigate_next, color: Colors.white),
          onPressed: () {
            Navigator.push(
                context,
                PageTransition(
                    child: PlaceOrder(
                      productIds: widget.itemsToOrder,
                      tCost: finalCost,
                    ),
                    type: PageTransitionType.fade));
          },
          label: Text(
            'Confirm details',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ));
    } else {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          'No items in cart to place order',
          style: TextStyle(fontSize: 18),
        ),
      );
    }
  }

  Widget getTotalCost(int totalCost) {
    if (totalCost != 0) {
      fivePer = ((5 / 100) * totalCost).toInt();
      finalCost = totalCost + 99 + fivePer;

      return Text('\u20B9' + finalCost.toString());
    } else {
      return Text('0');
    }
  }

  @override
  void initState() {
    fivePer = 0;
    finalCost = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[400],
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_sharp),
          onPressed: () {
            Navigator.push(context,
                PageTransition(child: MyCart(), type: PageTransitionType.fade));
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey[200],
                ),
                margin: EdgeInsets.all(10.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: [
                            Text(
                              'Total billing cost',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            // Icon(Icons.attach_money),
                          ],
                        ),
                        Divider(
                          color: Colors.black,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Product Tax:     ',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w400),
                            ),
                            Text('5%' + '  +')
                          ],
                        ),
                        Divider(
                          color: Colors.black,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Cart items total cost:     ',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w400),
                            ),
                            Text("\u20B9" + widget.tCost.toString() + '  +')
                          ],
                        ),
                        Divider(
                          color: Colors.black,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Delivery charges:     ',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w400),
                            ),
                            Text('\u20B9' + '99' + '  +')
                          ],
                        ),
                        Divider(
                          color: Colors.black,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Total Cost:     ',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w400),
                            ),
                            getTotalCost(widget.tCost),
                          ],
                        ),
                        Divider(
                          color: Colors.black,
                        ),
                        // SizedBox(
                        //   height: 20,
                        // ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    '2% of your total billing cost will go to GreenTeam tree planting organization, Thank you!!',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            checkForItem(widget.tCost),
          ],
        ),
      ),
    );
  }
}
