import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yans/screens/screens.dart';

var db = FirebaseFirestore.instance;
var userId = FirebaseAuth.instance.currentUser!.uid;

class GroceryhomeScreen extends StatefulWidget {
  static const String routeName = '/groceryhome';

  static Route route() {
    return MaterialPageRoute(
        builder: (_) => GroceryhomeScreen(),
        settings: RouteSettings(name: routeName));
  }

  @override
  State<GroceryhomeScreen> createState() => _GroceryhomeScreenState();
}

class _GroceryhomeScreenState extends State<GroceryhomeScreen> {
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
    print('Dispose');
    if (entry != null) {
      entry!.remove();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream:
            db.collection("users").where('uid', isEqualTo: userId).snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) return Text('An Error Occured');
          if (snapshot.hasData) {
            var docs = snapshot.data.docs;
            final userinfo = docs[0].data()!;
            return Scaffold(
              bottomNavigationBar: Container(
                height: 50,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(
                      Icons.home_filled,
                      color: Theme.of(context).primaryColor,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacementNamed(
                            context, '/grocerylocation');
                      },
                      child: Icon(
                        Icons.location_pin,
                        color: Color.fromARGB(255, 114, 114, 114),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, '/contactus');
                      },
                      child: Icon(
                        Icons.person,
                        color: Color.fromARGB(255, 114, 114, 114),
                      ),
                    ),
                  ],
                ),
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 30,
                      ),
                      child: Container(
                        height: 70,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            IntrinsicWidth(
                              child: InkWell(
                                onTap: () {
                                  Navigator.pushReplacementNamed(
                                      context, '/grocerylocation');
                                },
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.home,
                                          color:
                                              Color.fromARGB(255, 55, 107, 64),
                                          size: 28,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          'Home',
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 114, 114, 114),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 22),
                                        ),
                                        Icon(
                                          Icons.arrow_drop_down_rounded,
                                          color: Color.fromARGB(
                                              255, 114, 114, 114),
                                        )
                                      ],
                                    ),
                                    userinfo['homeinfo'] == null
                                        ? const Text(
                                            'Click Here to set location',
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Color.fromARGB(
                                                    255, 114, 114, 114),
                                                fontWeight: FontWeight.w500),
                                          )
                                        : Text(
                                            '${userinfo['homeinfo']}',
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Color.fromARGB(
                                                    255, 114, 114, 114),
                                                fontWeight: FontWeight.w500),
                                          )
                                  ],
                                ),
                              ),
                            ),
                            Image.asset(
                              'assets/logo.png',
                              width: 55,
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacementNamed(
                            context, '/grocerysearch');
                      },
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width - 75,
                        height: 50,
                        child: AbsorbPointer(
                          child: TextFormField(
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              filled: true,
                              fillColor: Colors.white,
                              suffixIcon: Icon(Icons.search),
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
                              hintText: 'Search for restaurant, item or more',
                              hintStyle: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    SingleChildScrollView(
                      child: Container(
                        height: 300,
                        child: ListView(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    GroceryProductListScreen.route(
                                        category: 'babycare'));
                              },
                              child: Container(
                                width: 300,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: <Color>[
                                        Color.fromARGB(255, 255, 228, 6),
                                        Color.fromARGB(255, 255, 188, 0)
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: BorderRadius.circular(21)),
                                child: Image.asset(
                                  'assets/herobabycare.png',
                                  width: 260,
                                  height: 240,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 25,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    GroceryProductListScreen.route(
                                        category: 'munchies'));
                              },
                              child: Container(
                                width: 300,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: <Color>[
                                        Color.fromARGB(255, 255, 250, 208),
                                        Color.fromARGB(255, 49, 121, 49)
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: BorderRadius.circular(21)),
                                child: Image.asset(
                                  'assets/herosnacks.png',
                                  width: 260,
                                  height: 240,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 25,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    GroceryProductListScreen.route(
                                        category: 'fruits'));
                              },
                              child: Container(
                                width: 300,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: <Color>[
                                        Color.fromARGB(255, 255, 228, 6),
                                        Color.fromARGB(255, 255, 188, 0)
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: BorderRadius.circular(21)),
                                child: Image.asset(
                                  'assets/firstrow.png',
                                  width: 260,
                                  height: 240,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 25,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    GroceryProductListScreen.route(
                                        category: 'dairy'));
                              },
                              child: Container(
                                width: 300,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: <Color>[
                                        Color.fromARGB(255, 197, 208, 51),
                                        Color.fromARGB(255, 255, 250, 208)
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: BorderRadius.circular(21)),
                                child: Image.asset(
                                  'assets/herodairy.png',
                                  width: 260,
                                  height: 240,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 25,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    GroceryProductListScreen.route(
                                        category: 'rice'));
                              },
                              child: Container(
                                width: 300,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: <Color>[
                                        Color.fromARGB(255, 255, 228, 6),
                                        Color.fromARGB(255, 255, 188, 0)
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: BorderRadius.circular(21)),
                                child: Image.asset(
                                  'assets/herocooking.png',
                                  width: 260,
                                  height: 240,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    const Text(
                      'Shop by category',
                      style: TextStyle(
                        color: Color.fromARGB(255, 114, 114, 114),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  GroceryProductListScreen.route(
                                      category: 'fruits'));
                            },
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/fruits.png',
                                  width: 110,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  'Fruits & Vegetables',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 114, 114, 114),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  GroceryProductListScreen.route(
                                      category: 'dairy'));
                            },
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/dairy.png',
                                  width: 110,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  'Dairy, Bread & Eggs',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 114, 114, 114),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  GroceryProductListScreen.route(
                                      category: 'munchies'));
                            },
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/munchies.png',
                                  width: 110,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  'Munchies',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 114, 114, 114),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  GroceryProductListScreen.route(
                                      category: 'dessert'));
                            },
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/dessertrow.png',
                                  width: 110,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  'Dessert',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 114, 114, 114),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  GroceryProductListScreen.route(
                                      category: 'drinks'));
                            },
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/drinks.png',
                                  width: 110,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  'Drinks',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 114, 114, 114),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  GroceryProductListScreen.route(
                                      category: 'tea'));
                            },
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/tea.png',
                                  width: 110,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  'Tea & Coffee',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 114, 114, 114),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  GroceryProductListScreen.route(
                                      category: 'rice'));
                            },
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/rice.png',
                                  width: 110,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  'Rice, Atta & Dal',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 114, 114, 114),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  GroceryProductListScreen.route(
                                      category: 'oil'));
                            },
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/oil.png',
                                  width: 110,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  'Oil',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 114, 114, 114),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  GroceryProductListScreen.route(
                                      category: 'babycare'));
                            },
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/babycare.png',
                                  width: 110,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  'Babycare',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 114, 114, 114),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  GroceryProductListScreen.route(
                                      category: 'meat'));
                            },
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/meat.png',
                                  width: 110,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  'Meat',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 114, 114, 114),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  GroceryProductListScreen.route(
                                      category: 'cleaning'));
                            },
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/cleaning.png',
                                  width: 110,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  'Cleaning Essentials',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 114, 114, 114),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  GroceryProductListScreen.route(
                                      category: 'personalhygiene'));
                            },
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/personalhygiene.png',
                                  width: 110,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  'Personal Hygiene',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 114, 114, 114),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 125,
                    ),
                    Text(
                      'Essential Bundles',
                      style: TextStyle(
                        color: Color.fromARGB(255, 114, 114, 114),
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      'Your everyday essentials bundled up!',
                      style: TextStyle(
                        color: Color.fromARGB(255, 114, 114, 114),
                        fontWeight: FontWeight.w300,
                        fontSize: 16,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FutureBuilder<Map<String, dynamic>>(
                            future: getBundles('Munchies For 2'),
                            builder: (context,
                                AsyncSnapshot<Map<String, dynamic>> snapshot) {
                              var bundledata = snapshot.data;
                              if (snapshot.hasData) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.pushReplacement(
                                        context,
                                        SingleProductScreen.route(
                                            category: 'Bundles',
                                            docName: 'Munchies For 2'));
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 5),
                                    width: (MediaQuery.of(context).size.width /
                                            2) -
                                        25,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Image.network(
                                            '${bundledata!['image']}'),
                                        Text(
                                          '${bundledata['Name']}',
                                          style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 114, 114, 114),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Text(
                                          'Partner in crime ;)',
                                          style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 114, 114, 114),
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '₹${bundledata['Price']}',
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 31, 89, 41),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                            OutlinedButton(
                                              onPressed: () {
                                                var userId = FirebaseAuth
                                                    .instance.currentUser!.uid;

                                                var docRef = db
                                                    .collection(
                                                        'cart ${userId}')
                                                    .doc('Munchies For 2');
                                                docRef.get().then(
                                                    (DocumentSnapshot doc) {
                                                  final data = doc.data()
                                                      as Map<String, dynamic>?;
                                                  if (data?['Quantity'] ==
                                                      null) {
                                                    var addproductdata =
                                                        <String, dynamic>{
                                                      "Name":
                                                          "${bundledata['Name']}",
                                                      "Weight": " ",
                                                      "Price":
                                                          "${bundledata['Price']}",
                                                      "Image":
                                                          "${bundledata['image']}",
                                                      "Quantity": "1"
                                                    };

                                                    db
                                                        .collection(
                                                            'cart ${userId}')
                                                        .doc('Munchies For 2')
                                                        .set(addproductdata);
                                                  } else if (data?[
                                                          'Quantity'] ==
                                                      '0') {
                                                    var addproductdata =
                                                        <String, dynamic>{
                                                      "Name":
                                                          "${bundledata['Name']}",
                                                      "Weight": "",
                                                      "Price":
                                                          "${bundledata['Price']}",
                                                      "Image":
                                                          "${bundledata['image']}",
                                                      "Quantity": "1"
                                                    };

                                                    db
                                                        .collection(
                                                            'cart ${userId}')
                                                        .doc('Munchies for 2')
                                                        .set(addproductdata);
                                                  } else {
                                                    var newquantity = int.parse(
                                                            data?['Quantity']) +
                                                        1;
                                                    var addproductdata =
                                                        <String, dynamic>{
                                                      "Quantity":
                                                          "${newquantity}"
                                                    };

                                                    db
                                                        .collection(
                                                            'cart ${userId}')
                                                        .doc('Munchies For 2')
                                                        .set(
                                                            addproductdata,
                                                            SetOptions(
                                                                merge: true));
                                                  }
                                                });
                                                if (entry == null) {
                                                  showCart();
                                                }
                                              },
                                              child: Text(
                                                'ADD',
                                                style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 31, 89, 41),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              } else {
                                return Center(
                                    child: CircularProgressIndicator());
                              }
                            },
                          ),
                          FutureBuilder<Map<String, dynamic>>(
                            future: getBundles('Munchies For 4'),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                var bundledata = snapshot.data;
                                return InkWell(
                                  onTap: () {
                                    Navigator.pushReplacement(
                                        context,
                                        SingleProductScreen.route(
                                            category: 'Bundles',
                                            docName: 'Munchies For 4'));
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 5),
                                    width: (MediaQuery.of(context).size.width /
                                            2) -
                                        25,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Image.network(
                                            '${bundledata!['image']}'),
                                        Text(
                                          '${bundledata['Name']}',
                                          style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 114, 114, 114),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Text(
                                          'Partners in crime ;)',
                                          style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 114, 114, 114),
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '₹${bundledata['Price']}',
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 31, 89, 41),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                            OutlinedButton(
                                              onPressed: () {
                                                var userId = FirebaseAuth
                                                    .instance.currentUser!.uid;

                                                var docRef = db
                                                    .collection(
                                                        'cart ${userId}')
                                                    .doc('Munchies For 4');
                                                docRef.get().then(
                                                    (DocumentSnapshot doc) {
                                                  final data = doc.data()
                                                      as Map<String, dynamic>?;
                                                  if (data?['Quantity'] ==
                                                      null) {
                                                    var addproductdata =
                                                        <String, dynamic>{
                                                      "Name":
                                                          "${bundledata['Name']}",
                                                      "Weight": " ",
                                                      "Price":
                                                          "${bundledata['Price']}",
                                                      "Image":
                                                          "${bundledata['image']}",
                                                      "Quantity": "1"
                                                    };

                                                    db
                                                        .collection(
                                                            'cart ${userId}')
                                                        .doc('Munchies For 4')
                                                        .set(addproductdata);
                                                  } else if (data?[
                                                          'Quantity'] ==
                                                      '0') {
                                                    var addproductdata =
                                                        <String, dynamic>{
                                                      "Name":
                                                          "${bundledata['Name']}",
                                                      "Weight": "",
                                                      "Price":
                                                          "${bundledata['Price']}",
                                                      "Image":
                                                          "${bundledata['image']}",
                                                      "Quantity": "1"
                                                    };

                                                    db
                                                        .collection(
                                                            'cart ${userId}')
                                                        .doc('Munchies for 4')
                                                        .set(addproductdata);
                                                  } else {
                                                    var newquantity = int.parse(
                                                            data?['Quantity']) +
                                                        1;
                                                    var addproductdata =
                                                        <String, dynamic>{
                                                      "Quantity":
                                                          "${newquantity}"
                                                    };

                                                    db
                                                        .collection(
                                                            'cart ${userId}')
                                                        .doc('Munchies For 4')
                                                        .set(
                                                            addproductdata,
                                                            SetOptions(
                                                                merge: true));
                                                  }
                                                });
                                                if (entry == null) {
                                                  showCart();
                                                }
                                              },
                                              child: Text(
                                                'ADD',
                                                style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 31, 89, 41),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              } else {
                                return Center(
                                    child: CircularProgressIndicator());
                              }
                            },
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FutureBuilder<Map<String, dynamic>>(
                            future: getBundles('Essential Baby Care'),
                            builder: (context,
                                AsyncSnapshot<Map<String, dynamic>> snapshot) {
                              var bundledata = snapshot.data;
                              if (snapshot.hasData) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.pushReplacement(
                                        context,
                                        SingleProductScreen.route(
                                            category: 'Bundles',
                                            docName: 'Essential Baby Care'));
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 5),
                                    width: (MediaQuery.of(context).size.width /
                                            2) -
                                        25,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Image.network(
                                            '${bundledata!['image']}'),
                                        Text(
                                          '${bundledata['Name']}',
                                          style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 114, 114, 114),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Text(
                                          '1 month of Baby care products',
                                          style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 114, 114, 114),
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '₹${bundledata['Price']}',
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 31, 89, 41),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                            OutlinedButton(
                                              onPressed: () {
                                                var userId = FirebaseAuth
                                                    .instance.currentUser!.uid;

                                                var docRef = db
                                                    .collection(
                                                        'cart ${userId}')
                                                    .doc('Essential Baby Care');
                                                docRef.get().then(
                                                    (DocumentSnapshot doc) {
                                                  final data = doc.data()
                                                      as Map<String, dynamic>?;
                                                  if (data?['Quantity'] ==
                                                      null) {
                                                    var addproductdata =
                                                        <String, dynamic>{
                                                      "Name":
                                                          "${bundledata['Name']}",
                                                      "Weight": " ",
                                                      "Price":
                                                          "${bundledata['Price']}",
                                                      "Image":
                                                          "${bundledata['image']}",
                                                      "Quantity": "1"
                                                    };

                                                    db
                                                        .collection(
                                                            'cart ${userId}')
                                                        .doc(
                                                            'Essential Baby Care')
                                                        .set(addproductdata);
                                                  } else if (data?[
                                                          'Quantity'] ==
                                                      '0') {
                                                    var addproductdata =
                                                        <String, dynamic>{
                                                      "Name":
                                                          "${bundledata['Name']}",
                                                      "Weight": "",
                                                      "Price":
                                                          "${bundledata['Price']}",
                                                      "Image":
                                                          "${bundledata['image']}",
                                                      "Quantity": "1"
                                                    };

                                                    db
                                                        .collection(
                                                            'cart ${userId}')
                                                        .doc(
                                                            'Essential Baby Care')
                                                        .set(addproductdata);
                                                  } else {
                                                    var newquantity = int.parse(
                                                            data?['Quantity']) +
                                                        1;
                                                    var addproductdata =
                                                        <String, dynamic>{
                                                      "Quantity":
                                                          "${newquantity}"
                                                    };

                                                    db
                                                        .collection(
                                                            'cart ${userId}')
                                                        .doc(
                                                            'Essential Baby Care')
                                                        .set(
                                                            addproductdata,
                                                            SetOptions(
                                                                merge: true));
                                                  }
                                                });
                                                if (entry == null) {
                                                  showCart();
                                                }
                                              },
                                              child: Text(
                                                'ADD',
                                                style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 31, 89, 41),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              } else
                                return Center(
                                    child: CircularProgressIndicator());
                            },
                          ),
                          FutureBuilder<Map<String, dynamic>>(
                            future: getBundles('Advanced Baby Care'),
                            builder: (context,
                                AsyncSnapshot<Map<String, dynamic>> snapshot) {
                              if (snapshot.hasData) {
                                var bundledata = snapshot.data;
                                return InkWell(
                                  onTap: () {
                                    Navigator.pushReplacement(
                                        context,
                                        SingleProductScreen.route(
                                            category: 'Bundles',
                                            docName: 'Advanced Baby Care'));
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 5),
                                    width: (MediaQuery.of(context).size.width /
                                            2) -
                                        25,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Image.network(
                                            '${bundledata!['image']}'),
                                        Text(
                                          '${bundledata['Name']}',
                                          style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 114, 114, 114),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Text(
                                          '3 month of Baby care products',
                                          style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 114, 114, 114),
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '₹${bundledata['Price']}',
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 31, 89, 41),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                            OutlinedButton(
                                              onPressed: () {
                                                var userId = FirebaseAuth
                                                    .instance.currentUser!.uid;

                                                var docRef = db
                                                    .collection(
                                                        'cart ${userId}')
                                                    .doc('Advanced Baby Care');
                                                docRef.get().then(
                                                    (DocumentSnapshot doc) {
                                                  final data = doc.data()
                                                      as Map<String, dynamic>?;
                                                  if (data?['Quantity'] ==
                                                      null) {
                                                    var addproductdata =
                                                        <String, dynamic>{
                                                      "Name":
                                                          "${bundledata['Name']}",
                                                      "Weight": " ",
                                                      "Price":
                                                          "${bundledata['Price']}",
                                                      "Image":
                                                          "${bundledata['image']}",
                                                      "Quantity": "1"
                                                    };

                                                    db
                                                        .collection(
                                                            'cart ${userId}')
                                                        .doc(
                                                            'Advanced Baby Care')
                                                        .set(addproductdata);
                                                  } else if (data?[
                                                          'Quantity'] ==
                                                      '0') {
                                                    var addproductdata =
                                                        <String, dynamic>{
                                                      "Name":
                                                          "${bundledata['Name']}",
                                                      "Weight": "",
                                                      "Price":
                                                          "${bundledata['Price']}",
                                                      "Image":
                                                          "${bundledata['image']}",
                                                      "Quantity": "1"
                                                    };

                                                    db
                                                        .collection(
                                                            'cart ${userId}')
                                                        .doc(
                                                            'Advanced Baby Care')
                                                        .set(addproductdata);
                                                  } else {
                                                    var newquantity = int.parse(
                                                            data?['Quantity']) +
                                                        1;
                                                    var addproductdata =
                                                        <String, dynamic>{
                                                      "Quantity":
                                                          "${newquantity}"
                                                    };

                                                    db
                                                        .collection(
                                                            'cart ${userId}')
                                                        .doc(
                                                            'Advanced Baby Care')
                                                        .set(
                                                            addproductdata,
                                                            SetOptions(
                                                                merge: true));
                                                  }
                                                });
                                                if (entry == null) {
                                                  showCart();
                                                }
                                              },
                                              child: Text(
                                                'ADD',
                                                style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 31, 89, 41),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              } else
                                return Center(
                                    child: CircularProgressIndicator());
                            },
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FutureBuilder<Map<String, dynamic>>(
                            future: getBundles('Everyday Groceries (For 1)'),
                            builder: (context, snapshot) {
                              var bundledata = snapshot.data;
                              if (snapshot.hasData) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.pushReplacement(
                                        context,
                                        SingleProductScreen.route(
                                            category: 'Bundles',
                                            docName:
                                                'Everyday Groceries (For 1)'));
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 5),
                                    width: (MediaQuery.of(context).size.width /
                                            2) -
                                        25,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Image.network(
                                            '${bundledata!['image']}'),
                                        Text(
                                          '${bundledata['Name']}',
                                          style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 114, 114, 114),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Text(
                                          'Essential Groceries for you!',
                                          style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 114, 114, 114),
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '₹${bundledata['Price']}',
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 31, 89, 41),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                            OutlinedButton(
                                              onPressed: () {
                                                var userId = FirebaseAuth
                                                    .instance.currentUser!.uid;

                                                var docRef = db
                                                    .collection(
                                                        'cart ${userId}')
                                                    .doc(
                                                        'Everyday Groceries (For 1)');
                                                docRef.get().then(
                                                    (DocumentSnapshot doc) {
                                                  final data = doc.data()
                                                      as Map<String, dynamic>?;
                                                  if (data?['Quantity'] ==
                                                      null) {
                                                    var addproductdata =
                                                        <String, dynamic>{
                                                      "Name":
                                                          "${bundledata['Name']}",
                                                      "Weight": " ",
                                                      "Price":
                                                          "${bundledata['Price']}",
                                                      "Image":
                                                          "${bundledata['image']}",
                                                      "Quantity": "1"
                                                    };

                                                    db
                                                        .collection(
                                                            'cart ${userId}')
                                                        .doc(
                                                            'Everyday Groceries (For 1)')
                                                        .set(addproductdata);
                                                  } else if (data?[
                                                          'Quantity'] ==
                                                      '0') {
                                                    var addproductdata =
                                                        <String, dynamic>{
                                                      "Name":
                                                          "${bundledata['Name']}",
                                                      "Weight": "",
                                                      "Price":
                                                          "${bundledata['Price']}",
                                                      "Image":
                                                          "${bundledata['image']}",
                                                      "Quantity": "1"
                                                    };

                                                    db
                                                        .collection(
                                                            'cart ${userId}')
                                                        .doc(
                                                            'Everyday Groceries (For 1)')
                                                        .set(addproductdata);
                                                  } else {
                                                    var newquantity = int.parse(
                                                            data?['Quantity']) +
                                                        1;
                                                    var addproductdata =
                                                        <String, dynamic>{
                                                      "Quantity":
                                                          "${newquantity}"
                                                    };

                                                    db
                                                        .collection(
                                                            'cart ${userId}')
                                                        .doc(
                                                            'Everyday Groceries (For 1)')
                                                        .set(
                                                            addproductdata,
                                                            SetOptions(
                                                                merge: true));
                                                  }
                                                });
                                                if (entry == null) {
                                                  showCart();
                                                }
                                              },
                                              child: Text(
                                                'ADD',
                                                style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 31, 89, 41),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              } else
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                            },
                          ),
                          FutureBuilder<Map<String, dynamic>>(
                            future:
                                getBundles('Everyday Groceries (For Family)'),
                            builder: (context, snapshot) {
                              var bundledata = snapshot.data;
                              if (snapshot.hasData) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.pushReplacement(
                                        context,
                                        SingleProductScreen.route(
                                            category: 'Bundles',
                                            docName:
                                                'Everyday Groceries (For Family)'));
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 5),
                                    width: (MediaQuery.of(context).size.width /
                                            2) -
                                        25,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Image.network(
                                            '${bundledata!['image']}'),
                                        Text(
                                          '${bundledata['Name']}',
                                          style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 114, 114, 114),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Text(
                                          'Groceries for a healthy family.',
                                          style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 114, 114, 114),
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '₹${bundledata['Price']}',
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 31, 89, 41),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                            OutlinedButton(
                                              onPressed: () {
                                                var userId = FirebaseAuth
                                                    .instance.currentUser!.uid;

                                                var docRef = db
                                                    .collection(
                                                        'cart ${userId}')
                                                    .doc(
                                                        'Everyday Groceries (For Family)');
                                                docRef.get().then(
                                                    (DocumentSnapshot doc) {
                                                  final data = doc.data()
                                                      as Map<String, dynamic>?;
                                                  if (data?['Quantity'] ==
                                                      null) {
                                                    var addproductdata =
                                                        <String, dynamic>{
                                                      "Name":
                                                          "${bundledata['Name']}",
                                                      "Weight": " ",
                                                      "Price":
                                                          "${bundledata['Price']}",
                                                      "Image":
                                                          "${bundledata['image']}",
                                                      "Quantity": "1"
                                                    };

                                                    db
                                                        .collection(
                                                            'cart ${userId}')
                                                        .doc(
                                                            'Everyday Groceries (For Family)')
                                                        .set(addproductdata);
                                                  } else if (data?[
                                                          'Quantity'] ==
                                                      '0') {
                                                    var addproductdata =
                                                        <String, dynamic>{
                                                      "Name":
                                                          "${bundledata['Name']}",
                                                      "Weight": "",
                                                      "Price":
                                                          "${bundledata['Price']}",
                                                      "Image":
                                                          "${bundledata['image']}",
                                                      "Quantity": "1"
                                                    };

                                                    db
                                                        .collection(
                                                            'cart ${userId}')
                                                        .doc(
                                                            'Everyday Groceries (For Family)')
                                                        .set(addproductdata);
                                                  } else {
                                                    var newquantity = int.parse(
                                                            data?['Quantity']) +
                                                        1;
                                                    var addproductdata =
                                                        <String, dynamic>{
                                                      "Quantity":
                                                          "${newquantity}"
                                                    };

                                                    db
                                                        .collection(
                                                            'cart ${userId}')
                                                        .doc(
                                                            'Everyday Groceries (For Family)')
                                                        .set(
                                                            addproductdata,
                                                            SetOptions(
                                                                merge: true));
                                                  }
                                                });
                                                if (entry == null) {
                                                  showCart();
                                                }
                                              },
                                              child: Text(
                                                'ADD',
                                                style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 31, 89, 41),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              } else
                                return Center(
                                    child: CircularProgressIndicator());
                            },
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    const Text(
                      'BRANDS WE HAVE',
                      style: TextStyle(
                        color: Color.fromARGB(255, 114, 114, 114),
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Container(
                      height: 75,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        children: [
                          Image.asset(
                            'assets/laysicon.png',
                            width: 75,
                          ),
                          Image.asset(
                            'assets/Maggi.png',
                            width: 75,
                          ),
                          Image.asset(
                            'assets/Nestle.png',
                            width: 75,
                          ),
                          Image.asset(
                            'assets/Pedigree.png',
                            width: 75,
                          ),
                          Image.asset(
                            'assets/Aashirwad.png',
                            width: 75,
                          ),
                          Image.asset(
                            'assets/Britannia.png',
                            width: 75,
                          ),
                          Image.asset(
                            'assets/Surf-excel.png',
                            width: 75,
                          ),
                          Image.asset(
                            'assets/Amul.png',
                            width: 75,
                          ),
                          Image.asset(
                            'assets/Nivea.png',
                            width: 75,
                          ),
                          Image.asset(
                            'assets/Pampers.png',
                            width: 75,
                          ),
                          Image.asset(
                            'assets/Pepsi.png',
                            width: 75,
                          ),
                          Image.asset(
                            'assets/Whiskas.png',
                            width: 75,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ), // Main Column
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}

Future<Map<String, dynamic>> getBundles(String input) async {
  Map<String, dynamic> twomunchies = {};
  await db
      .collection('Bundles')
      .doc('Munchies For 2')
      .get()
      .then((DocumentSnapshot doc) {
    twomunchies = doc.data() as Map<String, dynamic>;
  });
  Map<String, dynamic> fourmunchies = {};
  await db
      .collection('Bundles')
      .doc('Munchies For 4')
      .get()
      .then((DocumentSnapshot doc) {
    fourmunchies = doc.data() as Map<String, dynamic>;
  });
  Map<String, dynamic> onegroceries = {};
  await db
      .collection('Bundles')
      .doc('Everyday Groceries (For 1)')
      .get()
      .then((DocumentSnapshot doc) {
    onegroceries = doc.data() as Map<String, dynamic>;
  });
  Map<String, dynamic> twogroceries = {};
  await db
      .collection('Bundles')
      .doc('Everyday Groceries (For Family)')
      .get()
      .then((DocumentSnapshot doc) {
    twogroceries = doc.data() as Map<String, dynamic>;
  });
  Map<String, dynamic> essentialbaby = {};
  await db
      .collection('Bundles')
      .doc('Essential Baby Care')
      .get()
      .then((DocumentSnapshot doc) {
    essentialbaby = doc.data() as Map<String, dynamic>;
  });
  Map<String, dynamic> advancedbaby = {};
  await db
      .collection('Bundles')
      .doc('Advanced Baby Care')
      .get()
      .then((DocumentSnapshot doc) {
    advancedbaby = doc.data() as Map<String, dynamic>;
  });
  if (input == 'Munchies For 2') {
    return await twomunchies;
  } else if (input == 'Munchies For 4') {
    return await fourmunchies;
  } else if (input == 'Everyday Groceries (For 1)') {
    return await onegroceries;
  } else if (input == 'Everyday Groceries (For Family)') {
    return await twogroceries;
  } else if (input == 'Essential Baby Care') {
    return await essentialbaby;
  } else if (input == 'Advanced Baby Care') {
    return await advancedbaby;
  }
  return twomunchies;
}
