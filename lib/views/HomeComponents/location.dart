import 'dart:async';
import 'dart:convert';
import 'package:geocoding/geocoding.dart' as geoCo;
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:zerowaste/models/user.dart';
import 'package:zerowaste/models/userSetUp.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Location extends StatefulWidget {
  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<Location> {
  Completer<GoogleMapController> _controllerGoogleMap = Completer();
  GoogleMapController newGoogleMapController;

  Position currentPosition;
  var geoLocator = Geolocator();
  double bottomPaddingofMap = 0;

  Future<List> locatePosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;

    LatLng latLngPosition = LatLng(
      position.latitude,
      position.longitude,
    );

    String lat = position.latitude.toString();
    String long = position.longitude.toString();

    CameraPosition cameraPosition =
        new CameraPosition(target: latLngPosition, zoom: 17);

    newGoogleMapController
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    return [lat, long];
  }

  static final CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(37.42796133580664, -122.085749655962), zoom: 14.4746);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Builder(
        builder: (context) => FloatingActionButton.extended(
          onPressed: () async {
            try {
              List pos = await locatePosition();
              if (pos == null) {
                return null;
              } else {
                var lat = double.parse(pos.first);
                var long = double.parse(pos.last);
                List<geoCo.Placemark> placemarks =
                    await geoCo.placemarkFromCoordinates(lat, long);

                if (placemarks != null) {
                  Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text("PinCode : " + placemarks[0].postalCode),
                      duration: Duration(seconds: 8),
                      action: SnackBarAction(
                        label: "confirm",
                        onPressed: () async {
                          String adr = jsonEncode(placemarks);

                          // await userSetUp(
                          //   address: adr,
                          // );
                          FirebaseAuth auth = FirebaseAuth.instance;
                          String uid = auth.currentUser.uid.toString();
                          FirebaseFirestore.instance
                              .collection('users')
                              .doc(uid)
                              .update({
                            'address': adr,
                          });

                          Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text("Address updated"),
                          ));
                        },
                      )));
                }

                //print(placemarks);

              }
              // print(pos);
            } catch (e) {
              print(e);
            }
          },
          label: Text('Add my location as delivery address '),
          icon: Icon(Icons.location_on),
        ),
      ),
      body: Stack(
        children: [
          SafeArea(
            child: GoogleMap(
              padding: EdgeInsets.only(bottom: bottomPaddingofMap),
              initialCameraPosition: _kGooglePlex,
              mapType: MapType.normal,
              myLocationButtonEnabled: false,
              myLocationEnabled: true,
              zoomControlsEnabled: true,
              zoomGesturesEnabled: true,
              onMapCreated: (GoogleMapController controller) {
                _controllerGoogleMap.complete(controller);
                newGoogleMapController = controller;

                setState(() {
                  bottomPaddingofMap = 300.0;
                });

                locatePosition();
              },
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
