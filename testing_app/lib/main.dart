import 'package:flutter/material.dart';
import 'First_page.dart';
import 'package:localstorage/localstorage.dart';
//import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'Login/login.dart';
import 'package:firebase_core/firebase_core.dart';

//Main Function which run by default
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();

  // Initialize Firebase
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyCUyxxufqAAv8keeLMretLSI7BLU94nu60",
          authDomain: "instabook-sign-in.firebaseapp.com",
          projectId: "instabook-sign-in",
          storageBucket: "instabook-sign-in.appspot.com",
          messagingSenderId: "755978359706",
          appId: "1:755978359706:web:1fb4aa52166717c633a023",
          measurementId: "G-TG4KZM573Z"));
  runApp(const MyApp());
}

//My app widget which called by main function theam and routings all will include
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    LocalStorage storage = LocalStorage("usertoken");

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white70,
        dividerColor: Colors.white,
        brightness: Brightness.light,
      ),
      home: FutureBuilder(
        future: storage.ready,
        builder: (context, snapshop) {
          if (snapshop.data == null) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (storage.getItem('token') == null) {
            return loginpage("");
          }
          return get_ueser_widget(0);
        },
      ),
    );
  }
}
