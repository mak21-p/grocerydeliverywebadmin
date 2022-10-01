import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminViewOrderScreen extends StatefulWidget {
  static const String routeName = '/adminvieworder';

  const AdminViewOrderScreen({super.key, required this.orderId});

  static Route route({required String orderId}) {
    return MaterialPageRoute(
        builder: (_) => AdminViewOrderScreen(orderId: orderId),
        settings: RouteSettings(name: routeName));
  }

  final String orderId;

  @override
  State<AdminViewOrderScreen> createState() => _AdminViewOrderScreenState();
}

class _AdminViewOrderScreenState extends State<AdminViewOrderScreen> {
  @override
  var db = FirebaseFirestore.instance;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Orders')),
      body: SingleChildScrollView(
        child: StreamBuilder<DocumentSnapshot>(
          stream: db.collection('orders').doc('${widget.orderId}').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            GeoPoint geopoint = snapshot.data!['Location']['geopoint'];
            Set<Marker> _markers = {};
            Marker deliverymarker = Marker(
                position: LatLng(geopoint.latitude, geopoint.longitude),
                markerId: const MarkerId('Delivery Point'));
            _markers.add(deliverymarker);
            Map<String, dynamic> productinfo = snapshot.data!['Products'];
            bool isDelivered;
            snapshot.data!['Delivered'] == "False"
                ? isDelivered = false
                : isDelivered = true;
            DateTime timeadded =
                (snapshot.data!['Time Added'] as Timestamp).toDate();
            return Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 25,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Customer Name',
                          style: TextStyle(
                            color: Color.fromARGB(255, 31, 89, 41),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          '${snapshot.data!['Name']}',
                          style: const TextStyle(
                            color: Color.fromARGB(255, 31, 89, 41),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Location',
                          style: TextStyle(
                            color: Color.fromARGB(255, 31, 89, 41),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 75,
                          height: 200,
                          child: GoogleMap(
                            markers: _markers,
                            initialCameraPosition: CameraPosition(
                                zoom: 15,
                                target: LatLng(
                                    geopoint.latitude, geopoint.longitude)),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Delivery Instructions',
                          style: TextStyle(
                            color: Color.fromARGB(255, 31, 89, 41),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          '${snapshot.data!['Delivery Instructions']}',
                          style: const TextStyle(
                            color: Color.fromARGB(255, 31, 89, 41),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Phone',
                          style: TextStyle(
                            color: Color.fromARGB(255, 31, 89, 41),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${snapshot.data!['Phone']}',
                              style: const TextStyle(
                                color: Color.fromARGB(255, 31, 89, 41),
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            OutlinedButton(
                              onPressed: () {
                                Uri uri = Uri(
                                    scheme: 'tel',
                                    path: '+91${snapshot.data!['Phone']}');
                                launchUrl(uri);
                              },
                              child: Icon(Icons.phone),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Products',
                          style: TextStyle(
                            color: Color.fromARGB(255, 31, 89, 41),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: productinfo.length,
                          itemBuilder: (context, index) {
                            return Center(
                              child: Text(
                                '${productinfo['${index}']}',
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 31, 89, 41),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'User ID',
                          style: TextStyle(
                            color: Color.fromARGB(255, 31, 89, 41),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${snapshot.data!['uid']}',
                          style: const TextStyle(
                            color: Color.fromARGB(255, 31, 89, 41),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Ordered At',
                          style: TextStyle(
                            color: Color.fromARGB(255, 31, 89, 41),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${timeadded}',
                          style: const TextStyle(
                            color: Color.fromARGB(255, 31, 89, 41),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        isDelivered == false
                            ? SizedBox(
                                width: MediaQuery.of(context).size.width - 50,
                                child: ElevatedButton(
                                  onPressed: () {
                                    db
                                        .collection('orders')
                                        .doc('${widget.orderId}')
                                        .update({"Delivered": "True"});
                                  },
                                  child: Text(
                                    'Send for Delivery',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22),
                                  ),
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Color.fromARGB(255, 31, 89, 41)),
                                      padding: MaterialStateProperty.all(
                                          const EdgeInsets.symmetric(
                                              vertical: 10)),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                        ),
                                      )),
                                ),
                              )
                            : const Text(
                                'Already Delivered',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 31, 89, 41),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                        SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
