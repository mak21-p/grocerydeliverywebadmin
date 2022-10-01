import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:location/location.dart';

ValueNotifier<int> loccontroller = ValueNotifier<int>(0);

class GroceryLocationScreen extends StatefulWidget {
  static const String routeName = '/grocerylocation';

  static Route route() {
    return MaterialPageRoute(
        builder: (_) => GroceryLocationScreen(),
        settings: RouteSettings(name: routeName));
  }

  @override
  State<GroceryLocationScreen> createState() => _GroceryLocationScreenState();
}

class _GroceryLocationScreenState extends State<GroceryLocationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Firebase.initializeApp(),
        builder: ((context, snapshot) {
          if (snapshot.hasError) return Text("Something went wrong");

          if (!snapshot.hasData) return Text("Got no Data");

          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done)
            return YansMap();

          return Text("Loading...");
        }),
      ),
    );
  }
}

class YansMap extends StatefulWidget {
  const YansMap({Key? key}) : super(key: key);

  @override
  State<YansMap> createState() => _YansMapState();
}

class _YansMapState extends State<YansMap> {
  var db = FirebaseFirestore.instance;
  final Set<Marker> _markers = {};
  late GoogleMapController mapController;
  Location location = Location();
  static const LatLng _center = const LatLng(45.343434, -122.545454);
  LatLng _lastMapPosition = _center;

  Future<LatLng> get() async {
    final _locationData = await location.getLocation();
    return LatLng(_locationData.latitude!, _locationData.longitude!);
  }

  String isPossible = 'Calculating Distance...';
  Color PossibleColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: loccontroller,
        builder: (context, value, child) {
          return FutureBuilder<LatLng>(
            future: get(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final locationModel = snapshot.data!;
                final latitude = locationModel.latitude;
                final longitude = locationModel.longitude;

                return Stack(
                  children: [
                    GoogleMap(
                      onMapCreated: (controller) {
                        setState(() {
                          mapController = controller;
                        });
                      },
                      myLocationEnabled: true,
                      markers: _markers,
                      onCameraMove: _onCameraMove,
                      initialCameraPosition:
                          CameraPosition(target: locationModel, zoom: 20.0),
                    ),
                    Positioned(
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Color.fromARGB(255, 31, 89, 41)),
                        ),
                        child: Text('Add Location'),
                        onPressed: _onAddMarkerButtonPressed,
                      ),
                      bottom: 50,
                      left: 75,
                    ),
                    Positioned(
                      bottom: 50,
                      right: 75,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all(2),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white),
                          padding: MaterialStateProperty.all(
                              EdgeInsets.symmetric(horizontal: 0, vertical: 5)),
                        ),
                        child: Icon(
                          Icons.explore,
                          color: Color.fromARGB(255, 31, 89, 41),
                        ),
                        onPressed: () async {
                          LocationData _userPosition =
                              await location.getLocation();
                          mapController.animateCamera(
                            CameraUpdate.newCameraPosition(
                              CameraPosition(
                                target: LatLng(_userPosition.latitude!,
                                    _userPosition.longitude!),
                                zoom: 20,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const Positioned.fill(
                      child: Align(
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.location_on,
                          size: 40,
                          color: Color.fromARGB(255, 31, 89, 41),
                        ),
                      ),
                    ),
                    Positioned.fill(
                      bottom: 75,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          isPossible,
                          style: TextStyle(
                            color: PossibleColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }
              return Center(child: const CircularProgressIndicator());
            },
          );
        },
      ),
    );
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
    var distance = calculateDistance(17.362947, 78.402300,
        position.target.latitude, position.target.longitude);
    if (distance > 2.2) {
      isPossible = 'We do not deliver here';
      PossibleColor = Colors.red;
      print(isPossible);
    } else {
      isPossible = 'Eligible for delivery';
      PossibleColor = Colors.green;
      print(isPossible);
    }
    loccontroller.value += 1;
  }

  void _onAddMarkerButtonPressed() {
    if (isPossible == 'Eligible for delivery') {
      _markers.clear();
      setState(() {
        _markers.add(
          Marker(
              markerId: MarkerId(_lastMapPosition.toString()),
              position: _lastMapPosition,
              icon: BitmapDescriptor.defaultMarker),
        );
        GeoFirePoint point =
            GeoFirePoint(_lastMapPosition.latitude, _lastMapPosition.longitude);
        var userId = FirebaseAuth.instance.currentUser!.uid;
        final userdetails = <String, dynamic>{
          "location": point.data,
        };

        db
            .collection("users")
            .doc("${userId}")
            .set(userdetails, SetOptions(merge: true));
        Navigator.pushNamed(context, '/locationinfo');
      });
    } else {
      showToast('We do not deliver here');
    }
  }

  showToast(msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey.withOpacity(0.7),
      textColor: Colors.black54,
    );
  }
}
