import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:indexed/indexed.dart';
import 'package:yans/screens/screens.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

var streambuild;
ValueNotifier<int> _controller = ValueNotifier<int>(0);

class GroceryProductListScreen extends StatefulWidget {
  static const String routeName = '/groceryproductlist';
  final String category;

  const GroceryProductListScreen({super.key, required this.category});

  static Route route({required String category}) {
    return MaterialPageRoute(
        builder: (_) => GroceryProductListScreen(category: category),
        settings: RouteSettings(name: routeName));
  }

  @override
  State<GroceryProductListScreen> createState() =>
      _GroceryProductListScreenState();
}

class _GroceryProductListScreenState extends State<GroceryProductListScreen> {
  late Future<ListResult> futureFiles;

  var stream;
  var catname;

  void FetchCat() {
    if (widget.category == 'fruits') {
      stream = db.collection('fruits').snapshots();
      streambuild = db.collection('fruits').snapshots();
      catname = 'Fruits & Vegetables';
    } else if (widget.category == 'dairy') {
      stream = db.collection('dairy').snapshots();
      streambuild = db.collection('dairy').snapshots();
      catname = 'Dairy, Bread & Eggs';
    } else if (widget.category == 'munchies') {
      stream = db.collection('munchies').snapshots();
      streambuild = db.collection('munchies').snapshots();
      catname = 'Munchies';
    } else if (widget.category == 'dessert') {
      stream = db.collection('dessert').snapshots();
      streambuild = db.collection('dessert').snapshots();
      catname = 'Dessert';
    } else if (widget.category == 'drinks') {
      stream = db.collection('drinks').snapshots();
      streambuild = db.collection('drinks').snapshots();
      catname = 'Drinks';
    } else if (widget.category == 'tea') {
      stream = db.collection('tea').snapshots();
      streambuild = db.collection('tea').snapshots();
      catname = 'Tea & Coffee';
    } else if (widget.category == 'rice') {
      stream = db.collection('rice').snapshots();
      streambuild = db.collection('rice').snapshots();
      catname = 'Rice, Atta & Dal';
    } else if (widget.category == 'oil') {
      stream = db.collection('oil').snapshots();
      streambuild = db.collection('oil').snapshots();
      catname = 'Oil';
    } else if (widget.category == 'meat') {
      stream = db.collection('meat').snapshots();
      streambuild = db.collection('meat').snapshots();
      catname = 'Meat';
    } else if (widget.category == 'cleaning') {
      stream = db.collection('cleaning').snapshots();
      streambuild = db.collection('cleaning').snapshots();
      catname = 'Cleaning Essentials';
    } else if (widget.category == 'personalhygiene') {
      stream = db.collection('personalhygiene').snapshots();
      streambuild = db.collection('personalhygiene').snapshots();
      catname = 'Personal Hygiene';
    } else if (widget.category == 'babycare') {
      stream = db.collection('babycare').snapshots();
      streambuild = db.collection('babycare').snapshots();
      catname = 'Babycare';
    }
  }

  OverlayEntry? entry;

  void showCart() {
    entry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 50,
        left: 0,
        right: 0,
        child: SizedBox(
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(context, CartScreen.route());
            },
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    Color.fromARGB(255, 55, 107, 64))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'View Cart',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Icon(Icons.shopping_cart_rounded),
              ],
            ),
          ),
        ),
      ),
    );

    final overlay = Overlay.of(context)!;
    overlay.insert(entry!);
  }

  @override
  void dispose() {
    if (entry != null) {
      entry!.remove();
    }

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    FetchCat();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Color.fromARGB(255, 31, 89, 41),
          onPressed: () {
            Navigator.pushNamed(context, '/cart');
          },
          label: Row(
            children: [
              Icon(Icons.shopping_cart),
              Text('View Cart'),
            ],
          )),
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
      body: StreamBuilder<QuerySnapshot>(
          stream: stream,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text('An Error Occured');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return Indexer(
              clipBehavior: Clip.none,
              children: [
                Indexed(
                  index: 100,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 242, 242, 242),
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromARGB(29, 0, 0, 0),
                            offset: const Offset(0, 3),
                            blurRadius: 6),
                      ],
                    ),
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 40, bottom: 15, right: 17, left: 17),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              BackButton(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        '${catname}',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 7,
                                      ),
                                      Text(
                                        '(${snapshot.data!.docs.length} items)',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Color.fromARGB(
                                              255, 114, 114, 114),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    'All Categories',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 31, 89, 41),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context, GrocerySearchScreen.route());
                              },
                              child: Icon(Icons.search),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Indexed(
                  index: 99,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Row(
                      children: [
                        SideBar(catname: widget.category),
                        Container(
                          height: MediaQuery.of(context).size.height - 85,
                          width: MediaQuery.of(context).size.width - 75,
                          child: ProductListView(
                            parameter: '${widget.category}',
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            );
          }), //Main Column
    );
  }
}

class SideBar extends StatelessWidget {
  const SideBar({
    Key? key,
    required this.catname,
  }) : super(key: key);

  final catname;

  @override
  Widget build(BuildContext context) {
    if (catname == 'fruits') {
      return Container(
        width: 75,
        height: MediaQuery.of(context).size.height - 100,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 235, 235, 235),
          boxShadow: [
            BoxShadow(
                color: Color.fromARGB(29, 0, 0, 0),
                offset: const Offset(0, 3),
                blurRadius: 6),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 23,
            ),
            InkWell(
              onTap: () {
                streambuild = db
                    .collection('${catname}')
                    .where('tags', isGreaterThanOrEqualTo: 'Fruits')
                    .snapshots();
                _controller.value += 1;
              },
              child: Image.asset(
                'assets/freshvegetables.png',
                width: 55,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              'Fresh Vegetables',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 114, 114, 114),
              ),
            ),
            SizedBox(height: 35),
            InkWell(
                onTap: () {
                  streambuild = db
                      .collection('${catname}')
                      .where('tags', isGreaterThanOrEqualTo: 'Fruits')
                      .snapshots();
                  _controller.value += 1;
                },
                child: Image.asset(
                  'assets/freshfruits.png',
                  width: 55,
                )),
            SizedBox(
              height: 5,
            ),
            Text(
              'Fresh Fruits',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 114, 114, 114),
              ),
            ),
            SizedBox(
              height: 35,
            ),
            InkWell(
                onTap: () {
                  streambuild = db
                      .collection('${catname}')
                      .where('tags', isGreaterThanOrEqualTo: 'Leafys')
                      .snapshots();
                  _controller.value += 1;
                },
                child: Image.asset(
                  'assets/leafysandseasonings.png',
                  width: 55,
                )),
            SizedBox(
              height: 5,
            ),
            Text(
              'Leafys And Seasonings',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 114, 114, 114),
              ),
            ),
            SizedBox(
              height: 35,
            ),
            InkWell(
                onTap: () {
                  streambuild = db
                      .collection('${catname}')
                      .where('tags', isGreaterThanOrEqualTo: 'Exotic')
                      .snapshots();
                  _controller.value += 1;
                },
                child: Image.asset(
                  'assets/exotic.png',
                  width: 55,
                )),
            SizedBox(
              height: 5,
            ),
            Text(
              'Exotic',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 114, 114, 114),
              ),
            ),
            SizedBox(
              height: 35,
            ),
            InkWell(
                onTap: () {
                  streambuild = db
                      .collection('${catname}')
                      .where('tags', isGreaterThanOrEqualTo: 'Organic')
                      .snapshots();
                  _controller.value += 1;
                },
                child: Image.asset(
                  'assets/organic.png',
                  width: 55,
                )),
            SizedBox(
              height: 5,
            ),
            Text(
              'Organic',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 114, 114, 114),
              ),
            ),
          ],
        ),
      );
    } else if (catname == 'dairy') {
      return Container(
        width: 75,
        height: MediaQuery.of(context).size.height - 100,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 235, 235, 235),
          boxShadow: [
            BoxShadow(
                color: Color.fromARGB(29, 0, 0, 0),
                offset: const Offset(0, 3),
                blurRadius: 6),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 23,
            ),
            InkWell(
              onTap: () {
                streambuild = db
                    .collection('${catname}')
                    .where('tags', isGreaterThanOrEqualTo: 'Milk')
                    .snapshots();
                _controller.value += 1;
              },
              child: Image.asset(
                'assets/milk.png',
                width: 55,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              'Milk',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 114, 114, 114),
              ),
            ),
            SizedBox(height: 35),
            InkWell(
                onTap: () {
                  streambuild = db
                      .collection('${catname}')
                      .where('tags', isGreaterThanOrEqualTo: 'Bread')
                      .snapshots();
                  _controller.value += 1;
                },
                child: Image.asset(
                  'assets/breadandbuns.png',
                  width: 55,
                )),
            SizedBox(
              height: 5,
            ),
            Text(
              'Bread and Buns',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 114, 114, 114),
              ),
            ),
            SizedBox(
              height: 35,
            ),
            InkWell(
                onTap: () {
                  streambuild = db
                      .collection('${catname}')
                      .where('tags', isGreaterThanOrEqualTo: 'Egg')
                      .snapshots();
                  _controller.value += 1;
                },
                child: Image.asset(
                  'assets/egg.png',
                  width: 55,
                )),
            SizedBox(
              height: 5,
            ),
            Text(
              'Eggs',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 114, 114, 114),
              ),
            ),
            SizedBox(
              height: 35,
            ),
            InkWell(
                onTap: () {
                  streambuild = db
                      .collection('${catname}')
                      .where('tags', isGreaterThanOrEqualTo: 'Butter')
                      .snapshots();
                  _controller.value += 1;
                },
                child: Image.asset(
                  'assets/butterandcheese.png',
                  width: 55,
                )),
            SizedBox(
              height: 5,
            ),
            Text(
              'Butter and Cheese',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 114, 114, 114),
              ),
            ),
            SizedBox(
              height: 35,
            ),
            InkWell(
                onTap: () {
                  streambuild = db
                      .collection('${catname}')
                      .where('tags', isGreaterThanOrEqualTo: 'Curd')
                      .snapshots();
                  _controller.value += 1;
                },
                child: Image.asset(
                  'assets/curd.png',
                  width: 55,
                )),
            SizedBox(
              height: 5,
            ),
            Text(
              'Curd',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 114, 114, 114),
              ),
            ),
          ],
        ),
      );
    } else if (catname == 'munchies') {
      return Container(
        width: 75,
        height: MediaQuery.of(context).size.height - 100,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 235, 235, 235),
          boxShadow: [
            BoxShadow(
                color: Color.fromARGB(29, 0, 0, 0),
                offset: const Offset(0, 3),
                blurRadius: 6),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 23,
            ),
            InkWell(
              onTap: () {
                streambuild = db
                    .collection('${catname}')
                    .where('tags', isGreaterThanOrEqualTo: 'Chips')
                    .snapshots();
                _controller.value += 1;
              },
              child: Image.asset(
                'assets/chips.png',
                width: 55,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              'Chips',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 114, 114, 114),
              ),
            ),
            SizedBox(height: 35),
            InkWell(
                onTap: () {
                  streambuild = db
                      .collection('${catname}')
                      .where('tags', isGreaterThanOrEqualTo: 'Namkeen')
                      .snapshots();
                  _controller.value += 1;
                },
                child: Image.asset(
                  'assets/namkeen.png',
                  width: 55,
                )),
            SizedBox(
              height: 5,
            ),
            Text(
              'Namkeen',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 114, 114, 114),
              ),
            ),
            SizedBox(
              height: 35,
            ),
            InkWell(
                onTap: () {
                  streambuild = db
                      .collection('${catname}')
                      .where('tags', isGreaterThanOrEqualTo: 'Popcorn')
                      .snapshots();
                  _controller.value += 1;
                },
                child: Image.asset(
                  'assets/popcorncategory.png',
                  width: 55,
                )),
            SizedBox(
              height: 5,
            ),
            Text(
              'Popcorn',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 114, 114, 114),
              ),
            ),
            SizedBox(
              height: 35,
            ),
            InkWell(
                onTap: () {
                  streambuild = db
                      .collection('${catname}')
                      .where('tags', isGreaterThanOrEqualTo: 'Frozen')
                      .snapshots();
                  _controller.value += 1;
                },
                child: Image.asset(
                  'assets/frozenmunchiescategory.png',
                  width: 55,
                )),
            SizedBox(
              height: 5,
            ),
            Text(
              'Frozen Munchies',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 114, 114, 114),
              ),
            ),
            SizedBox(
              height: 35,
            ),
            InkWell(
                onTap: () {
                  streambuild = db
                      .collection('${catname}')
                      .where('tags', isGreaterThanOrEqualTo: 'Value Pack')
                      .snapshots();
                  _controller.value += 1;
                },
                child: Image.asset(
                  'assets/valuepack.png',
                  width: 55,
                )),
            SizedBox(
              height: 5,
            ),
            Text(
              'Value Pack',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 114, 114, 114),
              ),
            ),
          ],
        ),
      );
    }
    if (catname == 'dessert') {
      return Container(
        width: 75,
        height: MediaQuery.of(context).size.height - 100,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 235, 235, 235),
          boxShadow: [
            BoxShadow(
                color: Color.fromARGB(29, 0, 0, 0),
                offset: const Offset(0, 3),
                blurRadius: 6),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 23,
            ),
            InkWell(
              onTap: () {
                streambuild = db
                    .collection('${catname}')
                    .where('tags', isGreaterThanOrEqualTo: 'Ice Cream')
                    .snapshots();
                _controller.value += 1;
              },
              child: Image.asset(
                'assets/icecream.png',
                width: 55,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              'Ice Cream',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 114, 114, 114),
              ),
            ),
            SizedBox(height: 35),
            InkWell(
                onTap: () {
                  streambuild = db
                      .collection('${catname}')
                      .where('tags', isGreaterThanOrEqualTo: 'Chocolates')
                      .snapshots();
                  _controller.value += 1;
                },
                child: Image.asset(
                  'assets/chocolates.png',
                  width: 55,
                )),
            SizedBox(
              height: 5,
            ),
            Text(
              'Chocolates',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 114, 114, 114),
              ),
            ),
            SizedBox(
              height: 35,
            ),
            InkWell(
                onTap: () {
                  streambuild = db
                      .collection('${catname}')
                      .where('tags', isGreaterThanOrEqualTo: 'Sweets')
                      .snapshots();
                  _controller.value += 1;
                },
                child: Image.asset(
                  'assets/sweets.png',
                  width: 55,
                )),
            SizedBox(
              height: 5,
            ),
            Text(
              'Sweets',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 114, 114, 114),
              ),
            ),
            SizedBox(
              height: 35,
            ),
            InkWell(
                onTap: () {
                  streambuild = db
                      .collection('${catname}')
                      .where('tags', isGreaterThanOrEqualTo: 'Cookies')
                      .snapshots();
                  _controller.value += 1;
                },
                child: Image.asset(
                  'assets/cookiesandcakes.png',
                  width: 55,
                )),
            SizedBox(
              height: 5,
            ),
            Text(
              'Cookies and Cakes',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 114, 114, 114),
              ),
            ),
            SizedBox(
              height: 35,
            ),
            InkWell(
                onTap: () {
                  streambuild = db
                      .collection('${catname}')
                      .where('tags', isGreaterThanOrEqualTo: 'Candies')
                      .snapshots();
                  _controller.value += 1;
                },
                child: Image.asset(
                  'assets/candiesandgums.png',
                  width: 55,
                )),
            SizedBox(
              height: 5,
            ),
            Text(
              'Candies and Gums',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 114, 114, 114),
              ),
            ),
          ],
        ),
      );
    } else if (catname == 'drinks') {
      return Container(
        width: 75,
        height: MediaQuery.of(context).size.height - 100,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 235, 235, 235),
          boxShadow: [
            BoxShadow(
                color: Color.fromARGB(29, 0, 0, 0),
                offset: const Offset(0, 3),
                blurRadius: 6),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 23,
            ),
            InkWell(
              onTap: () {
                streambuild = db
                    .collection('${catname}')
                    .where('tags', isGreaterThanOrEqualTo: 'Cold Drinks')
                    .snapshots();
                _controller.value += 1;
              },
              child: Image.asset(
                'assets/colddrinks.png',
                width: 55,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              'Cold Drinks',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 114, 114, 114),
              ),
            ),
            SizedBox(height: 35),
            InkWell(
                onTap: () {
                  streambuild = db
                      .collection('${catname}')
                      .where('tags', isGreaterThanOrEqualTo: 'Energy Drinks')
                      .snapshots();
                  _controller.value += 1;
                },
                child: Image.asset(
                  'assets/energydrinks.png',
                  width: 55,
                )),
            SizedBox(
              height: 5,
            ),
            Text(
              'Energy Drinks',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 114, 114, 114),
              ),
            ),
            SizedBox(
              height: 35,
            ),
            InkWell(
                onTap: () {
                  streambuild = db
                      .collection('${catname}')
                      .where('tags', isGreaterThanOrEqualTo: 'Juices')
                      .snapshots();
                  _controller.value += 1;
                },
                child: Image.asset(
                  'assets/juices.png',
                  width: 55,
                )),
            SizedBox(
              height: 5,
            ),
            Text(
              'Juices',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 114, 114, 114),
              ),
            ),
            SizedBox(
              height: 35,
            ),
            InkWell(
                onTap: () {
                  streambuild = db
                      .collection('${catname}')
                      .where('tags', isGreaterThanOrEqualTo: 'Soda')
                      .snapshots();
                  _controller.value += 1;
                },
                child: Image.asset(
                  'assets/sodaandmixers.png',
                  width: 55,
                )),
            SizedBox(
              height: 5,
            ),
            Text(
              'Soda and Mixers',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 114, 114, 114),
              ),
            ),
            SizedBox(
              height: 35,
            ),
            InkWell(
                onTap: () {
                  streambuild = db
                      .collection('${catname}')
                      .where('tags', isGreaterThanOrEqualTo: 'Water')
                      .snapshots();
                  _controller.value += 1;
                },
                child: Image.asset(
                  'assets/waterandicecubes.png',
                  width: 55,
                )),
            SizedBox(
              height: 5,
            ),
            Text(
              'Water and Ice Cubes',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 114, 114, 114),
              ),
            ),
          ],
        ),
      );
    } else if (catname == 'tea') {
      return Container(
        width: 75,
        height: MediaQuery.of(context).size.height - 100,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 235, 235, 235),
          boxShadow: [
            BoxShadow(
                color: Color.fromARGB(29, 0, 0, 0),
                offset: const Offset(0, 3),
                blurRadius: 6),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 23,
            ),
            InkWell(
              onTap: () {
                streambuild = db
                    .collection('${catname}')
                    .where('tags', isGreaterThanOrEqualTo: 'Tea')
                    .snapshots();
                _controller.value += 1;
              },
              child: Image.asset(
                'assets/teacategory.png',
                width: 55,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              'Tea',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 114, 114, 114),
              ),
            ),
            SizedBox(height: 35),
            InkWell(
                onTap: () {
                  streambuild = db
                      .collection('${catname}')
                      .where('tags', isGreaterThanOrEqualTo: 'Coffee')
                      .snapshots();
                  _controller.value += 1;
                },
                child: Image.asset(
                  'assets/coffee.png',
                  width: 55,
                )),
            SizedBox(
              height: 5,
            ),
            Text(
              'Coffee',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 114, 114, 114),
              ),
            ),
            SizedBox(
              height: 35,
            ),
            InkWell(
                onTap: () {
                  streambuild = db
                      .collection('${catname}')
                      .where('tags', isGreaterThanOrEqualTo: 'Health')
                      .snapshots();
                  _controller.value += 1;
                },
                child: Image.asset(
                  'assets/healthdrink.png',
                  width: 55,
                )),
            SizedBox(
              height: 5,
            ),
            Text(
              'Health Drink',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 114, 114, 114),
              ),
            ),
            SizedBox(
              height: 35,
            ),
            InkWell(
                onTap: () {
                  streambuild = db
                      .collection('${catname}')
                      .where('tags', isGreaterThanOrEqualTo: 'Vegan')
                      .snapshots();
                  _controller.value += 1;
                },
                child: Image.asset(
                  'assets/vegandrinks.png',
                  width: 55,
                )),
            SizedBox(
              height: 5,
            ),
            Text(
              'Vegan Drinks',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 114, 114, 114),
              ),
            ),
            SizedBox(
              height: 35,
            ),
            InkWell(
                onTap: () {
                  streambuild = db
                      .collection('${catname}')
                      .where('tags', isGreaterThanOrEqualTo: 'Instant Drink')
                      .snapshots();
                  _controller.value += 1;
                },
                child: Image.asset(
                  'assets/instantdrinkmixes.png',
                  width: 55,
                )),
            SizedBox(
              height: 5,
            ),
            Text(
              'Instant Drink Mixes',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 114, 114, 114),
              ),
            ),
          ],
        ),
      );
    } else if (catname == 'rice') {
      return Container(
        width: 75,
        height: MediaQuery.of(context).size.height - 100,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 235, 235, 235),
          boxShadow: [
            BoxShadow(
                color: Color.fromARGB(29, 0, 0, 0),
                offset: const Offset(0, 3),
                blurRadius: 6),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 23,
            ),
            InkWell(
              onTap: () {
                streambuild = db
                    .collection('${catname}')
                    .where('tags', isGreaterThanOrEqualTo: 'Atta')
                    .snapshots();
                _controller.value += 1;
              },
              child: Image.asset(
                'assets/atta.png',
                width: 55,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              'Atta',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 114, 114, 114),
              ),
            ),
            SizedBox(height: 35),
            InkWell(
                onTap: () {
                  streambuild = db
                      .collection('${catname}')
                      .where('tags', isGreaterThanOrEqualTo: 'Rice')
                      .snapshots();
                  _controller.value += 1;
                },
                child: Image.asset(
                  'assets/ricecategory.png',
                  width: 55,
                )),
            SizedBox(
              height: 5,
            ),
            Text(
              'Rice',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 114, 114, 114),
              ),
            ),
            SizedBox(
              height: 35,
            ),
            InkWell(
                onTap: () {
                  streambuild = db
                      .collection('${catname}')
                      .where('tags', isGreaterThanOrEqualTo: 'Pulses')
                      .snapshots();
                  _controller.value += 1;
                },
                child: Image.asset(
                  'assets/pulses.png',
                  width: 55,
                )),
            SizedBox(
              height: 5,
            ),
            Text(
              'Pulses',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 114, 114, 114),
              ),
            ),
            SizedBox(
              height: 35,
            ),
            InkWell(
                onTap: () {
                  streambuild = db
                      .collection('${catname}')
                      .where('tags', isGreaterThanOrEqualTo: 'Other Flours')
                      .snapshots();
                  _controller.value += 1;
                },
                child: Image.asset(
                  'assets/otherflours.png',
                  width: 55,
                )),
            SizedBox(
              height: 5,
            ),
            Text(
              'Other Flours',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 114, 114, 114),
              ),
            ),
            SizedBox(
              height: 35,
            ),
            InkWell(
                onTap: () {
                  streambuild = db
                      .collection('${catname}')
                      .where('tags', isGreaterThanOrEqualTo: 'Other Pulses')
                      .snapshots();
                  _controller.value += 1;
                },
                child: Image.asset(
                  'assets/otherpulses.png',
                  width: 55,
                )),
            SizedBox(
              height: 5,
            ),
            Text(
              'Other Pulses',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 114, 114, 114),
              ),
            ),
          ],
        ),
      );
    } else if (catname == 'oil') {
      return Container(
        width: 75,
        height: MediaQuery.of(context).size.height - 100,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 235, 235, 235),
          boxShadow: [
            BoxShadow(
                color: Color.fromARGB(29, 0, 0, 0),
                offset: const Offset(0, 3),
                blurRadius: 6),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 23,
            ),
            InkWell(
              onTap: () {
                streambuild = db
                    .collection('${catname}')
                    .where('tags', isGreaterThanOrEqualTo: 'Edible Oil')
                    .snapshots();
                _controller.value += 1;
              },
              child: Image.asset(
                'assets/edibleoil.png',
                width: 55,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              'Edible Oil',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 114, 114, 114),
              ),
            ),
            SizedBox(height: 35),
            InkWell(
                onTap: () {
                  streambuild = db
                      .collection('${catname}')
                      .where('tags', isGreaterThanOrEqualTo: 'Ghee')
                      .snapshots();
                  _controller.value += 1;
                },
                child: Image.asset(
                  'assets/ghee.png',
                  width: 55,
                )),
            SizedBox(
              height: 5,
            ),
            Text(
              'Ghee',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 114, 114, 114),
              ),
            ),
            SizedBox(
              height: 35,
            ),
            InkWell(
                onTap: () {
                  streambuild = db
                      .collection('${catname}')
                      .where('tags', isGreaterThanOrEqualTo: 'Masala')
                      .snapshots();
                  _controller.value += 1;
                },
                child: Image.asset(
                  'assets/masala.png',
                  width: 55,
                )),
            SizedBox(
              height: 5,
            ),
            Text(
              'Masala',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 114, 114, 114),
              ),
            ),
            SizedBox(
              height: 35,
            ),
            InkWell(
                onTap: () {
                  streambuild = db
                      .collection('${catname}')
                      .where('tags', isGreaterThanOrEqualTo: 'Salt')
                      .snapshots();
                  _controller.value += 1;
                },
                child: Image.asset(
                  'assets/saltsugarjaggery.png',
                  width: 55,
                )),
            SizedBox(
              height: 5,
            ),
            Text(
              'Salt, Sugar & Jaggery',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 114, 114, 114),
              ),
            ),
            SizedBox(
              height: 35,
            ),
            InkWell(
                onTap: () {
                  streambuild = db
                      .collection('${catname}')
                      .where('tags', isGreaterThanOrEqualTo: 'Dry Fruits')
                      .snapshots();
                  _controller.value += 1;
                },
                child: Image.asset(
                  'assets/dryfruits.png',
                  width: 55,
                )),
            SizedBox(
              height: 5,
            ),
            Text(
              'Dry Fruits',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 114, 114, 114),
              ),
            ),
          ],
        ),
      );
    }
    if (catname == 'babycare') {
      return Container(
        width: 75,
        height: MediaQuery.of(context).size.height - 100,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 235, 235, 235),
          boxShadow: [
            BoxShadow(
                color: Color.fromARGB(29, 0, 0, 0),
                offset: const Offset(0, 3),
                blurRadius: 6),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 23,
            ),
            InkWell(
              onTap: () {
                streambuild = db
                    .collection('${catname}')
                    .where('tags', isGreaterThanOrEqualTo: 'Baby Food')
                    .snapshots();
                _controller.value += 1;
              },
              child: Image.asset(
                'assets/babyfood.png',
                width: 55,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              'Baby Food',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 114, 114, 114),
              ),
            ),
            SizedBox(height: 35),
            InkWell(
                onTap: () {
                  streambuild = db
                      .collection('${catname}')
                      .where('tags', isGreaterThanOrEqualTo: 'Diapers')
                      .snapshots();
                  _controller.value += 1;
                },
                child: Image.asset(
                  'assets/diapersandwipes.png',
                  width: 55,
                )),
            SizedBox(
              height: 5,
            ),
            Text(
              'Diapers and Wipes',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 114, 114, 114),
              ),
            ),
            SizedBox(
              height: 35,
            ),
            InkWell(
                onTap: () {
                  streambuild = db
                      .collection('${catname}')
                      .where('tags', isGreaterThanOrEqualTo: 'Baby Bath')
                      .snapshots();
                  _controller.value += 1;
                },
                child: Image.asset(
                  'assets/babybathandskin.png',
                  width: 55,
                )),
            SizedBox(
              height: 5,
            ),
            Text(
              'Baby Bath & Skin',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 114, 114, 114),
              ),
            ),
            SizedBox(
              height: 35,
            ),
            InkWell(
                onTap: () {
                  streambuild = db
                      .collection('${catname}')
                      .where('tags', isGreaterThanOrEqualTo: 'Wound Care')
                      .snapshots();
                  _controller.value += 1;
                },
                child: Image.asset(
                  'assets/woundcareandpain.png',
                  width: 55,
                )),
            SizedBox(
              height: 5,
            ),
            Text(
              'Wound Care & Pain',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 114, 114, 114),
              ),
            ),
            SizedBox(
              height: 35,
            ),
            InkWell(
                onTap: () {
                  streambuild = db
                      .collection('${catname}')
                      .where('tags', isGreaterThanOrEqualTo: 'Cough')
                      .snapshots();
                  _controller.value += 1;
                },
                child: Image.asset(
                  'assets/coughandcold.png',
                  width: 55,
                )),
            SizedBox(
              height: 5,
            ),
            Text(
              'Cough and Cold',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 114, 114, 114),
              ),
            ),
          ],
        ),
      );
    } else if (catname == 'meat') {
      return Container(
        width: 75,
        height: MediaQuery.of(context).size.height - 100,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 235, 235, 235),
          boxShadow: [
            BoxShadow(
                color: Color.fromARGB(29, 0, 0, 0),
                offset: const Offset(0, 3),
                blurRadius: 6),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 23,
            ),
            InkWell(
              onTap: () {
                streambuild = db
                    .collection('${catname}')
                    .where('tags', isGreaterThanOrEqualTo: 'Fresh Meat')
                    .snapshots();
                _controller.value += 1;
              },
              child: Image.asset(
                'assets/freshmeat.png',
                width: 55,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              'Fresh Meat',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 114, 114, 114),
              ),
            ),
            SizedBox(height: 35),
            InkWell(
                onTap: () {
                  streambuild = db
                      .collection('${catname}')
                      .where('tags', isGreaterThanOrEqualTo: 'Frozen Meat')
                      .snapshots();
                  _controller.value += 1;
                },
                child: Image.asset(
                  'assets/frozenmeat.png',
                  width: 55,
                )),
            SizedBox(
              height: 5,
            ),
            Text(
              'Frozen Meat',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 114, 114, 114),
              ),
            ),
            SizedBox(
              height: 35,
            ),
            InkWell(
                onTap: () {
                  streambuild = db
                      .collection('${catname}')
                      .where('tags', isGreaterThanOrEqualTo: 'Marinated Meat')
                      .snapshots();
                  _controller.value += 1;
                },
                child: Image.asset(
                  'assets/marinatedmeat.png',
                  width: 55,
                )),
            SizedBox(
              height: 5,
            ),
            Text(
              'Marinated Meat',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 114, 114, 114),
              ),
            ),
            SizedBox(
              height: 35,
            ),
            InkWell(
                onTap: () {
                  streambuild = db
                      .collection('${catname}')
                      .where('tags', isGreaterThanOrEqualTo: 'Plant Based Meat')
                      .snapshots();
                  _controller.value += 1;
                },
                child: Image.asset(
                  'assets/plantbasedmeat.png',
                  width: 55,
                )),
            SizedBox(
              height: 5,
            ),
            Text(
              'Plant Based Meat',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 114, 114, 114),
              ),
            ),
            SizedBox(
              height: 35,
            ),
            InkWell(
                onTap: () {
                  streambuild = db
                      .collection('${catname}')
                      .where('tags', isGreaterThanOrEqualTo: 'Egg')
                      .snapshots();
                  _controller.value += 1;
                },
                child: Image.asset(
                  'assets/eggmeat.png',
                  width: 55,
                )),
            SizedBox(
              height: 5,
            ),
            Text(
              'Eggs',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 114, 114, 114),
              ),
            ),
          ],
        ),
      );
    } else if (catname == 'cleaning') {
      return Container(
        width: 75,
        height: MediaQuery.of(context).size.height - 100,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 235, 235, 235),
          boxShadow: [
            BoxShadow(
                color: Color.fromARGB(29, 0, 0, 0),
                offset: const Offset(0, 3),
                blurRadius: 6),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 23,
            ),
            InkWell(
              onTap: () {
                streambuild = db
                    .collection('${catname}')
                    .where('tags', isGreaterThanOrEqualTo: 'Fabric Care')
                    .snapshots();
                _controller.value += 1;
              },
              child: Image.asset(
                'assets/fabriccare.png',
                width: 55,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              'Fabric Care',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 114, 114, 114),
              ),
            ),
            SizedBox(height: 35),
            InkWell(
                onTap: () {
                  streambuild = db
                      .collection('${catname}')
                      .where('tags', isGreaterThanOrEqualTo: 'Surface Cleaner')
                      .snapshots();
                  _controller.value += 1;
                },
                child: Image.asset(
                  'assets/surfacecleaner.png',
                  width: 55,
                )),
            SizedBox(
              height: 5,
            ),
            Text(
              'Surface Cleaner',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 114, 114, 114),
              ),
            ),
            SizedBox(
              height: 35,
            ),
            InkWell(
                onTap: () {
                  streambuild = db
                      .collection('${catname}')
                      .where('tags', isGreaterThanOrEqualTo: 'Toilet Cleaner')
                      .snapshots();
                  _controller.value += 1;
                },
                child: Image.asset(
                  'assets/toiletcleaner.png',
                  width: 55,
                )),
            SizedBox(
              height: 5,
            ),
            Text(
              'Toilet Cleaner',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 114, 114, 114),
              ),
            ),
            SizedBox(
              height: 35,
            ),
            InkWell(
                onTap: () {
                  streambuild = db
                      .collection('${catname}')
                      .where('tags', isGreaterThanOrEqualTo: 'Utensil Cleaner')
                      .snapshots();
                  _controller.value += 1;
                },
                child: Image.asset(
                  'assets/utensilcleaner.png',
                  width: 55,
                )),
            SizedBox(
              height: 5,
            ),
            Text(
              'Utensil Cleaner',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 114, 114, 114),
              ),
            ),
            SizedBox(
              height: 35,
            ),
            InkWell(
                onTap: () {
                  streambuild = db
                      .collection('${catname}')
                      .where('tags', isGreaterThanOrEqualTo: 'Disinfectants')
                      .snapshots();
                  _controller.value += 1;
                },
                child: Image.asset(
                  'assets/disinfectants.png',
                  width: 55,
                )),
            SizedBox(
              height: 5,
            ),
            Text(
              'Disinfectant',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 114, 114, 114),
              ),
            ),
          ],
        ),
      );
    } else if (catname == 'personalhygiene') {
      return Container(
        width: 75,
        height: MediaQuery.of(context).size.height - 100,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 235, 235, 235),
          boxShadow: [
            BoxShadow(
                color: Color.fromARGB(29, 0, 0, 0),
                offset: const Offset(0, 3),
                blurRadius: 6),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 23,
            ),
            InkWell(
              onTap: () {
                streambuild = db
                    .collection('${catname}')
                    .where('tags', isGreaterThanOrEqualTo: 'Soap')
                    .snapshots();
                _controller.value += 1;
              },
              child: Image.asset(
                'assets/soap.png',
                width: 55,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              'Soap',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 114, 114, 114),
              ),
            ),
            SizedBox(height: 35),
            InkWell(
                onTap: () {
                  streambuild = db
                      .collection('${catname}')
                      .where('tags', isGreaterThanOrEqualTo: 'Shampoo')
                      .snapshots();
                  _controller.value += 1;
                },
                child: Image.asset(
                  'assets/shampoo.png',
                  width: 55,
                )),
            SizedBox(
              height: 5,
            ),
            Text(
              'Shampoo',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 114, 114, 114),
              ),
            ),
            SizedBox(
              height: 35,
            ),
            InkWell(
                onTap: () {
                  streambuild = db
                      .collection('${catname}')
                      .where('tags', isGreaterThanOrEqualTo: 'Lotion')
                      .snapshots();
                  _controller.value += 1;
                },
                child: Image.asset(
                  'assets/lotion.png',
                  width: 55,
                )),
            SizedBox(
              height: 5,
            ),
            Text(
              'Lotion',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 114, 114, 114),
              ),
            ),
            SizedBox(
              height: 35,
            ),
            InkWell(
                onTap: () {
                  streambuild = db
                      .collection('${catname}')
                      .where('tags', isGreaterThanOrEqualTo: 'Toothpaste')
                      .snapshots();
                  _controller.value += 1;
                },
                child: Image.asset(
                  'assets/toothpaste.png',
                  width: 55,
                )),
            SizedBox(
              height: 5,
            ),
            Text(
              'Toothpaste',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 114, 114, 114),
              ),
            ),
            SizedBox(
              height: 35,
            ),
            InkWell(
                onTap: () {
                  streambuild = db
                      .collection('${catname}')
                      .where('tags', isGreaterThanOrEqualTo: 'Feminine Care')
                      .snapshots();
                  _controller.value += 1;
                },
                child: Image.asset(
                  'assets/femininecare.png',
                  width: 55,
                )),
            SizedBox(
              height: 5,
            ),
            Text(
              'Feminine Care',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 114, 114, 114),
              ),
            ),
          ],
        ),
      );
    }
    return SizedBox(
      width: 75,
      height: MediaQuery.of(context).size.height - 100,
    );
  }
}

class ProductListView extends StatefulWidget {
  final String parameter;
  const ProductListView({Key? key, required this.parameter}) : super(key: key);

  @override
  State<ProductListView> createState() => _ProductListViewState();
}

class _ProductListViewState extends State<ProductListView> {
  final ref = FirebaseStorage.instance.ref();
  final db = FirebaseFirestore.instance;

  Future<void> LoadImage() async {
    String url =
        (await ref.child('products/munchies/laysproduct.png')).toString();
  }

  @override
  Widget build(BuildContext context) {
    // if (widget.parameter == 'food') {
    //   streambuild = FirebaseFirestore.instance.collection('food').snapshots();
    // } else if (widget.parameter == 'vegetables') {
    //   streambuild = db.collection('Vegetables').snapshots();
    // } else if (widget.parameter == 'Meat') {
    //   streambuild = db.collection('Meat').snapshots();
    // } else if (widget.parameter == 'Dessert') {
    //   streambuild = db.collection('Dessert').snapshots();
    // }

    return ValueListenableBuilder(
      valueListenable: _controller,
      builder: ((context, value, child) {
        return StreamBuilder<QuerySnapshot>(
          stream: streambuild,
          builder: ((context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10.0,
                  childAspectRatio: MediaQuery.of(context).size.width / 700,
                ),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (BuildContext context, int index) {
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
                      onTap: () {
                        Navigator.push(
                            context,
                            SingleProductScreen.route(
                                category: widget.parameter,
                                docName: '${snapshot.data!.docs[index].id}'));
                      },
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 28, right: 11, left: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.network(
                              snapshot.data!.docs[index]['image'],
                              width: 75,
                              height: 75,
                            ),
                            Text(
                              '${snapshot.data!.docs[index]['Name']}',
                              style: TextStyle(
                                color: Color.fromARGB(255, 114, 114, 114),
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                '${snapshot.data!.docs[index]['Weight']}',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Color.fromARGB(255, 114, 114, 114),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '₹${snapshot.data!.docs[index]['Price']}',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Color.fromARGB(255, 31, 89, 41),
                                      fontWeight: FontWeight.bold),
                                ),
                                OutlinedButton(
                                  onPressed: () async {
                                    var userId =
                                        FirebaseAuth.instance.currentUser!.uid;

                                    var docRef = db
                                        .collection('cart ${userId}')
                                        .doc(
                                            '${snapshot.data!.docs[index]['Name']}');
                                    docRef.get().then((DocumentSnapshot doc) {
                                      final data =
                                          doc.data() as Map<String, dynamic>?;
                                      if (data?['Quantity'] == null) {
                                        var addproductdata = <String, dynamic>{
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
                                            .collection('cart ${userId}')
                                            .doc(
                                                '${snapshot.data!.docs[index]['Name']}')
                                            .set(addproductdata);
                                      } else if (data?['Quantity'] == '0') {
                                        var addproductdata = <String, dynamic>{
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
                                            .collection('cart ${userId}')
                                            .doc(
                                                '${snapshot.data!.docs[index]['Name']}')
                                            .set(addproductdata);
                                      } else {
                                        var newquantity =
                                            int.parse(data?['Quantity']) + 1;
                                        var addproductdata = <String, dynamic>{
                                          "Quantity": "${newquantity}"
                                        };

                                        db
                                            .collection('cart ${userId}')
                                            .doc(
                                                '${snapshot.data!.docs[index]['Name']}')
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
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                });
          }),
        );
      }),
    );
  }
}

/*
  SliverGrid.count(
          crossAxisCount: 2,
          mainAxisSpacing: 10.0,
          childAspectRatio: MediaQuery.of(context).size.width / 700,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                      color: Color.fromARGB(255, 112, 112, 112), width: 0.5),
                  right: BorderSide(
                      color: Color.fromARGB(255, 112, 112, 112), width: 0.5),
                ),
              ),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/singleproductscreen');
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 28, right: 11, left: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        'assets/laysproduct.png',
                        width: 75,
                        alignment: Alignment.center,
                      ),
                      Text(
                        'Lay\'s Flamin\' Hot Potato Chips',
                        style: TextStyle(
                          color: Color.fromARGB(255, 114, 114, 114),
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          '52 g',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Color.fromARGB(255, 114, 114, 114),
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '₹20',
                            style: TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(255, 31, 89, 41),
                                fontWeight: FontWeight.bold),
                          ),
                          OutlinedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/cart');
                            },
                            child: Text(
                              'ADD',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 31, 89, 41),
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                      color: Color.fromARGB(255, 112, 112, 112), width: 0.5),
                  right: BorderSide(
                      color: Color.fromARGB(255, 112, 112, 112), width: 0.5),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 28, right: 11, left: 10),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/laysblue.png',
                      width: 75,
                      alignment: Alignment.center,
                    ),
                    Text(
                      'Lay\'s Magic Masala Potato Chips',
                      style: TextStyle(
                        color: Color.fromARGB(255, 114, 114, 114),
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        '52 g',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Color.fromARGB(255, 114, 114, 114),
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '₹20',
                          style: TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 31, 89, 41),
                              fontWeight: FontWeight.bold),
                        ),
                        OutlinedButton(
                          onPressed: () {},
                          child: Text(
                            'ADD',
                            style: TextStyle(
                                color: Color.fromARGB(255, 31, 89, 41),
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                      color: Color.fromARGB(255, 112, 112, 112), width: 0.5),
                  right: BorderSide(
                      color: Color.fromARGB(255, 112, 112, 112), width: 0.5),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 28, right: 11, left: 10),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/laysred.png',
                      width: 75,
                      alignment: Alignment.center,
                    ),
                    Text(
                      'Lay\'s Flamin\' Hot Potato Chips',
                      style: TextStyle(
                        color: Color.fromARGB(255, 114, 114, 114),
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        '52 g',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Color.fromARGB(255, 114, 114, 114),
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '₹20',
                          style: TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 31, 89, 41),
                              fontWeight: FontWeight.bold),
                        ),
                        OutlinedButton(
                          onPressed: () {},
                          child: Text(
                            'ADD',
                            style: TextStyle(
                                color: Color.fromARGB(255, 31, 89, 41),
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                      color: Color.fromARGB(255, 112, 112, 112), width: 0.5),
                  right: BorderSide(
                      color: Color.fromARGB(255, 112, 112, 112), width: 0.5),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 28, right: 11, left: 10),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/bluelays.png',
                      width: 75,
                      alignment: Alignment.center,
                    ),
                    Text(
                      'Lay\'s Paprika Potato Chips',
                      style: TextStyle(
                        color: Color.fromARGB(255, 114, 114, 114),
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        '52 g',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Color.fromARGB(255, 114, 114, 114),
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '₹20',
                          style: TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 31, 89, 41),
                              fontWeight: FontWeight.bold),
                        ),
                        OutlinedButton(
                          onPressed: () {},
                          child: Text(
                            'ADD',
                            style: TextStyle(
                                color: Color.fromARGB(255, 31, 89, 41),
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                      color: Color.fromARGB(255, 112, 112, 112), width: 0.5),
                  right: BorderSide(
                      color: Color.fromARGB(255, 112, 112, 112), width: 0.5),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 28, right: 11, left: 10),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/laysred.png',
                      width: 75,
                      alignment: Alignment.center,
                    ),
                    Text(
                      'Lay\'s Flamin\' Hot Potato Chips',
                      style: TextStyle(
                        color: Color.fromARGB(255, 114, 114, 114),
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        '52 g',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Color.fromARGB(255, 114, 114, 114),
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '₹20',
                          style: TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 31, 89, 41),
                              fontWeight: FontWeight.bold),
                        ),
                        OutlinedButton(
                          onPressed: () {},
                          child: Text(
                            'ADD',
                            style: TextStyle(
                                color: Color.fromARGB(255, 31, 89, 41),
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                      color: Color.fromARGB(255, 112, 112, 112), width: 0.5),
                  right: BorderSide(
                      color: Color.fromARGB(255, 112, 112, 112), width: 0.5),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 28, right: 11, left: 10),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/laysred.png',
                      width: 75,
                      alignment: Alignment.center,
                    ),
                    Text(
                      'Lay\'s Flamin\' Hot Potato Chips',
                      style: TextStyle(
                        color: Color.fromARGB(255, 114, 114, 114),
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        '52 g',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Color.fromARGB(255, 114, 114, 114),
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '₹20',
                          style: TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 31, 89, 41),
                              fontWeight: FontWeight.bold),
                        ),
                        OutlinedButton(
                          onPressed: () {},
                          child: Text(
                            'ADD',
                            style: TextStyle(
                                color: Color.fromARGB(255, 31, 89, 41),
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ) */
