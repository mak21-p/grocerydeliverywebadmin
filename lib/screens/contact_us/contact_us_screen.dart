import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsScreen extends StatelessWidget {
  static const String routeName = '/contactus';

  static Route route() {
    return MaterialPageRoute(
        builder: (_) => ContactUsScreen(),
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
          'CONTACT US',
          style: TextStyle(
            color: Color.fromARGB(255, 114, 114, 114),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
      ),
      body: Column(
        children: [
          InkWell(
            onTap: () {
              Uri uri = Uri(scheme: 'tel', path: '+919390934231');
              launchUrl(uri);
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(
                    color: Color(0xFFF5F5F5),
                  ),
                  bottom: BorderSide(
                    color: Color(0xFFF5F5F5),
                  ),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Issues with Previous Orders',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      color: Color.fromARGB(255, 114, 114, 114),
                    ),
                  ),
                  Icon(
                    Icons.navigate_next,
                    color: Color.fromARGB(255, 114, 114, 114),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Uri uri = Uri(scheme: 'tel', path: '+919390934231');
              launchUrl(uri);
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(
                    color: Color(0xFFF5F5F5),
                  ),
                  bottom: BorderSide(
                    color: Color(0xFFF5F5F5),
                  ),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
              child: const Text(
                'General Issues',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  color: Color.fromARGB(255, 114, 114, 114),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/termsandconditions');
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(
                    color: Color(0xFFF5F5F5),
                  ),
                  bottom: BorderSide(
                    color: Color(0xFFF5F5F5),
                  ),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
              child: const Text(
                'Terms & Conditions',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  color: Color.fromARGB(255, 114, 114, 114),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/yansfaq');
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(
                    color: Color(0xFFF5F5F5),
                  ),
                  bottom: BorderSide(
                    color: Color(0xFFF5F5F5),
                  ),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
              child: const Text(
                'FAQs',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  color: Color.fromARGB(255, 114, 114, 114),
                ),
              ),
            ),
          ),
        ],
      ), //Main Column
    );
  }
}
