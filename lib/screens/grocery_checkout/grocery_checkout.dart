import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';

class GroceryCheckoutScreen extends StatelessWidget {
  static const String routeName = '/yanscheckout';
  bool _customTileExpanded = false;

  static Route route() {
    return MaterialPageRoute(
        builder: (_) => GroceryCheckoutScreen(),
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
        title: Text(
          'BILL TOTAL: ₹80',
          style: TextStyle(
            color: Color.fromARGB(255, 114, 114, 114),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              padding: const EdgeInsets.only(top: 20, left: 18, bottom: 20),
              child: Wrap(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.store_outlined,
                        color: Color.fromARGB(255, 114, 114, 114),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Yans Mart',
                            style: TextStyle(
                                color: Color.fromARGB(255, 70, 69, 69),
                                fontSize: 12,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            'Unit No 1, Ground Floor, Hno: 16-11-16',
                            style: TextStyle(
                              color: Color.fromARGB(255, 112, 112, 112),
                              fontSize: 10,
                              fontWeight: FontWeight.w300,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Dash(
                      direction: Axis.vertical,
                      length: 20,
                      dashLength: 2,
                      dashThickness: 1.2,
                      dashColor: Color.fromARGB(255, 112, 112, 112),
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.home_outlined,
                        color: Color.fromARGB(255, 114, 114, 114),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Home',
                            style: TextStyle(
                                color: Color.fromARGB(255, 70, 69, 69),
                                fontSize: 12,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            'Banjara Hills Rd No 12, Hno 12-1-278',
                            style: TextStyle(
                              color: Color.fromARGB(255, 112, 112, 112),
                              fontSize: 10,
                              fontWeight: FontWeight.w300,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.topLeft,
              decoration:
                  const BoxDecoration(color: Color.fromARGB(51, 31, 89, 41)),
              child: Text(
                'Delivery Time: In next 15 - 20 mins',
                style: TextStyle(
                    color: Color.fromARGB(255, 31, 89, 41),
                    fontWeight: FontWeight.w300,
                    fontSize: 12),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              child: Text(
                'PREFFERED PAYMENT',
                style: TextStyle(
                    color: Color.fromARGB(255, 70, 69, 69),
                    fontSize: 12,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  VisaCard(),
                  Dash(
                    direction: Axis.horizontal,
                    length: MediaQuery.of(context).size.width - 40,
                    dashThickness: 1,
                    dashColor: Color.fromARGB(255, 114, 114, 114),
                  ),
                  GpayCard(),
                ],
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              child: Text(
                'CREDIT & DEBIT CARDS',
                style: TextStyle(
                    color: Color.fromARGB(255, 70, 69, 69),
                    fontSize: 12,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  VisaCard(),
                  Dash(
                    direction: Axis.horizontal,
                    length: MediaQuery.of(context).size.width - 40,
                    dashThickness: 1,
                    dashColor: Color.fromARGB(255, 114, 114, 114),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 18),
                    child: Wrap(
                      direction: Axis.horizontal,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 20,
                      children: [
                        Icon(
                          Icons.add_circle_outline_outlined,
                          color: Color.fromARGB(255, 31, 89, 41),
                          size: 35,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'ADD NEW CARD',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 31, 89, 41),
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              'Save and pay via Cards.',
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 10,
                                color: Color.fromARGB(255, 112, 112, 112),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              child: Text(
                'UPI',
                style: TextStyle(
                    color: Color.fromARGB(255, 70, 69, 69),
                    fontSize: 12,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  GpayCard(),
                  Dash(
                    direction: Axis.horizontal,
                    length: MediaQuery.of(context).size.width - 40,
                    dashThickness: 1,
                    dashColor: Color.fromARGB(255, 114, 114, 114),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 18),
                    child: Wrap(
                      direction: Axis.horizontal,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 20,
                      children: [
                        Icon(
                          Icons.add_circle_outline_outlined,
                          color: Color.fromARGB(255, 31, 89, 41),
                          size: 35,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'ADD A NEW UPI',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 31, 89, 41),
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              'Save and pay via UPI.',
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 10,
                                color: Color.fromARGB(255, 112, 112, 112),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ), // Main Body Column
    );
  }
}

class VisaCard extends StatefulWidget {
  const VisaCard({
    Key? key,
  }) : super(key: key);

  @override
  State<VisaCard> createState() => _VisaCardState();
}

class _VisaCardState extends State<VisaCard> {
  bool _isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Wrap(
        direction: Axis.horizontal,
        spacing: 15,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Image.asset(
            'assets/visa.png',
            width: 25,
          ),
          Text(
            '●●●● 1234',
            style: TextStyle(
              color: Color.fromARGB(255, 112, 112, 112),
              fontSize: 14,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 97, 163, 219),
              border: Border.all(
                color: Color.fromARGB(255, 97, 163, 219),
              ),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              Icon(
                Icons.verified_user_outlined,
                color: Colors.white,
                size: 16,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                'Secured',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 10),
              )
            ]),
          ),
        ],
      ),
      trailing: Icon(
        _isExpanded
            ? (Icons.check_circle_rounded)
            : Icons.radio_button_unchecked_outlined,
        color: _isExpanded ? Color.fromARGB(255, 31, 89, 41) : Colors.grey,
      ),
      onExpansionChanged: (value) {
        setState(() {
          _isExpanded = value;
        });
      },
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 17),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                width: 50,
                height: 30,
                child: TextField(
                  textAlignVertical: TextAlignVertical.center,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12),
                  decoration: new InputDecoration(
                    hintText: 'CVV',
                    contentPadding: const EdgeInsets.only(
                        top: 5, bottom: 5, left: 8, right: 8),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 31, 89, 41),
                        width: 1,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 31, 89, 41),
                        width: 1,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 15,
              ),
              SizedBox(
                height: 30,
                child: ElevatedButton(
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all(0),
                    backgroundColor: MaterialStateProperty.all(
                        Color.fromARGB(255, 31, 89, 41)),
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(
                            horizontal: 80, vertical: 0)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    'PAY ₹80',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1,
                      fontSize: 12,
                    ),
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}

class GpayCard extends StatefulWidget {
  const GpayCard({
    Key? key,
  }) : super(key: key);

  @override
  State<GpayCard> createState() => _GpayCardState();
}

class _GpayCardState extends State<GpayCard> {
  bool _isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Wrap(
        direction: Axis.horizontal,
        spacing: 15,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Image.asset(
            'assets/gpay.png',
            width: 25,
          ),
          Text(
            'youremailaddress@okbankname',
            style: TextStyle(
                color: Color.fromARGB(255, 112, 112, 112),
                fontWeight: FontWeight.w600,
                fontSize: 14),
          )
        ],
      ),
      trailing: Icon(
        _isExpanded
            ? (Icons.check_circle_rounded)
            : Icons.radio_button_unchecked_outlined,
        color: _isExpanded ? Color.fromARGB(255, 31, 89, 41) : Colors.grey,
      ),
      onExpansionChanged: (value) {
        setState(() {
          _isExpanded = value;
        });
      },
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 17),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                height: 30,
                child: ElevatedButton(
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all(0),
                    backgroundColor: MaterialStateProperty.all(
                        Color.fromARGB(255, 31, 89, 41)),
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(
                            horizontal: 80, vertical: 0)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    'PAY ₹80',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1,
                      fontSize: 12,
                    ),
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
