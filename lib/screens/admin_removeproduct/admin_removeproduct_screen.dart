import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminRemoveProductScreen extends StatelessWidget {
  static const String routeName = '/adminremoveproduct';

  const AdminRemoveProductScreen({super.key, required this.category});

  static Route route({required String category}) {
    return MaterialPageRoute(
        builder: (_) => AdminRemoveProductScreen(
              category: category,
            ),
        settings: RouteSettings(name: routeName));
  }

  final String category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RemoveProductStream(
        parameter: category,
      ),
    );
  }
}

class RemoveProductStream extends StatefulWidget {
  final String parameter;
  const RemoveProductStream({Key? key, required this.parameter})
      : super(key: key);

  @override
  State<RemoveProductStream> createState() => _RemoveProductStreamState();
}

class _RemoveProductStreamState extends State<RemoveProductStream> {
  @override
  Widget build(BuildContext context) {
    var stream = FirebaseFirestore.instance
        .collection('${widget.parameter}')
        .snapshots();
    return StreamBuilder<QuerySnapshot>(
      stream: stream,
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
                      Image.network(
                        snapshot.data!.docs[index]['image'],
                        width: 75,
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
                            onPressed: () {
                              final collection = FirebaseFirestore.instance
                                  .collection('${widget.parameter}');
                              collection
                                  .doc('${snapshot.data!.docs[index]['Name']}')
                                  .delete()
                                  .then((_) => log('Deleted'))
                                  .catchError((e) => log('Failed: $e'));
                            },
                            child: Text(
                              'Remove',
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
          },
        );
      }),
    );
  }
}
