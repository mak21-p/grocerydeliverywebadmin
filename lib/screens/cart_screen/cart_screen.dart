import 'dart:async';
import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';

var isclicked = 0;

ValueNotifier<int> controller = ValueNotifier<int>(0);
ValueNotifier<int> _controller = ValueNotifier<int>(0);

class CartScreen extends StatefulWidget {
  static const String routeName = '/cart';

  static Route route() {
    return MaterialPageRoute(
        builder: (_) => CartScreen(), settings: RouteSettings(name: routeName));
  }

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  Razorpay razorpay = Razorpay();
  var msg;

  double total = 20;

  var userdata;
  var db = FirebaseFirestore.instance;
  var newpaytotal;

  Future<double> MakeTotal() async {
    total = 20;
    final dataref = await db.collection('cart ${userId}').get().then((event) {
      for (var doc in event.docs) {
        double price = double.parse(doc.data()['Price']);
        double quantity = double.parse(doc.data()['Quantity']);
        double producttotal = price * quantity;
        total += producttotal;
      }
    });

    return total;
  }

  double itemtotal = 0;

  void DefaultItemTotal() {
    itemtotal = 0;
  }

  Future<double> MakeItemTotal() async {
    DefaultItemTotal();
    final dataref =
        await db.collection('cart ${userId}').snapshots().listen((event) {
      for (var doc in event.docs) {
        double price = double.parse(doc.data()['Price']);
        double quantity = double.parse(doc.data()['Quantity']);
        double producttotal = price * quantity;
        itemtotal += producttotal;
      }
    });

    return await itemtotal;
  }

  double paytotal = 20;

  void DefaultPayTotal() {
    paytotal = 20;
  }

  Future<double> MakePayTotal() async {
    DefaultPayTotal();
    final dataref = db.collection('cart ${userId}').snapshots().listen((event) {
      for (var doc in event.docs) {
        double price = double.parse(doc.data()['Price']);
        double quantity = double.parse(doc.data()['Quantity']);
        double producttotal = price * quantity;
        paytotal += producttotal;
      }
    });

    return paytotal;
  }

  Timer? timer;

  @override
  void initState() {
    super.initState();

    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
    final docref = db.collection('users').doc('${userId}');
    docref.get().then((DocumentSnapshot doc) {
      userdata = doc.data() as Map<String, dynamic>;
    });
    timer = Timer.periodic(Duration(seconds: 2), (timer) {
      _controller.value += 1;
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration(seconds: 3), () {
        controller.value += 1;
        _controller.value += 1;
      });
    });
  }

  Future<int> Getlength() async {
    int length = await FirebaseFirestore.instance
        .collection('cart ${userId}')
        .snapshots()
        .length;

    return length;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer?.cancel();
    super.dispose();
    razorpay.clear();
  }

  var userId = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Color.fromARGB(255, 114, 114, 114),
        ),
        elevation: 0,
        title: Text(
          'Review Cart',
          style: TextStyle(
            color: Color.fromARGB(255, 114, 114, 114),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        bottom: PreferredSize(
          child: Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 72),
            child: const Text(
              'Yans Mart',
              style: TextStyle(
                color: Color.fromARGB(255, 31, 89, 41),
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          preferredSize: Size.fromHeight(0),
        ),
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('cart ${userId}')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: ((context, index) {
                      var itemPriceTotal = (int.parse(
                              snapshot.data!.docs[index]['Price'])) *
                          (int.parse(snapshot.data!.docs[index]['Quantity']));

                      return Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 17),
                        color: Colors.white,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 75,
                                  width: 75,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 8),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(11),
                                      color:
                                          Color.fromARGB(255, 242, 242, 242)),
                                  child: Image.network(
                                    snapshot.data!.docs[index]['Image'],
                                    width: 35,
                                    height: 50,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width / 2.5,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${snapshot.data!.docs[index]['Name']}',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Color.fromARGB(
                                              255, 114, 114, 114),
                                        ),
                                      ),
                                      Text(
                                        '${snapshot.data!.docs[index]['Weight']}',
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w300,
                                          color: Color.fromARGB(
                                              255, 114, 114, 114),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 80,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Color.fromARGB(255, 112, 112, 112),
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        constraints:
                                            BoxConstraints(maxWidth: 20),
                                        padding: const EdgeInsets.all(0),
                                        onPressed: () {
                                          int qty = int.parse(snapshot
                                              .data!.docs[index]['Quantity']);
                                          int newqty = qty - 1;
                                          var ref = snapshot
                                              .data!.docs[index].reference.id;

                                          if (qty == 1) {
                                            db
                                                .collection('cart ${userId}')
                                                .doc('${ref}')
                                                .delete();
                                          } else {
                                            db
                                                .collection('cart ${userId}')
                                                .doc('${ref}')
                                                .update(
                                                    {"Quantity": "${newqty}"});
                                          }

                                          controller.value += 1;
                                          _controller.value += 1;
                                        },
                                        icon: Icon(
                                          Icons.remove,
                                          size: 10,
                                        ),
                                      ),
                                      Text(
                                        '${snapshot.data!.docs[index]['Quantity']}',
                                        style: TextStyle(
                                            color:
                                                Color.fromARGB(255, 31, 89, 41),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                      IconButton(
                                        constraints:
                                            BoxConstraints(maxWidth: 20),
                                        padding: const EdgeInsets.all(0),
                                        onPressed: () {
                                          int qty = int.parse(snapshot
                                              .data!.docs[index]['Quantity']);
                                          int newqty = qty + 1;
                                          var ref = snapshot
                                              .data!.docs[index].reference.id;
                                          db
                                              .collection('cart ${userId}')
                                              .doc('${ref}')
                                              .update(
                                                  {"Quantity": "${newqty}"});
                                          controller.value += 1;
                                          _controller.value += 1;
                                        },
                                        icon: Icon(
                                          Icons.add,
                                          size: 10,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  '₹${itemPriceTotal}',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 31, 89, 41),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                )
                              ],
                            )
                          ],
                        ),
                      );
                    }),
                  );
                }),
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 12, right: 12, top: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Bill Details',
                      style: TextStyle(
                          color: Color.fromARGB(255, 114, 114, 114),
                          fontWeight: FontWeight.w500,
                          fontSize: 12),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Item Total',
                        style: TextStyle(
                            color: Color.fromARGB(255, 114, 114, 114),
                            fontWeight: FontWeight.w300,
                            fontSize: 12),
                      ),
                      ValueListenableBuilder(
                        valueListenable: _controller,
                        builder: (context, value, child) {
                          return FutureBuilder<double>(
                              future: MakeItemTotal(),
                              builder: (context, snapshot) {
                                if (itemtotal == 0) {
                                  return CircularProgressIndicator();
                                } else {
                                  return Text(
                                    '₹${itemtotal}',
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 114, 114, 114),
                                        fontWeight: FontWeight.w300,
                                        fontSize: 12),
                                  );
                                }
                              });
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Carrybag Charge',
                        style: TextStyle(
                          color: Color.fromARGB(255, 23, 102, 160),
                          fontWeight: FontWeight.w300,
                          fontSize: 12,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      Text(
                        'FREE',
                        style: TextStyle(
                            color: Color.fromARGB(255, 114, 114, 114),
                            fontWeight: FontWeight.w300,
                            fontSize: 12),
                      ),
                    ],
                  ),
                  Row(
                    children: List.generate(
                      300 ~/ 5,
                      (index) => Expanded(
                        child: Container(
                          color:
                              index % 2 == 0 ? Colors.transparent : Colors.grey,
                          height: 2,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Delivery Partner Fee',
                        style: TextStyle(
                          color: Color.fromARGB(255, 23, 102, 160),
                          fontWeight: FontWeight.w300,
                          fontSize: 12,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      Text(
                        '₹20',
                        style: TextStyle(
                            color: Color.fromARGB(255, 114, 114, 114),
                            fontWeight: FontWeight.w300,
                            fontSize: 12),
                      ),
                    ],
                  ),
                  Row(
                    children: List.generate(
                      300 ~/ 5,
                      (index) => Expanded(
                        child: Container(
                          color:
                              index % 2 == 0 ? Colors.transparent : Colors.grey,
                          height: 2,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'To Pay',
                        style: TextStyle(
                          color: Color.fromARGB(255, 114, 114, 114),
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      ValueListenableBuilder(
                        valueListenable: controller,
                        builder: (context, value, child) {
                          return FutureBuilder<double>(
                              future: MakeTotal(),
                              builder: (context, snapshot) {
                                if (total == 20) {
                                  return CircularProgressIndicator();
                                } else {
                                  return Text(
                                    '₹${total}',
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 114, 114, 114),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12),
                                  );
                                }
                              });
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 50,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: () async {
                        newpaytotal = await MakePayTotal();
                        openCheckout();
                      },
                      child: Text(
                        'MAKE PAYMENT',
                        style: TextStyle(
                          letterSpacing: 3,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromARGB(255, 31, 89, 41),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<double> calculateFinalPay(
      QuerySnapshot<Map<String, dynamic>> event) async {
    double finalpay = 20;
    for (var doc in event.docs) {
      double price = double.parse(doc.data()['Price']);
      double quantity = double.parse(doc.data()['Quantity']);
      double producttotal = price * quantity;
      finalpay += producttotal;
    }
    dev.log('${Future.value(finalpay)}');
    return Future.value(finalpay);
  }

  void openCheckout() async {
    isclicked = 1;
    double finalpay = 20;
    var db = FirebaseFirestore.instance;
    if (isclicked == 1) {
      final dataref = db.collection('cart ${userId}').get().then((event) async {
        double finalpaydev = await calculateFinalPay(event);
        dev.log('${finalpaydev}');
        var options = {
          "key": "RAZORPAYKEY",
          "amount": finalpaydev * 100,
          "name": "Payment By ${userdata['Name']}",
          "description": "This is a Test Payment",
          "timeout": "180",
          "theme.color": "#03be03",
          "currency": "INR",
          "prefill": {
            "contact": "${userdata['Phone']}",
          },
          "options": {
            "checkout": {
              "method": {
                "netbanking": "1",
                "card": "1",
                "upi": "1",
                "wallet": "0"
              }
            }
          }
        };
        if (isclicked == 1) {
          try {
            Future.delayed(Duration(seconds: 2), () {
              razorpay.open(options);
            });
          } catch (e) {
            print(e.toString());
          }
        }
      });
    }
  }

  Future<void> handlerPaymentSuccess(PaymentSuccessResponse response) async {
    print("Pament success");
    msg = "SUCCESS: " + response.paymentId!;
    showToast(msg);
    var db = FirebaseFirestore.instance;
    var input = <String, dynamic>{"Paid": "true"};
    /* db
        .collection('cart ${userId}')
        .doc('Payment')
        .set(input, SetOptions(merge: true)); */

    db
        .collection('users')
        .doc('${userId}')
        .get()
        .then((DocumentSnapshot usersdoc) {
      final userdata = usersdoc.data() as Map<String, dynamic>;
      db.collection('cart ${userId}').get().then((QuerySnapshot doc) async {
        final docdata = doc.docs;
        DateTime daynow = DateTime.now();
        Timestamp timestamp = Timestamp.fromDate(daynow);
        Map<String, dynamic> exportdata = {"0": ""};
        String curdate = daynow.hour.toString() +
            ":" +
            daynow.minute.toString() +
            ":" +
            daynow.second.toString();

        Future<void> ExportData() async {
          int x = 0;
          docdata.forEach((singledoc) {
            exportdata["${x}"] =
                "${singledoc['Name']} ${singledoc['Weight']} Quantity: ${singledoc['Quantity']} Price: ${singledoc['Price']}";
            x++;
          });
        }

        await Future.wait([ExportData()]);

        Map<String, dynamic> finalexportdata = {
          "uid": "${userId}",
          "Name": "${userdata['Name']}",
          "Phone": "${userdata['Phone']}",
          "Location": userdata['location'],
          "Delivery Instructions": "${userdata['deliveryinstructions']}",
          "Delivered": "False",
          "Paid": true,
          "Time Added": timestamp,
          "Products": exportdata,
        };

        Random rand = new Random();
        int randomno = rand.nextInt(100000000);

        db
            .collection('orders')
            .doc('${userId} ${randomno}')
            .set(finalexportdata);

        db.collection('cart ${userId}').get().then((snapshot) {
          for (DocumentSnapshot ds in snapshot.docs) {
            ds.reference.delete();
          }
        });
      }, onError: (e) => print('Error: $e'));
    });
  }

  void handlerErrorFailure(PaymentFailureResponse response) {
    msg = "ERROR: " +
        response.code.toString() +
        " - " +
        jsonDecode(response.message!)['error']['description'];
    showToast(msg);
  }

  void handlerExternalWallet(ExternalWalletResponse response) {
    msg = "EXTERNAL_WALLET: " + response.walletName!;
    showToast(msg);
  }

  showToast(msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey.withOpacity(0.1),
      textColor: Colors.black54,
    );
  }
}
