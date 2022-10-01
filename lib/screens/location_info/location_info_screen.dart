import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LocationInfoScreen extends StatelessWidget {
  static const String routeName = '/locationinfo';
  var db = FirebaseFirestore.instance;
  var _hometext = TextEditingController();
  var _delinstructions = TextEditingController();

  static Route route() {
    return MaterialPageRoute(
        builder: (_) => LocationInfoScreen(),
        settings: RouteSettings(name: routeName));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Color.fromARGB(255, 58, 110, 67),
              Color.fromARGB(255, 20, 77, 30)
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
            width: MediaQuery.of(context).size.width,
            height: 215,
            child: Padding(
              padding: const EdgeInsets.only(top: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.white,
                      )),
                  Padding(
                    padding: const EdgeInsets.only(top: 40.0),
                    child: Image(
                      image: AssetImage('assets/logo.png'),
                      width: 140,
                    ),
                  ),
                  SizedBox(
                    width: 50,
                  ),
                ],
              ),
            ),
          ),
          Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                'Additional Information',
                style: TextStyle(
                  color: Color.fromARGB(255, 37, 91, 46),
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              SizedBox(
                height: 18,
              ),
              SizedBox(
                width: 300,
                child: TextField(
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  controller: _hometext,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: Icon(Icons.home),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        width: 3.0,
                        color: Color.fromARGB(255, 38, 93, 48),
                      ),
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(50.0)),
                    hintText: 'House and Flat No.',
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              SizedBox(
                width: 300,
                child: TextField(
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  controller: _delinstructions,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: Icon(Icons.local_shipping),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        width: 3.0,
                        color: Color.fromARGB(255, 38, 93, 48),
                      ),
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(50.0)),
                    hintText: 'Additional Instructions',
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              ElevatedButton(
                onPressed: () {
                  var userId = FirebaseAuth.instance.currentUser!.uid;
                  final userhomedetails = <String, dynamic>{
                    "homeinfo": _hometext.text,
                    "deliveryinstructions": _delinstructions.text
                  };
                  db
                      .collection("users")
                      .doc("${userId}")
                      .set(userhomedetails, SetOptions(merge: true));
                  Navigator.pushNamed(context, '/yanshome');
                },
                child: Text(
                  'SAVE',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(0),
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Color.fromARGB(255, 31, 89, 41)),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      const EdgeInsets.symmetric(vertical: 11, horizontal: 70)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  )),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
