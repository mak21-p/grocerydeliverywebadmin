import 'package:flutter/material.dart';

class GroceryFaqScreen extends StatelessWidget {
  static const String routeName = '/groceryfaq';

  static Route route() {
    return MaterialPageRoute(
        builder: (_) => GroceryFaqScreen(),
        settings: RouteSettings(name: routeName));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Color.fromARGB(255, 114, 114, 114),
        ),
        elevation: 0,
        title: const Text(
          'FREQUENTLY ASKED QUESTIONS',
          style: TextStyle(
            color: Color.fromARGB(255, 114, 114, 114),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'How do I place an order?',
                style: TextStyle(
                  color: Color.fromARGB(255, 31, 89, 41),
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Text(
                'Make sure you have set a location, Go into any of the 4 categories, add all the products to be purchased and click the bottom button with text \"View Cart \" and make payment from cart screen.',
                style: TextStyle(
                    color: Color.fromARGB(255, 114, 114, 114), fontSize: 15),
              ),
              SizedBox(
                height: 35,
              ),
              Text(
                'How do I set my location?',
                style: TextStyle(
                  color: Color.fromARGB(255, 31, 89, 41),
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Text(
                'In the home screen, click the top left corner with the text \"Home\" and set your location from the popup.',
                style: TextStyle(
                    color: Color.fromARGB(255, 114, 114, 114), fontSize: 15),
              ),
              SizedBox(
                height: 35,
              ),
              Text(
                'I have a problem with my order, how can I get this fixed?',
                style: TextStyle(
                  color: Color.fromARGB(255, 31, 89, 41),
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Text(
                'Call us using the \"Issue with Previous Orders\" button in the previous screen.',
                style: TextStyle(
                    color: Color.fromARGB(255, 114, 114, 114), fontSize: 15),
              ),
              SizedBox(
                height: 35,
              ),
              Text(
                'I received a different product from the one I ordered. What should I do?',
                style: TextStyle(
                  color: Color.fromARGB(255, 31, 89, 41),
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Text(
                'You may call us via the button \"Issue with Previous Orders\" available in the previous screen.',
                style: TextStyle(
                    color: Color.fromARGB(255, 114, 114, 114), fontSize: 15),
              ),
              SizedBox(
                height: 35,
              ),
              Text(
                'How do I change my location?',
                style: TextStyle(
                  color: Color.fromARGB(255, 31, 89, 41),
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Text(
                'You may change your location by going to the home screen and tapping on the top left of the screen where \"Home\" is displayed. From the popup, you may update your map location as well as delivery instructions.',
                style: TextStyle(
                    color: Color.fromARGB(255, 114, 114, 114), fontSize: 15),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
