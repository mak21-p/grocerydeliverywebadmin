import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/scheduler.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GrocerySignupScreen extends StatefulWidget {
  static const String routeName = '/grocerysignup';

  static Route route() {
    return MaterialPageRoute(
        builder: (_) => GrocerySignupScreen(),
        settings: RouteSettings(name: routeName));
  }

  @override
  State<GrocerySignupScreen> createState() => _GrocerySignupScreenState();
}

class _GrocerySignupScreenState extends State<GrocerySignupScreen> {
  var _nametext = TextEditingController();
  var _phonetext = TextEditingController();

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var route;
      FirebaseFirestore db = FirebaseFirestore.instance;
      var userId = FirebaseAuth.instance.currentUser?.uid;
      final docref = db.collection('users').doc('${userId}');
      docref.get().then(
        (DocumentSnapshot doc) {
          final data = doc.data() as Map<String, dynamic>;
          if (data.containsKey('Name')) {
            Navigator.pushNamed(context, '/groceryhome');
          } else if (data.containsKey('Phone')) {
            Navigator.pushNamed(context, '/groceryhome');
          }
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            Image(
              image: AssetImage('assets/logo.png'),
              width: 140,
            ),
            SizedBox(
              height: 25,
            ),
            SizedBox(
              width: 300,
              child: TextField(
                controller: _nametext,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: Icon(Icons.person),
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
                  hintText: 'Name',
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            SizedBox(
              width: 300,
              child: TextField(
                keyboardType: TextInputType.number,
                maxLength: 10,
                controller: _phonetext,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: Icon(Icons.phone),
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
                  hintText: 'Phone Number',
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            ElevatedButton(
              onPressed: () {
                final userdata = <String, dynamic>{
                  "Name": _nametext.text,
                  "Phone": _phonetext.text,
                };
                var userId = FirebaseAuth.instance.currentUser!.uid;
                final db = FirebaseFirestore.instance;
                db
                    .collection('users')
                    .doc('${userId}')
                    .set(userdata, SetOptions(merge: true));

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
        ),
      ),
    );
  }
}
