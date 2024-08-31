import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';

import 'package:apploja/router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /* await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyDTKuK_9HWTlZTTQAUhHGByqq6VfsN0SnQ",
          authDomain: "bd-firestore-dd770.firebaseapp.com",
          projectId: "bd-firestore-dd770",
          storageBucket: "bd-firestore-dd770.appspot.com",
          messagingSenderId: "866694630343",
          appId: "1:866694630343:web:f73535a57f936afe06e7e2")); */

  //await dotenv.load(fileName: "assets/.env");
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  static const primaryColor = Colors.orange;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Exemplo CRUD Firestore',
      theme: ThemeData(primarySwatch: MyApp.primaryColor),
      initialRoute: '/',

      //Gerador de rotas - navegação entre as telas
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
