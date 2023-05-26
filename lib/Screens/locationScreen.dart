import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parchooniwala_user/Screens/mobilenumberscreen.dart';
import 'package:parchooniwala_user/Screens/postalcodenull.dart';

import '../Global/global.dart';
import 'manuallocationscreen.dart';

class LocationScreen extends StatelessWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: sharedPreferences!.getString("Latitude") == null 
      ? PostalCodenull()
      : Mobilenumberscreen()
      );
  }
}
