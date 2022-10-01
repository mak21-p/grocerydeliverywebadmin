import 'dart:io';
import 'dart:math';
import 'dart:html' as html;

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:mime_type/mime_type.dart';
import 'package:path/path.dart' as Path;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker_for_web/image_picker_for_web.dart';

List<String> fruits = <String>[
  'Select Item',
  'Fresh Vegetable',
  'Fresh Fruits',
  'Leafys And Seasonings',
  'Exotic',
  'Organic'
];

List<String> dairy = <String>[
  'Select Item',
  'Milk',
  'Bread And Buns',
  'Eggs',
  'Butter and Cheese',
  'Curd'
];

List<String> munchies = <String>[
  'Select Item',
  'Chips',
  'Namkeen',
  'Popcorn',
  'Frozen Munchies',
  'Value Pack'
];

List<String> dessert = <String>[
  'Select Item',
  'Ice Cream',
  'Chocolates',
  'Sweets',
  'Cookies and Cakes',
  'Candies and Gums'
];

List<String> drinks = <String>[
  'Select Item',
  'Cold Drinks',
  'Energy Drinks',
  'Juices',
  'Soda and Mixers',
  'Water and Ice Cubes'
];

List<String> tea = <String>[
  'Select Item',
  'Tea',
  'Coffee',
  'Health Drink',
  'Vegan Drinks',
  'Instant Drink Mixes'
];

List<String> rice = <String>[
  'Select Item',
  'Atta',
  'Rice',
  'Pulses',
  'Other Flours',
  'Other Pulses'
];

List<String> oil = <String>[
  'Select Item',
  'Edible Oil',
  'Ghee',
  'Masala',
  'Salt, Sugar & Jaggery',
  'Dry Fruits'
];

List<String> babycare = <String>[
  'Select Item',
  'Baby Food',
  'Diapers and Wipes',
  'Baby Bath & Skin',
  'Wound Care & Pain',
  'Cough and Cold'
];

List<String> meat = <String>[
  'Select Item',
  'Fresh Meat',
  'Frozen Meat',
  'Marinated Meat',
  'Plant Based Meat',
  'Eggs'
];

List<String> cleaning = <String>[
  'Select Item',
  'Fabric Care',
  'Surface Cleaner',
  'Toilet Cleaner',
  'Utensil Cleaner',
  'Disinfectant'
];

List<String> personalhygiene = <String>[
  'Select Item',
  'Soap',
  'Shampoo',
  'Lotion',
  'Toothpaste',
  'Feminine Care'
];

class AdminAddProductScreen extends StatefulWidget {
  static const String routeName = '/adminaddproduct';

  const AdminAddProductScreen({super.key, required this.category});

  static Route route({required String category}) {
    return MaterialPageRoute(
        builder: (_) => AdminAddProductScreen(
              category: category,
            ),
        settings: RouteSettings(name: routeName));
  }

  final String category;

  @override
  State<AdminAddProductScreen> createState() => _AdminAddProductScreenState();
}

var visible = true;

class _AdminAddProductScreenState extends State<AdminAddProductScreen> {
  String imageurl = ' ';
  var _nametext = TextEditingController();
  var _weighttext = TextEditingController();
  var _pricetext = TextEditingController();
  var _tagtext = TextEditingController();
  var _desctext = TextEditingController();
  ValueNotifier<int> controller = ValueNotifier<int>(0);

  UploadTask? uploadTask;
  var urlDownload;
  var urlDownload2;
  var urlDownload3;
  String dropdownvalue = 'Select Item';
  html.File? _cloudFile;
  Uint8List? _fileBytes;

  Future uploadFile() async {
    Random rand1 = new Random();
    int random1 = rand1.nextInt(100);
    Random rand2 = new Random();
    int random2 = rand2.nextInt(1000);
    Random rand3 = new Random();
    int random3 = rand3.nextInt(10000);

    String path = '${widget.category}/${_nametext.text} ${random1}';

    final ref = FirebaseStorage.instance.ref().child(path);
    uploadTask = ref.putData(_fileBytes!);

    final snapshot = await uploadTask!.whenComplete(() {
      print('1 done');
    });

    urlDownload = await snapshot.ref.getDownloadURL();
    print(urlDownload);

    final db = FirebaseFirestore.instance;
  }

  Future finalupload() async {
    controller.value += 1;
    visible = false;
    await Future.wait([uploadFile()]);
    final db = FirebaseFirestore.instance;
    print('1: ' + urlDownload);
    print('2: ' + urlDownload2);
    print('3: ' + urlDownload3);
    final NewProduct = <String, dynamic>{
      "Name": _nametext.text,
      "Price": _pricetext.text,
      "Weight": _weighttext.text,
      "image": "${urlDownload}",
      "description": _desctext.text
    };

    db
        .collection('${widget.category}')
        .doc('${_nametext.text}')
        .set(NewProduct, SetOptions(merge: false))
        .then((value) {
      visible = true;
      controller.value += 1;
    });
  }

  Future selectFile() async {
    var mediaData = await ImagePickerWeb.getImageInfo;
    String? mimeType = mime(Path.basename(mediaData!.fileName!));
    html.File mediaFile =
        new html.File(mediaData.data!, mediaData.fileName!, {'type': mimeType});

    if (mediaFile != null) {
      setState(() {
        _cloudFile = mediaFile;
        _fileBytes = mediaData.data;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ValueListenableBuilder(
      valueListenable: controller,
      builder: (context, value, child) {
        return (visible == true)
            ? SingleChildScrollView(
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    'Add ${widget.category} Product',
                    style: TextStyle(
                        color: Color.fromARGB(255, 31, 89, 41),
                        fontWeight: FontWeight.bold,
                        fontSize: 23),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Name',
                          style: TextStyle(
                            color: Color.fromARGB(255, 31, 89, 41),
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                          child: TextField(
                            controller: _nametext,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              prefixIcon: Icon(Icons.drive_file_rename_outline),
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
                              hintText: 'Name',
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Text(
                          'Weight',
                          style: TextStyle(
                            color: Color.fromARGB(255, 31, 89, 41),
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                          child: TextField(
                            controller: _weighttext,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              prefixIcon: Icon(Icons.monitor_weight_outlined),
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
                              hintText: 'Weight',
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Text(
                          'Price',
                          style: TextStyle(
                            color: Color.fromARGB(255, 31, 89, 41),
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                          child: TextField(
                            controller: _pricetext,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              prefixIcon: Icon(Icons.currency_rupee),
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
                              hintText: 'Price',
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Text(
                          'Description',
                          style: TextStyle(
                            color: Color.fromARGB(255, 31, 89, 41),
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        SizedBox(
                          child: TextField(
                            controller: _desctext,
                            maxLines: 5,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              prefixIcon: Icon(Icons.description),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  width: 3.0,
                                  color: Color.fromARGB(255, 38, 93, 48),
                                ),
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(50.0)),
                              hintText: 'Description',
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Text(
                          'Tags',
                          style: TextStyle(
                            color: Color.fromARGB(255, 31, 89, 41),
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        if (widget.category == 'fruits')
                          DropdownButton<String>(
                              value: dropdownvalue,
                              items: fruits.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (String? value) {
                                setState(() {
                                  dropdownvalue = value!;
                                });
                              }),
                        if (widget.category == 'dairy')
                          DropdownButton<String>(
                              value: dropdownvalue,
                              items: dairy.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (String? value) {
                                setState(() {
                                  dropdownvalue = value!;
                                });
                              }),
                        if (widget.category == 'munchies')
                          DropdownButton<String>(
                              value: dropdownvalue,
                              items: munchies.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (String? value) {
                                setState(() {
                                  dropdownvalue = value!;
                                });
                              }),
                        if (widget.category == 'dessert')
                          DropdownButton<String>(
                              value: dropdownvalue,
                              items: dessert.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (String? value) {
                                setState(() {
                                  dropdownvalue = value!;
                                });
                              }),
                        if (widget.category == 'drinks')
                          DropdownButton<String>(
                              value: dropdownvalue,
                              items: drinks.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (String? value) {
                                setState(() {
                                  dropdownvalue = value!;
                                });
                              }),
                        if (widget.category == 'tea')
                          DropdownButton<String>(
                              value: dropdownvalue,
                              items: tea.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (String? value) {
                                setState(() {
                                  dropdownvalue = value!;
                                });
                              }),
                        if (widget.category == 'rice')
                          DropdownButton<String>(
                              value: dropdownvalue,
                              items: rice.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (String? value) {
                                setState(() {
                                  dropdownvalue = value!;
                                });
                              }),
                        if (widget.category == 'oil')
                          DropdownButton<String>(
                              value: dropdownvalue,
                              items: oil.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (String? value) {
                                setState(() {
                                  dropdownvalue = value!;
                                });
                              }),
                        if (widget.category == 'babycare')
                          DropdownButton<String>(
                              value: dropdownvalue,
                              items: babycare.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (String? value) {
                                setState(() {
                                  dropdownvalue = value!;
                                });
                              }),
                        if (widget.category == 'meat')
                          DropdownButton<String>(
                              value: dropdownvalue,
                              items: meat.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (String? value) {
                                setState(() {
                                  dropdownvalue = value!;
                                });
                              }),
                        if (widget.category == 'cleaning')
                          DropdownButton<String>(
                              value: dropdownvalue,
                              items: cleaning.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (String? value) {
                                setState(() {
                                  dropdownvalue = value!;
                                });
                              }),
                        if (widget.category == 'personalhygiene')
                          DropdownButton<String>(
                              value: dropdownvalue,
                              items: personalhygiene
                                  .map<DropdownMenuItem<String>>(
                                      (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (String? value) {
                                setState(() {
                                  dropdownvalue = value!;
                                });
                              }),
                        SizedBox(
                          height: 25,
                        ),
                        Text(
                          'Image',
                          style: TextStyle(
                            color: Color.fromARGB(255, 31, 89, 41),
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                          ),
                        ),
                        Center(
                          child: ElevatedButton(
                            onPressed: selectFile,
                            child: Text(
                              'Pick Image (Fill Name Text First!)',
                            ),
                            style: ButtonStyle(
                              elevation: MaterialStateProperty.all(0),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Color.fromARGB(255, 31, 89, 41)),
                              padding:
                                  MaterialStateProperty.all<EdgeInsetsGeometry>(
                                      const EdgeInsets.symmetric(
                                          vertical: 11, horizontal: 10)),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              )),
                            ),
                          ),
                        ),
                        Center(
                          child: ElevatedButton(
                            onPressed: finalupload,
                            child: Text(
                                'Upload Product (Fill all details first!)'),
                            style: ButtonStyle(
                              elevation: MaterialStateProperty.all(0),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Color.fromARGB(255, 31, 89, 41)),
                              padding:
                                  MaterialStateProperty.all<EdgeInsetsGeometry>(
                                      const EdgeInsets.symmetric(
                                          vertical: 11, horizontal: 10)),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              )),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ))
            : Center(child: CircularProgressIndicator());
      },
    ));
  }
}
