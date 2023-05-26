import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parchooniwala_user/Global/global.dart';
import 'package:parchooniwala_user/Screens/postalcodenull.dart';
import 'package:parchooniwala_user/Screens/usermainscreen.dart';
import 'package:parchooniwala_user/firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Screens/locationscreen.dart';

Future<void> main() async 
{
  SystemChrome.setSystemUIOverlayStyle
  (
    SystemUiOverlayStyle(
      statusBarColor: Color(0xFFA25FFF)
    )
  );    
  await WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  await Firebase.initializeApp
  (
    options: DefaultFirebaseOptions.currentPlatform
  );
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //   systemNavigationBarColor: Colors.blue, // navigation bar color
  //   statusBarColor: Color.fromARGB(255, 22, 0, 7),)); // status bar color
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) 
  {
    return GetMaterialApp
    (
      debugShowCheckedModeBanner: false,
      home: firebaseAuth.currentUser == null 
      ?PostalCodenull()
      :userMainScreen(),
      theme: ThemeData(
        textTheme: TextTheme(
          headline1: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: 15, 
            fontWeight: FontWeight.w500
          ),
        ),
      ),
    );
  }
}