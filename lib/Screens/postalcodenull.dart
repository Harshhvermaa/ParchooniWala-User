
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parchooniwala_user/Screens/mobilenumberscreen.dart';

import '../Global/global.dart';
import 'manuallocationscreen.dart';

class PostalCodenull extends StatelessWidget {
   PostalCodenull({Key? key}) : super(key: key);

  Position? position;
  List<Placemark>? placemark = [];
  Placemark? pmark;


  saveLocationtoSharedPreference() async {
    await sharedPreferences!
        .setString("Latitude", position!.latitude.toString());

    await sharedPreferences!
        .setString("Longitude", position!.longitude.toString());

    await sharedPreferences!
        .setString("PostalCode", pmark!.postalCode.toString());

    await sharedPreferences!.setString("CompleteAddress",
        '${pmark!.subLocality} ${pmark!.locality}, ${pmark!.administrativeArea}  ${pmark!.subAdministrativeArea}, ${pmark!.postalCode}, ${pmark!.country}');

    await sharedPreferences!
        .setString("appbarAddress", '${pmark!.subLocality} ${pmark!.locality}',);        

    print(sharedPreferences!.getString("Latitude"));
    print(sharedPreferences!.getString("Longitude"));
    print(sharedPreferences!.getString("PostalCode"));
    print(sharedPreferences!.getString("appbarAddress"));
    print(sharedPreferences!.getString("CompleteAddress"));

    Get.to(Mobilenumberscreen());
  }

  fetchLocation() async
  {

    LocationPermission permission;
    permission = await Geolocator.requestPermission();

    if(permission == LocationPermission.denied)
    {
      permission = await Geolocator.requestPermission();
    }
    
    Position newposition = await Geolocator.getCurrentPosition
    (
      desiredAccuracy: LocationAccuracy.high 
    );

    position = newposition;

    placemark = await placemarkFromCoordinates
    (
      position!.latitude,
      position!.longitude
    );

    pmark = placemark![0];
    saveLocationtoSharedPreference();
  }

  @override
  Widget build(BuildContext context) {
        var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body:  Stack(
        children: [
          SizedBox(
            height: screenHeight,
            width: screenWidth * 1.0,
            child: Image(
              image: AssetImage("assets/bg2.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: 0.0,
            child: Container(
              height: screenHeight * 0.44,
              width: screenWidth * 1.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(18),
                      topRight: Radius.circular(18)),
                  color: Color(0xFFFFFFFF)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      print(sharedPreferences!.getString("PostalCode"));
                    },
                    child: Image(
                      image: AssetImage("assets/map.png"),
                      height: screenHeight*0.1,
                      width: 150,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: Text(
                      "Location Permission is Off",
                      style: GoogleFonts.poppins(
                          color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.7),
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: Text(
                      "To deliver as quickly as possible, we would like your\ncurrent location.",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.4),
                          fontSize: 13,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 5),
                    child: InkWell(
                      onTap: () {
                        fetchLocation();
                      },
                      child: Container(
                        width: double.infinity,
                        height: screenHeight * 0.058,
                        decoration: BoxDecoration(
                          color: Color(0xFFA25FFF),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            "Grant",
                            style: GoogleFonts.poppins(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontSize: 18,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Divider(color: Color.fromARGB(255, 186, 186, 186)),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12.0, vertical: 5),
                      child: InkWell(
                        onTap: () => Get.to(manualLocation()),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  size: 25,
                                  color: Color.fromARGB(255, 1, 1, 1),
                                ),
                                Text(
                                  "Enter location manually",
                                  style: GoogleFonts.poppins(
                                      color: Color.fromARGB(255, 1, 1, 1),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(Icons.navigate_next),
                          ],
                        ),
                      ),
                    ),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}