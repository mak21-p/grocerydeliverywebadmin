import 'package:flutter/material.dart';

class AdminScreen extends StatelessWidget {
  static const String routeName = '/adminscreen';

  static Route route() {
    return MaterialPageRoute(
        builder: (_) => AdminScreen(),
        settings: RouteSettings(name: routeName));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Admin Screen')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              'Add Products',
              style: TextStyle(
                  color: Color.fromARGB(255, 31, 89, 41),
                  fontWeight: FontWeight.bold,
                  fontSize: 23),
            ),
            ProductAddSlider(),
            SizedBox(
              height: 20,
            ),
            Text(
              'Remove Products',
              style: TextStyle(
                  color: Color.fromARGB(255, 31, 89, 41),
                  fontWeight: FontWeight.bold,
                  fontSize: 23),
            ),
            SizedBox(
              height: 20,
            ),
            RemoveProductSlider(),
            SizedBox(
              height: 20,
            ),
            OrdersButton()
          ],
        ),
      ),
    );
  }
}

class OrdersButton extends StatelessWidget {
  const OrdersButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/adminorders');
      },
      child: Container(
        width: MediaQuery.of(context).size.width - 50,
        height: 75,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            'View Orders',
            style: TextStyle(
              color: Color.fromARGB(255, 31, 89, 41),
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          Icon(Icons.navigate_next_sharp)
        ]),
      ),
    );
  }
}

class RemoveProductSlider extends StatelessWidget {
  const RemoveProductSlider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: [
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/adminremoveproduct',
                  arguments: 'fruits');
            },
            child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), color: Colors.white),
              alignment: Alignment.center,
              child: Text(
                'Fruits & Vegetables',
                style: TextStyle(
                    color: Color.fromARGB(255, 31, 89, 41),
                    fontWeight: FontWeight.bold,
                    fontSize: 22),
              ),
            ),
          ),
          SizedBox(
            width: 15,
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/adminremoveproduct',
                  arguments: 'dairy');
            },
            child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), color: Colors.white),
              alignment: Alignment.center,
              child: Text(
                'Dairy, Bread & Eggs',
                style: TextStyle(
                    color: Color.fromARGB(255, 31, 89, 41),
                    fontWeight: FontWeight.bold,
                    fontSize: 22),
              ),
            ),
          ),
          SizedBox(
            width: 15,
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/adminremoveproduct',
                  arguments: 'munchies');
            },
            child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), color: Colors.white),
              alignment: Alignment.center,
              child: Text(
                'Munchies',
                style: TextStyle(
                    color: Color.fromARGB(255, 31, 89, 41),
                    fontWeight: FontWeight.bold,
                    fontSize: 22),
              ),
            ),
          ),
          SizedBox(
            width: 15,
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/adminremoveproduct',
                  arguments: 'dessert');
            },
            child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), color: Colors.white),
              alignment: Alignment.center,
              child: Text(
                'Dessert',
                style: TextStyle(
                    color: Color.fromARGB(255, 31, 89, 41),
                    fontWeight: FontWeight.bold,
                    fontSize: 22),
              ),
            ),
          ),
          SizedBox(
            width: 15,
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/adminremoveproduct',
                  arguments: 'drinks');
            },
            child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), color: Colors.white),
              alignment: Alignment.center,
              child: Text(
                'Drinks',
                style: TextStyle(
                    color: Color.fromARGB(255, 31, 89, 41),
                    fontWeight: FontWeight.bold,
                    fontSize: 22),
              ),
            ),
          ),
          SizedBox(
            width: 15,
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/adminremoveproduct',
                  arguments: 'tea');
            },
            child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), color: Colors.white),
              alignment: Alignment.center,
              child: Text(
                'Tea & Coffee',
                style: TextStyle(
                    color: Color.fromARGB(255, 31, 89, 41),
                    fontWeight: FontWeight.bold,
                    fontSize: 22),
              ),
            ),
          ),
          SizedBox(
            width: 15,
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/adminremoveproduct',
                  arguments: 'rice');
            },
            child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), color: Colors.white),
              alignment: Alignment.center,
              child: Text(
                'Rice, Atta & Dal',
                style: TextStyle(
                    color: Color.fromARGB(255, 31, 89, 41),
                    fontWeight: FontWeight.bold,
                    fontSize: 22),
              ),
            ),
          ),
          SizedBox(
            width: 15,
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/adminremoveproduct',
                  arguments: 'oil');
            },
            child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), color: Colors.white),
              alignment: Alignment.center,
              child: Text(
                'Oil',
                style: TextStyle(
                    color: Color.fromARGB(255, 31, 89, 41),
                    fontWeight: FontWeight.bold,
                    fontSize: 22),
              ),
            ),
          ),
          SizedBox(
            width: 15,
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/adminremoveproduct',
                  arguments: 'babycare');
            },
            child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), color: Colors.white),
              alignment: Alignment.center,
              child: Text(
                'Babycare',
                style: TextStyle(
                    color: Color.fromARGB(255, 31, 89, 41),
                    fontWeight: FontWeight.bold,
                    fontSize: 22),
              ),
            ),
          ),
          SizedBox(
            width: 15,
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/adminremoveproduct',
                  arguments: 'meat');
            },
            child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), color: Colors.white),
              alignment: Alignment.center,
              child: Text(
                'Meat',
                style: TextStyle(
                    color: Color.fromARGB(255, 31, 89, 41),
                    fontWeight: FontWeight.bold,
                    fontSize: 22),
              ),
            ),
          ),
          SizedBox(
            width: 15,
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/adminremoveproduct',
                  arguments: 'cleaning');
            },
            child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), color: Colors.white),
              alignment: Alignment.center,
              child: Text(
                'Cleaning Essentials',
                style: TextStyle(
                    color: Color.fromARGB(255, 31, 89, 41),
                    fontWeight: FontWeight.bold,
                    fontSize: 22),
              ),
            ),
          ),
          SizedBox(
            width: 15,
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/adminremoveproduct',
                  arguments: 'personalhygiene');
            },
            child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), color: Colors.white),
              alignment: Alignment.center,
              child: Text(
                'Personal Hygiene',
                style: TextStyle(
                    color: Color.fromARGB(255, 31, 89, 41),
                    fontWeight: FontWeight.bold,
                    fontSize: 22),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProductAddSlider extends StatelessWidget {
  const ProductAddSlider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: [
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/adminaddproduct',
                  arguments: 'fruits');
            },
            child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), color: Colors.white),
              alignment: Alignment.center,
              child: Text(
                'Fruits & Vegetables',
                style: TextStyle(
                    color: Color.fromARGB(255, 31, 89, 41),
                    fontWeight: FontWeight.bold,
                    fontSize: 22),
              ),
            ),
          ),
          SizedBox(
            width: 15,
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/adminaddproduct',
                  arguments: 'dairy');
            },
            child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), color: Colors.white),
              alignment: Alignment.center,
              child: Text(
                'Dairy, Bread & Eggs',
                style: TextStyle(
                    color: Color.fromARGB(255, 31, 89, 41),
                    fontWeight: FontWeight.bold,
                    fontSize: 22),
              ),
            ),
          ),
          SizedBox(
            width: 15,
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/adminaddproduct',
                  arguments: 'munchies');
            },
            child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), color: Colors.white),
              alignment: Alignment.center,
              child: Text(
                'Munchies',
                style: TextStyle(
                    color: Color.fromARGB(255, 31, 89, 41),
                    fontWeight: FontWeight.bold,
                    fontSize: 22),
              ),
            ),
          ),
          SizedBox(
            width: 15,
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/adminaddproduct',
                  arguments: 'dessert');
            },
            child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), color: Colors.white),
              alignment: Alignment.center,
              child: Text(
                'Dessert',
                style: TextStyle(
                    color: Color.fromARGB(255, 31, 89, 41),
                    fontWeight: FontWeight.bold,
                    fontSize: 22),
              ),
            ),
          ),
          SizedBox(
            width: 15,
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/adminaddproduct',
                  arguments: 'drinks');
            },
            child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), color: Colors.white),
              alignment: Alignment.center,
              child: Text(
                'Drinks',
                style: TextStyle(
                    color: Color.fromARGB(255, 31, 89, 41),
                    fontWeight: FontWeight.bold,
                    fontSize: 22),
              ),
            ),
          ),
          SizedBox(
            width: 15,
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/adminaddproduct',
                  arguments: 'tea');
            },
            child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), color: Colors.white),
              alignment: Alignment.center,
              child: Text(
                'Tea & Coffee',
                style: TextStyle(
                    color: Color.fromARGB(255, 31, 89, 41),
                    fontWeight: FontWeight.bold,
                    fontSize: 22),
              ),
            ),
          ),
          SizedBox(
            width: 15,
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/adminaddproduct',
                  arguments: 'rice');
            },
            child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), color: Colors.white),
              alignment: Alignment.center,
              child: Text(
                'Rice, Atta & Dal',
                style: TextStyle(
                    color: Color.fromARGB(255, 31, 89, 41),
                    fontWeight: FontWeight.bold,
                    fontSize: 22),
              ),
            ),
          ),
          SizedBox(
            width: 15,
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/adminaddproduct',
                  arguments: 'oil');
            },
            child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), color: Colors.white),
              alignment: Alignment.center,
              child: Text(
                'Oil',
                style: TextStyle(
                    color: Color.fromARGB(255, 31, 89, 41),
                    fontWeight: FontWeight.bold,
                    fontSize: 22),
              ),
            ),
          ),
          SizedBox(
            width: 15,
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/adminaddproduct',
                  arguments: 'babycare');
            },
            child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), color: Colors.white),
              alignment: Alignment.center,
              child: Text(
                'Babycare',
                style: TextStyle(
                    color: Color.fromARGB(255, 31, 89, 41),
                    fontWeight: FontWeight.bold,
                    fontSize: 22),
              ),
            ),
          ),
          SizedBox(
            width: 15,
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/adminaddproduct',
                  arguments: 'meat');
            },
            child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), color: Colors.white),
              alignment: Alignment.center,
              child: Text(
                'Meat',
                style: TextStyle(
                    color: Color.fromARGB(255, 31, 89, 41),
                    fontWeight: FontWeight.bold,
                    fontSize: 22),
              ),
            ),
          ),
          SizedBox(
            width: 15,
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/adminaddproduct',
                  arguments: 'cleaning');
            },
            child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), color: Colors.white),
              alignment: Alignment.center,
              child: Text(
                'Cleaning Essentials',
                style: TextStyle(
                    color: Color.fromARGB(255, 31, 89, 41),
                    fontWeight: FontWeight.bold,
                    fontSize: 22),
              ),
            ),
          ),
          SizedBox(
            width: 15,
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/adminaddproduct',
                  arguments: 'personalhygiene');
            },
            child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), color: Colors.white),
              alignment: Alignment.center,
              child: Text(
                'Personal Hygiene',
                style: TextStyle(
                    color: Color.fromARGB(255, 31, 89, 41),
                    fontWeight: FontWeight.bold,
                    fontSize: 22),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
