import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firestore_search/firestore_search.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yans/screens/screens.dart';

class DataModel {
  final String? Name;
  final String? Image;
  final String? Weight;
  final String? Price;

  DataModel({this.Name, this.Image, this.Weight, this.Price});

  //Create a method to convert QuerySnapshot from Cloud Firestore to a list of objects of this DataModel
  //This function in essential to the working of FirestoreSearchScaffold

  List<DataModel> dataListFromSnapshot(QuerySnapshot querySnapshot) {
    return querySnapshot.docs.map((snapshot) {
      final Map<String, dynamic> dataMap =
          snapshot.data() as Map<String, dynamic>;

      return DataModel(
          Name: dataMap['Name'],
          Image: dataMap['image'],
          Weight: dataMap['Weight'],
          Price: dataMap['Price']);
    }).toList();
  }
}

class GrocerySearchScreen extends StatefulWidget {
  static const String routeName = '/grocerysearch';

  static Route route() {
    return MaterialPageRoute(
        builder: (_) => GrocerySearchScreen(),
        settings: RouteSettings(name: routeName));
  }

  @override
  State<GrocerySearchScreen> createState() => _GrocerySearchScreenState();
}

class _GrocerySearchScreenState extends State<GrocerySearchScreen> {
  var db = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 50,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/yanshome');
              },
              child: Icon(
                Icons.home_filled,
                color: Color.fromARGB(255, 114, 114, 114),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/yanslocation');
              },
              child: Icon(
                Icons.location_pin,
                color: Color.fromARGB(255, 114, 114, 114),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/contactus');
              },
              child: Icon(
                Icons.person,
                color: Color.fromARGB(255, 114, 114, 114),
              ),
            ),
          ],
        ),
      ),
      body: ListView(
        physics: ScrollPhysics(),
        shrinkWrap: true,
        children: [
          SizedBox(
            height: 50,
          ),
          FirestoreSearchBar(
            searchBackgroundColor: Colors.white,
            tag: 'mainsearch',
          ),
          FirestoreSearchResults.builder(
            tag: 'mainsearch',
            firestoreCollectionName: 'fruits',
            searchBy: 'Name',
            dataListFromSnapshot: DataModel().dataListFromSnapshot,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final List<DataModel>? dataList = snapshot.data;
                if (dataList!.isEmpty) {
                  return const Center(
                    child: Text(''),
                  );
                }
                return GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10.0,
                    childAspectRatio: MediaQuery.of(context).size.width / 700,
                  ),
                  shrinkWrap: true,
                  itemCount: dataList.length,
                  itemBuilder: (context, index) {
                    final DataModel data = dataList[index];

                    return Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              color: Color.fromARGB(255, 112, 112, 112),
                              width: 0.5),
                          right: BorderSide(
                              color: Color.fromARGB(255, 112, 112, 112),
                              width: 0.5),
                        ),
                      ),
                      child: InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 28, right: 11, left: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.network(
                                data.Image!,
                                width: 75,
                              ),
                              Text(
                                '${data.Name}',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 114, 114, 114),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  '${data.Weight}',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 114, 114, 114),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '₹${data.Price}',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Color.fromARGB(255, 31, 89, 41),
                                        fontWeight: FontWeight.bold),
                                  ),
                                  OutlinedButton(
                                    onPressed: () async {
                                      var userId = FirebaseAuth
                                          .instance.currentUser!.uid;

                                      var docRef = db
                                          .collection('cart ${userId}')
                                          .doc('${data.Name}');
                                      String prodname = data.Name!;
                                      String prodweight = data.Weight!;
                                      String prodprice = data.Price!;
                                      String prodimage = data.Image!;
                                      docRef.get().then((DocumentSnapshot doc) {
                                        final docdata =
                                            doc.data() as Map<String, dynamic>?;
                                        if (docdata?['Quantity'] == null) {
                                          var addproductdata =
                                              <String, dynamic>{
                                            "Name": "${prodname}",
                                            "Weight": "${prodweight}",
                                            "Price": "${prodprice}",
                                            "Image": "${prodimage}",
                                            "Quantity": "1"
                                          };

                                          db
                                              .collection('cart ${userId}')
                                              .doc('${prodname}')
                                              .set(addproductdata);
                                        } else if (docdata?['Quantity'] ==
                                            '0') {
                                          var addproductdata =
                                              <String, dynamic>{
                                            "Name": "${prodname}",
                                            "Weight": "${prodweight}",
                                            "Price": "${prodprice}",
                                            "Image": "${prodimage}",
                                            "Quantity": "1"
                                          };

                                          db
                                              .collection('cart ${userId}')
                                              .doc('${prodname}')
                                              .set(addproductdata);
                                        } else {
                                          var newquantity =
                                              int.parse(docdata?['Quantity']) +
                                                  1;
                                          var addproductdata =
                                              <String, dynamic>{
                                            "Quantity": "${newquantity}"
                                          };

                                          db
                                              .collection('cart ${userId}')
                                              .doc('${prodname}')
                                              .set(addproductdata,
                                                  SetOptions(merge: true));
                                        }
                                      });
                                    },
                                    child: Text(
                                      'ADD',
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 31, 89, 41),
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
              if (snapshot.connectionState == ConnectionState.done) {
                if (!snapshot.hasData) {
                  return Center(
                    child: const Text(''),
                  );
                }
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
          FirestoreSearchResults.builder(
            tag: 'mainsearch',
            firestoreCollectionName: 'dairy',
            searchBy: 'Name',
            dataListFromSnapshot: DataModel().dataListFromSnapshot,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final List<DataModel>? dataList = snapshot.data;
                if (dataList!.isEmpty) {
                  return const Center(
                    child: Text('No More Results Found'),
                  );
                }
                return GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10.0,
                    childAspectRatio: MediaQuery.of(context).size.width / 700,
                  ),
                  shrinkWrap: true,
                  itemCount: dataList.length,
                  itemBuilder: (context, index) {
                    final DataModel data = dataList[index];

                    return Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              color: Color.fromARGB(255, 112, 112, 112),
                              width: 0.5),
                          right: BorderSide(
                              color: Color.fromARGB(255, 112, 112, 112),
                              width: 0.5),
                        ),
                      ),
                      child: InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 28, right: 11, left: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.network(
                                data.Image!,
                                width: 75,
                              ),
                              Text(
                                '${data.Name}',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 114, 114, 114),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  '${data.Weight}',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 114, 114, 114),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '₹${data.Price}',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Color.fromARGB(255, 31, 89, 41),
                                        fontWeight: FontWeight.bold),
                                  ),
                                  OutlinedButton(
                                    onPressed: () async {
                                      var userId = FirebaseAuth
                                          .instance.currentUser!.uid;

                                      var docRef = db
                                          .collection('cart ${userId}')
                                          .doc('${data.Name}');
                                      String prodname = data.Name!;
                                      String prodweight = data.Weight!;
                                      String prodprice = data.Price!;
                                      String prodimage = data.Image!;
                                      docRef.get().then((DocumentSnapshot doc) {
                                        final docdata =
                                            doc.data() as Map<String, dynamic>?;
                                        if (docdata?['Quantity'] == null) {
                                          var addproductdata =
                                              <String, dynamic>{
                                            "Name": "${prodname}",
                                            "Weight": "${prodweight}",
                                            "Price": "${prodprice}",
                                            "Image": "${prodimage}",
                                            "Quantity": "1"
                                          };

                                          db
                                              .collection('cart ${userId}')
                                              .doc('${prodname}')
                                              .set(addproductdata);
                                        } else if (docdata?['Quantity'] ==
                                            '0') {
                                          var addproductdata =
                                              <String, dynamic>{
                                            "Name": "${prodname}",
                                            "Weight": "${prodweight}",
                                            "Price": "${prodprice}",
                                            "Image": "${prodimage}",
                                            "Quantity": "1"
                                          };

                                          db
                                              .collection('cart ${userId}')
                                              .doc('${prodname}')
                                              .set(addproductdata);
                                        } else {
                                          var newquantity =
                                              int.parse(docdata?['Quantity']) +
                                                  1;
                                          var addproductdata =
                                              <String, dynamic>{
                                            "Quantity": "${newquantity}"
                                          };

                                          db
                                              .collection('cart ${userId}')
                                              .doc('${prodname}')
                                              .set(addproductdata,
                                                  SetOptions(merge: true));
                                        }
                                      });
                                    },
                                    child: Text(
                                      'ADD',
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 31, 89, 41),
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
              if (snapshot.connectionState == ConnectionState.done) {
                if (!snapshot.hasData) {
                  return Center(
                    child: const Text(''),
                  );
                }
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
          FirestoreSearchResults.builder(
            tag: 'mainsearch',
            firestoreCollectionName: 'munchies',
            searchBy: 'Name',
            dataListFromSnapshot: DataModel().dataListFromSnapshot,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final List<DataModel>? dataList = snapshot.data;
                if (dataList!.isEmpty) {
                  return const Center(
                    child: Text(''),
                  );
                }
                return GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10.0,
                    childAspectRatio: MediaQuery.of(context).size.width / 700,
                  ),
                  shrinkWrap: true,
                  itemCount: dataList.length,
                  itemBuilder: (context, index) {
                    final DataModel data = dataList[index];

                    return Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              color: Color.fromARGB(255, 112, 112, 112),
                              width: 0.5),
                          right: BorderSide(
                              color: Color.fromARGB(255, 112, 112, 112),
                              width: 0.5),
                        ),
                      ),
                      child: InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 28, right: 11, left: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.network(
                                data.Image!,
                                width: 75,
                              ),
                              Text(
                                '${data.Name}',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 114, 114, 114),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  '${data.Weight}',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 114, 114, 114),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '₹${data.Price}',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Color.fromARGB(255, 31, 89, 41),
                                        fontWeight: FontWeight.bold),
                                  ),
                                  OutlinedButton(
                                    onPressed: () async {
                                      var userId = FirebaseAuth
                                          .instance.currentUser!.uid;

                                      var docRef = db
                                          .collection('cart ${userId}')
                                          .doc('${data.Name}');
                                      String prodname = data.Name!;
                                      String prodweight = data.Weight!;
                                      String prodprice = data.Price!;
                                      String prodimage = data.Image!;
                                      docRef.get().then((DocumentSnapshot doc) {
                                        final docdata =
                                            doc.data() as Map<String, dynamic>?;
                                        if (docdata?['Quantity'] == null) {
                                          var addproductdata =
                                              <String, dynamic>{
                                            "Name": "${prodname}",
                                            "Weight": "${prodweight}",
                                            "Price": "${prodprice}",
                                            "Image": "${prodimage}",
                                            "Quantity": "1"
                                          };

                                          db
                                              .collection('cart ${userId}')
                                              .doc('${prodname}')
                                              .set(addproductdata);
                                        } else if (docdata?['Quantity'] ==
                                            '0') {
                                          var addproductdata =
                                              <String, dynamic>{
                                            "Name": "${prodname}",
                                            "Weight": "${prodweight}",
                                            "Price": "${prodprice}",
                                            "Image": "${prodimage}",
                                            "Quantity": "1"
                                          };

                                          db
                                              .collection('cart ${userId}')
                                              .doc('${prodname}')
                                              .set(addproductdata);
                                        } else {
                                          var newquantity =
                                              int.parse(docdata?['Quantity']) +
                                                  1;
                                          var addproductdata =
                                              <String, dynamic>{
                                            "Quantity": "${newquantity}"
                                          };

                                          db
                                              .collection('cart ${userId}')
                                              .doc('${prodname}')
                                              .set(addproductdata,
                                                  SetOptions(merge: true));
                                        }
                                      });
                                    },
                                    child: Text(
                                      'ADD',
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 31, 89, 41),
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
              if (snapshot.connectionState == ConnectionState.done) {
                if (!snapshot.hasData) {
                  return Center(
                    child: const Text(''),
                  );
                }
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
          FirestoreSearchResults.builder(
            tag: 'mainsearch',
            firestoreCollectionName: 'dessert',
            searchBy: 'Name',
            dataListFromSnapshot: DataModel().dataListFromSnapshot,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final List<DataModel>? dataList = snapshot.data;
                if (dataList!.isEmpty) {
                  return const Center(
                    child: Text(''),
                  );
                }
                return GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10.0,
                    childAspectRatio: MediaQuery.of(context).size.width / 700,
                  ),
                  shrinkWrap: true,
                  itemCount: dataList.length,
                  itemBuilder: (context, index) {
                    final DataModel data = dataList[index];

                    return Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              color: Color.fromARGB(255, 112, 112, 112),
                              width: 0.5),
                          right: BorderSide(
                              color: Color.fromARGB(255, 112, 112, 112),
                              width: 0.5),
                        ),
                      ),
                      child: InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 28, right: 11, left: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.network(
                                data.Image!,
                                width: 75,
                              ),
                              Text(
                                '${data.Name}',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 114, 114, 114),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  '${data.Weight}',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 114, 114, 114),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '₹${data.Price}',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Color.fromARGB(255, 31, 89, 41),
                                        fontWeight: FontWeight.bold),
                                  ),
                                  OutlinedButton(
                                    onPressed: () async {
                                      var userId = FirebaseAuth
                                          .instance.currentUser!.uid;

                                      var docRef = db
                                          .collection('cart ${userId}')
                                          .doc('${data.Name}');
                                      String prodname = data.Name!;
                                      String prodweight = data.Weight!;
                                      String prodprice = data.Price!;
                                      String prodimage = data.Image!;
                                      docRef.get().then((DocumentSnapshot doc) {
                                        final docdata =
                                            doc.data() as Map<String, dynamic>?;
                                        if (docdata?['Quantity'] == null) {
                                          var addproductdata =
                                              <String, dynamic>{
                                            "Name": "${prodname}",
                                            "Weight": "${prodweight}",
                                            "Price": "${prodprice}",
                                            "Image": "${prodimage}",
                                            "Quantity": "1"
                                          };

                                          db
                                              .collection('cart ${userId}')
                                              .doc('${prodname}')
                                              .set(addproductdata);
                                        } else if (docdata?['Quantity'] ==
                                            '0') {
                                          var addproductdata =
                                              <String, dynamic>{
                                            "Name": "${prodname}",
                                            "Weight": "${prodweight}",
                                            "Price": "${prodprice}",
                                            "Image": "${prodimage}",
                                            "Quantity": "1"
                                          };

                                          db
                                              .collection('cart ${userId}')
                                              .doc('${prodname}')
                                              .set(addproductdata);
                                        } else {
                                          var newquantity =
                                              int.parse(docdata?['Quantity']) +
                                                  1;
                                          var addproductdata =
                                              <String, dynamic>{
                                            "Quantity": "${newquantity}"
                                          };

                                          db
                                              .collection('cart ${userId}')
                                              .doc('${prodname}')
                                              .set(addproductdata,
                                                  SetOptions(merge: true));
                                        }
                                      });
                                    },
                                    child: Text(
                                      'ADD',
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 31, 89, 41),
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
              if (snapshot.connectionState == ConnectionState.done) {
                if (!snapshot.hasData) {
                  return Center(
                    child: const Text(''),
                  );
                }
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
          FirestoreSearchResults.builder(
            tag: 'mainsearch',
            firestoreCollectionName: 'drinks',
            searchBy: 'Name',
            dataListFromSnapshot: DataModel().dataListFromSnapshot,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final List<DataModel>? dataList = snapshot.data;
                if (dataList!.isEmpty) {
                  return const Center(
                    child: Text(''),
                  );
                }
                return GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10.0,
                    childAspectRatio: MediaQuery.of(context).size.width / 700,
                  ),
                  shrinkWrap: true,
                  itemCount: dataList.length,
                  itemBuilder: (context, index) {
                    final DataModel data = dataList[index];

                    return Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              color: Color.fromARGB(255, 112, 112, 112),
                              width: 0.5),
                          right: BorderSide(
                              color: Color.fromARGB(255, 112, 112, 112),
                              width: 0.5),
                        ),
                      ),
                      child: InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 28, right: 11, left: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.network(
                                data.Image!,
                                width: 75,
                              ),
                              Text(
                                '${data.Name}',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 114, 114, 114),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  '${data.Weight}',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 114, 114, 114),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '₹${data.Price}',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Color.fromARGB(255, 31, 89, 41),
                                        fontWeight: FontWeight.bold),
                                  ),
                                  OutlinedButton(
                                    onPressed: () async {
                                      var userId = FirebaseAuth
                                          .instance.currentUser!.uid;

                                      var docRef = db
                                          .collection('cart ${userId}')
                                          .doc('${data.Name}');
                                      String prodname = data.Name!;
                                      String prodweight = data.Weight!;
                                      String prodprice = data.Price!;
                                      String prodimage = data.Image!;
                                      docRef.get().then((DocumentSnapshot doc) {
                                        final docdata =
                                            doc.data() as Map<String, dynamic>?;
                                        if (docdata?['Quantity'] == null) {
                                          var addproductdata =
                                              <String, dynamic>{
                                            "Name": "${prodname}",
                                            "Weight": "${prodweight}",
                                            "Price": "${prodprice}",
                                            "Image": "${prodimage}",
                                            "Quantity": "1"
                                          };

                                          db
                                              .collection('cart ${userId}')
                                              .doc('${prodname}')
                                              .set(addproductdata);
                                        } else if (docdata?['Quantity'] ==
                                            '0') {
                                          var addproductdata =
                                              <String, dynamic>{
                                            "Name": "${prodname}",
                                            "Weight": "${prodweight}",
                                            "Price": "${prodprice}",
                                            "Image": "${prodimage}",
                                            "Quantity": "1"
                                          };

                                          db
                                              .collection('cart ${userId}')
                                              .doc('${prodname}')
                                              .set(addproductdata);
                                        } else {
                                          var newquantity =
                                              int.parse(docdata?['Quantity']) +
                                                  1;
                                          var addproductdata =
                                              <String, dynamic>{
                                            "Quantity": "${newquantity}"
                                          };

                                          db
                                              .collection('cart ${userId}')
                                              .doc('${prodname}')
                                              .set(addproductdata,
                                                  SetOptions(merge: true));
                                        }
                                      });
                                    },
                                    child: Text(
                                      'ADD',
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 31, 89, 41),
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
              if (snapshot.connectionState == ConnectionState.done) {
                if (!snapshot.hasData) {
                  return Center(
                    child: const Text(''),
                  );
                }
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
          FirestoreSearchResults.builder(
            tag: 'mainsearch',
            firestoreCollectionName: 'tea',
            searchBy: 'Name',
            dataListFromSnapshot: DataModel().dataListFromSnapshot,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final List<DataModel>? dataList = snapshot.data;
                if (dataList!.isEmpty) {
                  return const Center(
                    child: Text(''),
                  );
                }
                return GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10.0,
                    childAspectRatio: MediaQuery.of(context).size.width / 700,
                  ),
                  shrinkWrap: true,
                  itemCount: dataList.length,
                  itemBuilder: (context, index) {
                    final DataModel data = dataList[index];

                    return Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              color: Color.fromARGB(255, 112, 112, 112),
                              width: 0.5),
                          right: BorderSide(
                              color: Color.fromARGB(255, 112, 112, 112),
                              width: 0.5),
                        ),
                      ),
                      child: InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 28, right: 11, left: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.network(
                                data.Image!,
                                width: 75,
                              ),
                              Text(
                                '${data.Name}',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 114, 114, 114),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  '${data.Weight}',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 114, 114, 114),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '₹${data.Price}',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Color.fromARGB(255, 31, 89, 41),
                                        fontWeight: FontWeight.bold),
                                  ),
                                  OutlinedButton(
                                    onPressed: () async {
                                      var userId = FirebaseAuth
                                          .instance.currentUser!.uid;

                                      var docRef = db
                                          .collection('cart ${userId}')
                                          .doc('${data.Name}');
                                      String prodname = data.Name!;
                                      String prodweight = data.Weight!;
                                      String prodprice = data.Price!;
                                      String prodimage = data.Image!;
                                      docRef.get().then((DocumentSnapshot doc) {
                                        final docdata =
                                            doc.data() as Map<String, dynamic>?;
                                        if (docdata?['Quantity'] == null) {
                                          var addproductdata =
                                              <String, dynamic>{
                                            "Name": "${prodname}",
                                            "Weight": "${prodweight}",
                                            "Price": "${prodprice}",
                                            "Image": "${prodimage}",
                                            "Quantity": "1"
                                          };

                                          db
                                              .collection('cart ${userId}')
                                              .doc('${prodname}')
                                              .set(addproductdata);
                                        } else if (docdata?['Quantity'] ==
                                            '0') {
                                          var addproductdata =
                                              <String, dynamic>{
                                            "Name": "${prodname}",
                                            "Weight": "${prodweight}",
                                            "Price": "${prodprice}",
                                            "Image": "${prodimage}",
                                            "Quantity": "1"
                                          };

                                          db
                                              .collection('cart ${userId}')
                                              .doc('${prodname}')
                                              .set(addproductdata);
                                        } else {
                                          var newquantity =
                                              int.parse(docdata?['Quantity']) +
                                                  1;
                                          var addproductdata =
                                              <String, dynamic>{
                                            "Quantity": "${newquantity}"
                                          };

                                          db
                                              .collection('cart ${userId}')
                                              .doc('${prodname}')
                                              .set(addproductdata,
                                                  SetOptions(merge: true));
                                        }
                                      });
                                    },
                                    child: Text(
                                      'ADD',
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 31, 89, 41),
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
              if (snapshot.connectionState == ConnectionState.done) {
                if (!snapshot.hasData) {
                  return Center(
                    child: const Text(''),
                  );
                }
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
          FirestoreSearchResults.builder(
            tag: 'mainsearch',
            firestoreCollectionName: 'rice',
            searchBy: 'Name',
            dataListFromSnapshot: DataModel().dataListFromSnapshot,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final List<DataModel>? dataList = snapshot.data;
                if (dataList!.isEmpty) {
                  return const Center(
                    child: Text(''),
                  );
                }
                return GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10.0,
                    childAspectRatio: MediaQuery.of(context).size.width / 700,
                  ),
                  shrinkWrap: true,
                  itemCount: dataList.length,
                  itemBuilder: (context, index) {
                    final DataModel data = dataList[index];

                    return Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              color: Color.fromARGB(255, 112, 112, 112),
                              width: 0.5),
                          right: BorderSide(
                              color: Color.fromARGB(255, 112, 112, 112),
                              width: 0.5),
                        ),
                      ),
                      child: InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 28, right: 11, left: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.network(
                                data.Image!,
                                width: 75,
                              ),
                              Text(
                                '${data.Name}',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 114, 114, 114),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  '${data.Weight}',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 114, 114, 114),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '₹${data.Price}',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Color.fromARGB(255, 31, 89, 41),
                                        fontWeight: FontWeight.bold),
                                  ),
                                  OutlinedButton(
                                    onPressed: () async {
                                      var userId = FirebaseAuth
                                          .instance.currentUser!.uid;

                                      var docRef = db
                                          .collection('cart ${userId}')
                                          .doc('${data.Name}');
                                      String prodname = data.Name!;
                                      String prodweight = data.Weight!;
                                      String prodprice = data.Price!;
                                      String prodimage = data.Image!;
                                      docRef.get().then((DocumentSnapshot doc) {
                                        final docdata =
                                            doc.data() as Map<String, dynamic>?;
                                        if (docdata?['Quantity'] == null) {
                                          var addproductdata =
                                              <String, dynamic>{
                                            "Name": "${prodname}",
                                            "Weight": "${prodweight}",
                                            "Price": "${prodprice}",
                                            "Image": "${prodimage}",
                                            "Quantity": "1"
                                          };

                                          db
                                              .collection('cart ${userId}')
                                              .doc('${prodname}')
                                              .set(addproductdata);
                                        } else if (docdata?['Quantity'] ==
                                            '0') {
                                          var addproductdata =
                                              <String, dynamic>{
                                            "Name": "${prodname}",
                                            "Weight": "${prodweight}",
                                            "Price": "${prodprice}",
                                            "Image": "${prodimage}",
                                            "Quantity": "1"
                                          };

                                          db
                                              .collection('cart ${userId}')
                                              .doc('${prodname}')
                                              .set(addproductdata);
                                        } else {
                                          var newquantity =
                                              int.parse(docdata?['Quantity']) +
                                                  1;
                                          var addproductdata =
                                              <String, dynamic>{
                                            "Quantity": "${newquantity}"
                                          };

                                          db
                                              .collection('cart ${userId}')
                                              .doc('${prodname}')
                                              .set(addproductdata,
                                                  SetOptions(merge: true));
                                        }
                                      });
                                    },
                                    child: Text(
                                      'ADD',
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 31, 89, 41),
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
              if (snapshot.connectionState == ConnectionState.done) {
                if (!snapshot.hasData) {
                  return Center(
                    child: const Text(''),
                  );
                }
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
          FirestoreSearchResults.builder(
            tag: 'mainsearch',
            firestoreCollectionName: 'oil',
            searchBy: 'Name',
            dataListFromSnapshot: DataModel().dataListFromSnapshot,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final List<DataModel>? dataList = snapshot.data;
                if (dataList!.isEmpty) {
                  return const Center(
                    child: Text(''),
                  );
                }
                return GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10.0,
                    childAspectRatio: MediaQuery.of(context).size.width / 700,
                  ),
                  shrinkWrap: true,
                  itemCount: dataList.length,
                  itemBuilder: (context, index) {
                    final DataModel data = dataList[index];

                    return Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              color: Color.fromARGB(255, 112, 112, 112),
                              width: 0.5),
                          right: BorderSide(
                              color: Color.fromARGB(255, 112, 112, 112),
                              width: 0.5),
                        ),
                      ),
                      child: InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 28, right: 11, left: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.network(
                                data.Image!,
                                width: 75,
                              ),
                              Text(
                                '${data.Name}',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 114, 114, 114),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  '${data.Weight}',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 114, 114, 114),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '₹${data.Price}',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Color.fromARGB(255, 31, 89, 41),
                                        fontWeight: FontWeight.bold),
                                  ),
                                  OutlinedButton(
                                    onPressed: () async {
                                      var userId = FirebaseAuth
                                          .instance.currentUser!.uid;

                                      var docRef = db
                                          .collection('cart ${userId}')
                                          .doc('${data.Name}');
                                      String prodname = data.Name!;
                                      String prodweight = data.Weight!;
                                      String prodprice = data.Price!;
                                      String prodimage = data.Image!;
                                      docRef.get().then((DocumentSnapshot doc) {
                                        final docdata =
                                            doc.data() as Map<String, dynamic>?;
                                        if (docdata?['Quantity'] == null) {
                                          var addproductdata =
                                              <String, dynamic>{
                                            "Name": "${prodname}",
                                            "Weight": "${prodweight}",
                                            "Price": "${prodprice}",
                                            "Image": "${prodimage}",
                                            "Quantity": "1"
                                          };

                                          db
                                              .collection('cart ${userId}')
                                              .doc('${prodname}')
                                              .set(addproductdata);
                                        } else if (docdata?['Quantity'] ==
                                            '0') {
                                          var addproductdata =
                                              <String, dynamic>{
                                            "Name": "${prodname}",
                                            "Weight": "${prodweight}",
                                            "Price": "${prodprice}",
                                            "Image": "${prodimage}",
                                            "Quantity": "1"
                                          };

                                          db
                                              .collection('cart ${userId}')
                                              .doc('${prodname}')
                                              .set(addproductdata);
                                        } else {
                                          var newquantity =
                                              int.parse(docdata?['Quantity']) +
                                                  1;
                                          var addproductdata =
                                              <String, dynamic>{
                                            "Quantity": "${newquantity}"
                                          };

                                          db
                                              .collection('cart ${userId}')
                                              .doc('${prodname}')
                                              .set(addproductdata,
                                                  SetOptions(merge: true));
                                        }
                                      });
                                    },
                                    child: Text(
                                      'ADD',
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 31, 89, 41),
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
              if (snapshot.connectionState == ConnectionState.done) {
                if (!snapshot.hasData) {
                  return Center(
                    child: const Text(''),
                  );
                }
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
          FirestoreSearchResults.builder(
            tag: 'mainsearch',
            firestoreCollectionName: 'babycare',
            searchBy: 'Name',
            dataListFromSnapshot: DataModel().dataListFromSnapshot,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final List<DataModel>? dataList = snapshot.data;
                if (dataList!.isEmpty) {
                  return const Center(
                    child: Text(''),
                  );
                }
                return GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10.0,
                    childAspectRatio: MediaQuery.of(context).size.width / 700,
                  ),
                  shrinkWrap: true,
                  itemCount: dataList.length,
                  itemBuilder: (context, index) {
                    final DataModel data = dataList[index];

                    return Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              color: Color.fromARGB(255, 112, 112, 112),
                              width: 0.5),
                          right: BorderSide(
                              color: Color.fromARGB(255, 112, 112, 112),
                              width: 0.5),
                        ),
                      ),
                      child: InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 28, right: 11, left: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.network(
                                data.Image!,
                                width: 75,
                              ),
                              Text(
                                '${data.Name}',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 114, 114, 114),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  '${data.Weight}',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 114, 114, 114),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '₹${data.Price}',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Color.fromARGB(255, 31, 89, 41),
                                        fontWeight: FontWeight.bold),
                                  ),
                                  OutlinedButton(
                                    onPressed: () async {
                                      var userId = FirebaseAuth
                                          .instance.currentUser!.uid;

                                      var docRef = db
                                          .collection('cart ${userId}')
                                          .doc('${data.Name}');
                                      String prodname = data.Name!;
                                      String prodweight = data.Weight!;
                                      String prodprice = data.Price!;
                                      String prodimage = data.Image!;
                                      docRef.get().then((DocumentSnapshot doc) {
                                        final docdata =
                                            doc.data() as Map<String, dynamic>?;
                                        if (docdata?['Quantity'] == null) {
                                          var addproductdata =
                                              <String, dynamic>{
                                            "Name": "${prodname}",
                                            "Weight": "${prodweight}",
                                            "Price": "${prodprice}",
                                            "Image": "${prodimage}",
                                            "Quantity": "1"
                                          };

                                          db
                                              .collection('cart ${userId}')
                                              .doc('${prodname}')
                                              .set(addproductdata);
                                        } else if (docdata?['Quantity'] ==
                                            '0') {
                                          var addproductdata =
                                              <String, dynamic>{
                                            "Name": "${prodname}",
                                            "Weight": "${prodweight}",
                                            "Price": "${prodprice}",
                                            "Image": "${prodimage}",
                                            "Quantity": "1"
                                          };

                                          db
                                              .collection('cart ${userId}')
                                              .doc('${prodname}')
                                              .set(addproductdata);
                                        } else {
                                          var newquantity =
                                              int.parse(docdata?['Quantity']) +
                                                  1;
                                          var addproductdata =
                                              <String, dynamic>{
                                            "Quantity": "${newquantity}"
                                          };

                                          db
                                              .collection('cart ${userId}')
                                              .doc('${prodname}')
                                              .set(addproductdata,
                                                  SetOptions(merge: true));
                                        }
                                      });
                                    },
                                    child: Text(
                                      'ADD',
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 31, 89, 41),
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
              if (snapshot.connectionState == ConnectionState.done) {
                if (!snapshot.hasData) {
                  return Center(
                    child: const Text(''),
                  );
                }
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
          FirestoreSearchResults.builder(
            tag: 'mainsearch',
            firestoreCollectionName: 'meat',
            searchBy: 'Name',
            dataListFromSnapshot: DataModel().dataListFromSnapshot,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final List<DataModel>? dataList = snapshot.data;
                if (dataList!.isEmpty) {
                  return const Center(
                    child: Text(''),
                  );
                }
                return GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10.0,
                    childAspectRatio: MediaQuery.of(context).size.width / 700,
                  ),
                  shrinkWrap: true,
                  itemCount: dataList.length,
                  itemBuilder: (context, index) {
                    final DataModel data = dataList[index];

                    return Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              color: Color.fromARGB(255, 112, 112, 112),
                              width: 0.5),
                          right: BorderSide(
                              color: Color.fromARGB(255, 112, 112, 112),
                              width: 0.5),
                        ),
                      ),
                      child: InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 28, right: 11, left: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.network(
                                data.Image!,
                                width: 75,
                              ),
                              Text(
                                '${data.Name}',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 114, 114, 114),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  '${data.Weight}',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 114, 114, 114),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '₹${data.Price}',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Color.fromARGB(255, 31, 89, 41),
                                        fontWeight: FontWeight.bold),
                                  ),
                                  OutlinedButton(
                                    onPressed: () async {
                                      var userId = FirebaseAuth
                                          .instance.currentUser!.uid;

                                      var docRef = db
                                          .collection('cart ${userId}')
                                          .doc('${data.Name}');
                                      String prodname = data.Name!;
                                      String prodweight = data.Weight!;
                                      String prodprice = data.Price!;
                                      String prodimage = data.Image!;
                                      docRef.get().then((DocumentSnapshot doc) {
                                        final docdata =
                                            doc.data() as Map<String, dynamic>?;
                                        if (docdata?['Quantity'] == null) {
                                          var addproductdata =
                                              <String, dynamic>{
                                            "Name": "${prodname}",
                                            "Weight": "${prodweight}",
                                            "Price": "${prodprice}",
                                            "Image": "${prodimage}",
                                            "Quantity": "1"
                                          };

                                          db
                                              .collection('cart ${userId}')
                                              .doc('${prodname}')
                                              .set(addproductdata);
                                        } else if (docdata?['Quantity'] ==
                                            '0') {
                                          var addproductdata =
                                              <String, dynamic>{
                                            "Name": "${prodname}",
                                            "Weight": "${prodweight}",
                                            "Price": "${prodprice}",
                                            "Image": "${prodimage}",
                                            "Quantity": "1"
                                          };

                                          db
                                              .collection('cart ${userId}')
                                              .doc('${prodname}')
                                              .set(addproductdata);
                                        } else {
                                          var newquantity =
                                              int.parse(docdata?['Quantity']) +
                                                  1;
                                          var addproductdata =
                                              <String, dynamic>{
                                            "Quantity": "${newquantity}"
                                          };

                                          db
                                              .collection('cart ${userId}')
                                              .doc('${prodname}')
                                              .set(addproductdata,
                                                  SetOptions(merge: true));
                                        }
                                      });
                                    },
                                    child: Text(
                                      'ADD',
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 31, 89, 41),
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
              if (snapshot.connectionState == ConnectionState.done) {
                if (!snapshot.hasData) {
                  return Center(
                    child: const Text(''),
                  );
                }
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
          FirestoreSearchResults.builder(
            tag: 'mainsearch',
            firestoreCollectionName: 'cleaning',
            searchBy: 'Name',
            dataListFromSnapshot: DataModel().dataListFromSnapshot,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final List<DataModel>? dataList = snapshot.data;
                if (dataList!.isEmpty) {
                  return const Center(
                    child: Text(''),
                  );
                }
                return GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10.0,
                    childAspectRatio: MediaQuery.of(context).size.width / 700,
                  ),
                  shrinkWrap: true,
                  itemCount: dataList.length,
                  itemBuilder: (context, index) {
                    final DataModel data = dataList[index];

                    return Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              color: Color.fromARGB(255, 112, 112, 112),
                              width: 0.5),
                          right: BorderSide(
                              color: Color.fromARGB(255, 112, 112, 112),
                              width: 0.5),
                        ),
                      ),
                      child: InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 28, right: 11, left: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.network(
                                data.Image!,
                                width: 75,
                              ),
                              Text(
                                '${data.Name}',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 114, 114, 114),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  '${data.Weight}',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 114, 114, 114),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '₹${data.Price}',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Color.fromARGB(255, 31, 89, 41),
                                        fontWeight: FontWeight.bold),
                                  ),
                                  OutlinedButton(
                                    onPressed: () async {
                                      var userId = FirebaseAuth
                                          .instance.currentUser!.uid;

                                      var docRef = db
                                          .collection('cart ${userId}')
                                          .doc('${data.Name}');
                                      String prodname = data.Name!;
                                      String prodweight = data.Weight!;
                                      String prodprice = data.Price!;
                                      String prodimage = data.Image!;
                                      docRef.get().then((DocumentSnapshot doc) {
                                        final docdata =
                                            doc.data() as Map<String, dynamic>?;
                                        if (docdata?['Quantity'] == null) {
                                          var addproductdata =
                                              <String, dynamic>{
                                            "Name": "${prodname}",
                                            "Weight": "${prodweight}",
                                            "Price": "${prodprice}",
                                            "Image": "${prodimage}",
                                            "Quantity": "1"
                                          };

                                          db
                                              .collection('cart ${userId}')
                                              .doc('${prodname}')
                                              .set(addproductdata);
                                        } else if (docdata?['Quantity'] ==
                                            '0') {
                                          var addproductdata =
                                              <String, dynamic>{
                                            "Name": "${prodname}",
                                            "Weight": "${prodweight}",
                                            "Price": "${prodprice}",
                                            "Image": "${prodimage}",
                                            "Quantity": "1"
                                          };

                                          db
                                              .collection('cart ${userId}')
                                              .doc('${prodname}')
                                              .set(addproductdata);
                                        } else {
                                          var newquantity =
                                              int.parse(docdata?['Quantity']) +
                                                  1;
                                          var addproductdata =
                                              <String, dynamic>{
                                            "Quantity": "${newquantity}"
                                          };

                                          db
                                              .collection('cart ${userId}')
                                              .doc('${prodname}')
                                              .set(addproductdata,
                                                  SetOptions(merge: true));
                                        }
                                      });
                                    },
                                    child: Text(
                                      'ADD',
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 31, 89, 41),
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
              if (snapshot.connectionState == ConnectionState.done) {
                if (!snapshot.hasData) {
                  return Center(
                    child: const Text(''),
                  );
                }
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
          FirestoreSearchResults.builder(
            tag: 'mainsearch',
            firestoreCollectionName: 'personalhygiene',
            searchBy: 'Name',
            dataListFromSnapshot: DataModel().dataListFromSnapshot,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final List<DataModel>? dataList = snapshot.data;
                if (dataList!.isEmpty) {
                  return const Center(
                    child: Text(''),
                  );
                }
                return GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10.0,
                    childAspectRatio: MediaQuery.of(context).size.width / 700,
                  ),
                  shrinkWrap: true,
                  itemCount: dataList.length,
                  itemBuilder: (context, index) {
                    final DataModel data = dataList[index];

                    return Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              color: Color.fromARGB(255, 112, 112, 112),
                              width: 0.5),
                          right: BorderSide(
                              color: Color.fromARGB(255, 112, 112, 112),
                              width: 0.5),
                        ),
                      ),
                      child: InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 28, right: 11, left: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.network(
                                data.Image!,
                                width: 75,
                              ),
                              Text(
                                '${data.Name}',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 114, 114, 114),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  '${data.Weight}',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 114, 114, 114),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '₹${data.Price}',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Color.fromARGB(255, 31, 89, 41),
                                        fontWeight: FontWeight.bold),
                                  ),
                                  OutlinedButton(
                                    onPressed: () async {
                                      var userId = FirebaseAuth
                                          .instance.currentUser!.uid;

                                      var docRef = db
                                          .collection('cart ${userId}')
                                          .doc('${data.Name}');
                                      String prodname = data.Name!;
                                      String prodweight = data.Weight!;
                                      String prodprice = data.Price!;
                                      String prodimage = data.Image!;
                                      docRef.get().then((DocumentSnapshot doc) {
                                        final docdata =
                                            doc.data() as Map<String, dynamic>?;
                                        if (docdata?['Quantity'] == null) {
                                          var addproductdata =
                                              <String, dynamic>{
                                            "Name": "${prodname}",
                                            "Weight": "${prodweight}",
                                            "Price": "${prodprice}",
                                            "Image": "${prodimage}",
                                            "Quantity": "1"
                                          };

                                          db
                                              .collection('cart ${userId}')
                                              .doc('${prodname}')
                                              .set(addproductdata);
                                        } else if (docdata?['Quantity'] ==
                                            '0') {
                                          var addproductdata =
                                              <String, dynamic>{
                                            "Name": "${prodname}",
                                            "Weight": "${prodweight}",
                                            "Price": "${prodprice}",
                                            "Image": "${prodimage}",
                                            "Quantity": "1"
                                          };

                                          db
                                              .collection('cart ${userId}')
                                              .doc('${prodname}')
                                              .set(addproductdata);
                                        } else {
                                          var newquantity =
                                              int.parse(docdata?['Quantity']) +
                                                  1;
                                          var addproductdata =
                                              <String, dynamic>{
                                            "Quantity": "${newquantity}"
                                          };

                                          db
                                              .collection('cart ${userId}')
                                              .doc('${prodname}')
                                              .set(addproductdata,
                                                  SetOptions(merge: true));
                                        }
                                      });
                                    },
                                    child: Text(
                                      'ADD',
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 31, 89, 41),
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
              if (snapshot.connectionState == ConnectionState.done) {
                if (!snapshot.hasData) {
                  return Center(
                    child: const Text(''),
                  );
                }
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ],
      ),
    );
  }
}
