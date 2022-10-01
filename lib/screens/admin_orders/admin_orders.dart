import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yans/screens/screens.dart';

class AdminOrdersScreen extends StatelessWidget {
  static const String routeName = '/adminorders';

  static Route route() {
    return MaterialPageRoute(
        builder: (_) => AdminOrdersScreen(),
        settings: RouteSettings(name: routeName));
  }

  @override
  Widget build(BuildContext context) {
    var db = FirebaseFirestore.instance;
    return Scaffold(
      appBar: AppBar(title: Text('Orders')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            StreamBuilder<QuerySnapshot>(
                stream: db
                    .collection('orders')
                    .orderBy('Time Added', descending: true)
                    .snapshots(),
                builder: ((context, snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Something went wrong');
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView.separated(
                    separatorBuilder: ((context, index) {
                      return SizedBox(
                        height: 20,
                        width: 100,
                      );
                    }),
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (((context, index) {
                      // GeoPoint geopoint =
                      //     snapshot.data!.docs[index]['Location']['geopoint'];
                      // Set<Marker> _markers = {};
                      // Marker deliverymarker = Marker(
                      //     position: LatLng(geopoint.latitude, geopoint.longitude),
                      //     markerId: const MarkerId('Delivery Point'));
                      // _markers.add(deliverymarker);
                      var isdelivered;
                      Color fontcolor;
                      if (snapshot.data!.docs[index]['Delivered'] == 'False') {
                        isdelivered = 'Not delivered';
                        fontcolor = Color.fromARGB(255, 187, 48, 30);
                      } else {
                        isdelivered = 'Delivered';
                        fontcolor = Color.fromARGB(255, 31, 89, 41);
                      }
                      String _orderId =
                          "${snapshot.data!.docs[index].reference.id}";
                      return UnconstrainedBox(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(context,
                                AdminViewOrderScreen.route(orderId: _orderId));
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width - 25,
                            height: 100,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Order ${isdelivered}',
                                  style: TextStyle(
                                    color: fontcolor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Icon(
                                  Icons.navigate_next_rounded,
                                  color: fontcolor,
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    })),
                  );
                })),
          ],
        ),
      ),
    );
  }
}
