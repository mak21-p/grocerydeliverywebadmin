import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SingleProductScreen extends StatefulWidget {
  static const String routeName = '/singleproductscreen';

  const SingleProductScreen(
      {super.key, required this.category, required this.docName});

  static Route route({required String category, required String docName}) {
    return MaterialPageRoute(
        builder: (_) =>
            SingleProductScreen(category: category, docName: docName),
        settings: RouteSettings(name: routeName));
  }

  final String category;
  final String docName;

  @override
  State<SingleProductScreen> createState() => _SingleProductScreenState();
}

class _SingleProductScreenState extends State<SingleProductScreen> {
  @override
  Widget build(BuildContext context) {
    var db = FirebaseFirestore.instance;
    var stream;
    var collection;
    String streamstring;

    if (widget.category == 'fruits') {
      collection = 'fruits';
      stream =
          db.collection('${collection}').doc('${widget.docName}').snapshots();
    } else if (widget.category == 'dairy') {
      collection = 'dairy';
      stream =
          db.collection('${collection}').doc('${widget.docName}').snapshots();
    } else if (widget.category == 'munchies') {
      collection = 'munchies';
      stream =
          db.collection('${collection}').doc('${widget.docName}').snapshots();
    } else if (widget.category == 'dessert') {
      collection = 'dessert';
      stream =
          db.collection('${collection}').doc('${widget.docName}').snapshots();
    } else if (widget.category == 'drinks') {
      collection = 'drinks';
      stream =
          db.collection('${collection}').doc('${widget.docName}').snapshots();
    } else if (widget.category == 'tea') {
      collection = 'tea';
      stream =
          db.collection('${collection}').doc('${widget.docName}').snapshots();
    } else if (widget.category == 'rice') {
      collection = 'rice';
      stream =
          db.collection('${collection}').doc('${widget.docName}').snapshots();
    } else if (widget.category == 'oil') {
      collection = 'oil';
      stream =
          db.collection('${collection}').doc('${widget.docName}').snapshots();
    } else if (widget.category == 'meat') {
      collection = 'meat';
      stream =
          db.collection('${collection}').doc('${widget.docName}').snapshots();
    } else if (widget.category == 'cleaning') {
      collection = 'cleaning';
      stream =
          db.collection('${collection}').doc('${widget.docName}').snapshots();
    } else if (widget.category == 'personalhygiene') {
      collection = 'personalhygiene';
      stream =
          db.collection('${collection}').doc('${widget.docName}').snapshots();
    } else if (widget.category == 'babycare') {
      collection = 'babycare';
      stream =
          db.collection('${collection}').doc('${widget.docName}').snapshots();
    } else if (widget.category == 'Bundles') {
      collection = 'Bundles';
      stream =
          db.collection('${collection}').doc('${widget.docName}').snapshots();
    }
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Color.fromARGB(255, 114, 114, 114),
        ),
        elevation: 0,
        title: Text(
          '',
          style: TextStyle(
            color: Color.fromARGB(255, 114, 114, 114),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<DocumentSnapshot>(
            stream: db
                .collection('${collection}')
                .doc('${widget.docName}')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Container(
                color: Colors.white,
                child: Column(
                  children: [
                    Container(
                      height: 650,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 237, 237, 237),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: 500,
                            color: Color.fromARGB(255, 237, 237, 237),
                            child: Container(
                              height: 400,
                              width: 300,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(17),
                                color: Colors.white,
                              ),
                              child: Image.network(
                                snapshot.data!['image'],
                                width: 250,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Text(
                            '${snapshot.data!['Name']}',
                            style: TextStyle(
                              color: Color.fromARGB(255, 114, 114, 114),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 55),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      '${snapshot.data!['Weight']}',
                                      style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 114, 114, 114),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      '₹${snapshot.data!['Price']}',
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 31, 89, 41),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                                OutlinedButton(
                                  onPressed: () {
                                    var userId =
                                        FirebaseAuth.instance.currentUser!.uid;

                                    var docRef = db
                                        .collection('cart ${userId}')
                                        .doc('${snapshot.data!['Name']}');
                                    docRef.get().then((DocumentSnapshot doc) {
                                      final data =
                                          doc.data() as Map<String, dynamic>?;
                                      if (data?['Quantity'] == null) {
                                        var addproductdata = <String, dynamic>{
                                          "Name": "${snapshot.data!['Name']}",
                                          "Weight":
                                              "${snapshot.data!['Weight']}",
                                          "Price": "${snapshot.data!['Price']}",
                                          "Image": "${snapshot.data!['image']}",
                                          "Quantity": "1"
                                        };

                                        db
                                            .collection('cart ${userId}')
                                            .doc('${snapshot.data!['Name']}')
                                            .set(addproductdata);
                                      } else if (data?['Quantity'] == '0') {
                                        var addproductdata = <String, dynamic>{
                                          "Name": "${snapshot.data!['Name']}",
                                          "Weight":
                                              "${snapshot.data!['Weight']}",
                                          "Price": "${snapshot.data!['Price']}",
                                          "Image": "${snapshot.data!['image']}",
                                          "Quantity": "1"
                                        };

                                        db
                                            .collection('cart ${userId}')
                                            .doc('${snapshot.data!['Name']}')
                                            .set(addproductdata);
                                      } else {
                                        var newquantity =
                                            int.parse(data?['Quantity']) + 1;
                                        var addproductdata = <String, dynamic>{
                                          "Quantity": "${newquantity}"
                                        };

                                        db
                                            .collection('cart ${userId}')
                                            .doc('${snapshot.data!['Name']}')
                                            .set(addproductdata,
                                                SetOptions(merge: true));
                                      }
                                    });
                                  },
                                  child: Text(
                                    'ADD',
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 31, 89, 41),
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: 650,
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 13),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 237, 237, 237),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Text(
                            '${snapshot.data!['description']}',
                            style: const TextStyle(
                              color: Color.fromARGB(255, 114, 114, 114),
                              fontWeight: FontWeight.w300,
                              fontSize: 13,
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Text(
                            'Related Products',
                            style: TextStyle(
                              color: Color.fromARGB(255, 31, 89, 41),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          StreamBuilder<QuerySnapshot>(
                            stream: db.collection('${collection}').snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return const Text('An Error Occured');
                              }

                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              return Container(
                                height: 275,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (context, index) {
                                    return Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                SingleProductScreen.route(
                                                    category: collection,
                                                    docName: snapshot
                                                        .data!.docs[index].id));
                                          },
                                          child: Container(
                                            width: 150,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5, vertical: 5),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: Colors.white,
                                            ),
                                            child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Image.network(
                                                    '${snapshot.data!.docs[index]['image']}',
                                                    width: 75,
                                                    height: 75,
                                                  ),
                                                  Text(
                                                    '${snapshot.data!.docs[index]['Name']}',
                                                    style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 114, 114, 114),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: Text(
                                                      '${snapshot.data!.docs[index]['Weight']}',
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 114, 114, 114),
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        '₹${snapshot.data!.docs[index]['Price']}',
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    31,
                                                                    89,
                                                                    41),
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      OutlinedButton(
                                                        onPressed: () async {
                                                          var userId =
                                                              FirebaseAuth
                                                                  .instance
                                                                  .currentUser!
                                                                  .uid;

                                                          var docRef = db
                                                              .collection(
                                                                  'cart ${userId}')
                                                              .doc(
                                                                  '${snapshot.data!.docs[index]['Name']}');
                                                          docRef.get().then(
                                                              (DocumentSnapshot
                                                                  doc) {
                                                            final data = doc
                                                                    .data()
                                                                as Map<String,
                                                                    dynamic>?;
                                                            if (data?[
                                                                    'Quantity'] ==
                                                                null) {
                                                              var addproductdata =
                                                                  <String,
                                                                      dynamic>{
                                                                "Name":
                                                                    "${snapshot.data!.docs[index]['Name']}",
                                                                "Weight":
                                                                    "${snapshot.data!.docs[index]['Weight']}",
                                                                "Price":
                                                                    "${snapshot.data!.docs[index]['Price']}",
                                                                "Image":
                                                                    "${snapshot.data!.docs[index]['image']}",
                                                                "Quantity": "1"
                                                              };

                                                              db
                                                                  .collection(
                                                                      'cart ${userId}')
                                                                  .doc(
                                                                      '${snapshot.data!.docs[index]['Name']}')
                                                                  .set(
                                                                      addproductdata);
                                                            } else if (data?[
                                                                    'Quantity'] ==
                                                                '0') {
                                                              var addproductdata =
                                                                  <String,
                                                                      dynamic>{
                                                                "Name":
                                                                    "${snapshot.data!.docs[index]['Name']}",
                                                                "Weight":
                                                                    "${snapshot.data!.docs[index]['Weight']}",
                                                                "Price":
                                                                    "${snapshot.data!.docs[index]['Price']}",
                                                                "Image":
                                                                    "${snapshot.data!.docs[index]['image']}",
                                                                "Quantity": "1"
                                                              };

                                                              db
                                                                  .collection(
                                                                      'cart ${userId}')
                                                                  .doc(
                                                                      '${snapshot.data!.docs[index]['Name']}')
                                                                  .set(
                                                                      addproductdata);
                                                            } else {
                                                              var newquantity =
                                                                  int.parse(data?[
                                                                          'Quantity']) +
                                                                      1;
                                                              var addproductdata =
                                                                  <String,
                                                                      dynamic>{
                                                                "Quantity":
                                                                    "${newquantity}"
                                                              };

                                                              db
                                                                  .collection(
                                                                      'cart ${userId}')
                                                                  .doc(
                                                                      '${snapshot.data!.docs[index]['Name']}')
                                                                  .set(
                                                                      addproductdata,
                                                                      SetOptions(
                                                                          merge:
                                                                              true));
                                                            }
                                                          });
                                                        },
                                                        child: Text(
                                                          'ADD',
                                                          style: TextStyle(
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      31,
                                                                      89,
                                                                      41),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ]),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 25,
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            }),
      ),
    );
  }
}
