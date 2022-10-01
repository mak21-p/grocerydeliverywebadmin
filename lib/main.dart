import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yans/config/app_router.dart';
import 'package:yans/screens/screens.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'config/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    var userId = FirebaseAuth.instance.currentUser?.uid;

    return FirebasePhoneAuthProvider(
      child: MaterialApp(
          title: 'Food Delivery',
          theme: theme(),
          onGenerateRoute: AppRouter.onGenerateRoute,
          initialRoute: AdminScreen.routeName

          /* FirebaseAuth.instance.currentUser == null
                ? StartupScreen.routeName
                : YanshomeScreen.routeName, */
          ),
    );
  }
}
