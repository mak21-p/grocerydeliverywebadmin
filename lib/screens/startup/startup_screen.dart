import 'package:flutter/material.dart';

class StartupScreen extends StatelessWidget {
  static const String routeName = '/startup';

  static Route route() {
    return MaterialPageRoute(
        builder: (_) => StartupScreen(),
        settings: RouteSettings(name: routeName));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: const EdgeInsets.only(top: 60, bottom: 125),
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
        Color.fromARGB(255, 58, 110, 67),
        Color.fromARGB(255, 20, 77, 30)
      ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Center(
                child: Image(
                  image: AssetImage('assets/logo.png'),
                  width: 175,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  'Delivering Happiness',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18.0,
                      color: Colors.white),
                ),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/login');
            },
            child: const Text(
              'Sign In/Sign Up',
              style: TextStyle(
                  color: Color.fromARGB(255, 35, 90, 44), fontSize: 18.0),
            ),
            style: ButtonStyle(
                elevation: MaterialStateProperty.all<double>(0),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                )),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    const EdgeInsets.only(
                  top: 8.0,
                  bottom: 8.0,
                  left: 55,
                  right: 55,
                )),
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.white)),
          ),
        ],
      ),
    ));
  }
}
