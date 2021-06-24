import 'package:flutter/material.dart';
import 'package:zerowaste/views/HomeComponents/advertismentBanner.dart';
import 'package:zerowaste/views/HomeComponents/categories.dart';
import 'package:zerowaste/views/HomeComponents/offerBaner.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            // SizedBox(height: 10),
            new Container(
              height: 10.0,
              color: Colors.grey[100],
            ),
            Categories(),
            new Container(
              height: 10.0,
              color: Colors.grey[100],
            ),
            OfferBanner(),
            new Container(
              height: 10.0,
              color: Colors.grey[100],
            ),
            AdvertismentBanner(),
            new Container(
              height: 10.0,
              color: Colors.grey[100],
            ),
          ],
        ),
      ),
    );
  }
}
