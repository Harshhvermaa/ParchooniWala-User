import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parchooniwala_user/Global/global.dart';
import 'package:parchooniwala_user/Screens/locationScreen.dart';
import 'package:parchooniwala_user/Screens/mobilenumberscreen.dart';
import 'package:parchooniwala_user/Screens/usermainscreen.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class manualLocation extends StatefulWidget {
  String? cominglocation;
  manualLocation({Key? key, this.cominglocation}) : super(key: key);

  @override
  State<manualLocation> createState() => mManuaLlocationState();
}

class mManuaLlocationState extends State<manualLocation> {
  bool onTap = false;
  TextEditingController locationSearchController = TextEditingController();

  var uuid = Uuid();

  String sessionToken = "123456";

  List<dynamic> _placesList = [];
  List<Location>? location;
  List<Placemark>? placemark;
  Placemark? pmark;
  Position? position;
  List<Placemark>? placemark2 = [];
  Placemark? pmark2;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    locationSearchController.addListener(() {
      onChanged();
    });
  }

  void onChanged() {
    if (sessionToken == null) {
      setState(() {
        sessionToken = uuid.v4();
      });
    }
    getSuggestion(locationSearchController.text);
  }

  void getSuggestion(String input) async {
    String googlePlaceApi = "AIzaSyBGG5PWUSu4ml9duz4LXOrncgMsqYH1y_M";
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request =
        '$baseURL?input=$input&key=$googlePlaceApi&sessiontoken=$sessionToken';

    var response = await http.get(Uri.parse(request));
    var data = response.body.toString();
    print("data");
    print(data);
    if (response.statusCode == 200) {
      setState(() {
        _placesList = jsonDecode(response.body.toString())['predictions'];
      });
    } else {
      throw Exception("Failed to load data");
    }
  }

  saveLocationtoSharedPreference() async {
    await sharedPreferences!
        .setString("Latitude", location!.last.latitude.toString());

    await sharedPreferences!
        .setString("Longitude", location!.last.longitude.toString());

    await sharedPreferences!
        .setString("PostalCode", pmark!.postalCode.toString());

    await sharedPreferences!.setString("CompleteAddress",
        '${pmark!.subLocality} ${pmark!.locality}, ${pmark!.administrativeArea}  ${pmark!.subAdministrativeArea}, ${pmark!.postalCode}, ${pmark!.country}');

    await sharedPreferences!.setString(
      "appbarAddress",
      '${pmark!.subLocality} ${pmark!.locality}',
    );

    print(sharedPreferences!.getString("Latitude"));
    print(sharedPreferences!.getString("Longitude"));
    print(sharedPreferences!.getString("PostalCode"));
    print(sharedPreferences!.getString("appbarAddress"));
    print(sharedPreferences!.getString("CompleteAddress"));
  }

  saveLocationtoSharedPreference2() async {
    await sharedPreferences!
        .setString("Latitude", position!.latitude.toString());

    await sharedPreferences!
        .setString("Longitude", position!.longitude.toString());

    await sharedPreferences!
        .setString("PostalCode", pmark2!.postalCode.toString());

    await sharedPreferences!.setString("CompleteAddress",
        '${pmark2!.subLocality} ${pmark2!.locality}, ${pmark2!.administrativeArea}  ${pmark2!.subAdministrativeArea}, ${pmark2!.postalCode}, ${pmark2!.country}');

    await sharedPreferences!.setString(
      "appbarAddress",
      '${pmark2!.subLocality} ${pmark2!.locality}',
    );

    print(sharedPreferences!.getString("Latitude"));
    print(sharedPreferences!.getString("Longitude"));
    print(sharedPreferences!.getString("PostalCode"));
    print(sharedPreferences!.getString("appbarAddress"));
    print(sharedPreferences!.getString("CompleteAddress"));

    // Get.to(Mobilenumberscreen());
  }

  fetchLocation() async {
    LocationPermission permission;
    permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    Position newposition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    position = newposition;

    placemark2 =
        await placemarkFromCoordinates(position!.latitude, position!.longitude);

    pmark2 = placemark![0];
    saveLocationtoSharedPreference2();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: widget.cominglocation == null
            ? Column(
                children: [
                  SizedBox(height: 20),
                  // Your Location
                  Text(
                    "Your Location",
                    style: GoogleFonts.poppins(
                        color: Color.fromARGB(255, 82, 82, 82),
                        fontSize: 30,
                        fontWeight: FontWeight.w600),
                  ),

                  Divider(),

                  SizedBox(height: 20),
                  // search
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 18.0,
                      right: 18,
                    ),
                    child: Container(
                      // height: 20,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 245, 239, 255),
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(
                            color: Color.fromARGB(255, 239, 231, 252),
                            width: 1.0,
                            style: BorderStyle.solid),
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 12,
                          ),
                          Icon(
                            Icons.search,
                            color: Color.fromARGB(255, 186, 186, 186),
                            size: 25,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  onTap == true;
                                });
                              },
                              child: TextFormField(
                                cursorColor: Color.fromARGB(255, 186, 186, 186),
                                controller: locationSearchController,
                                // onEditingComplete: () => Get.to(OtpScreen(phone: _phoneNumberController.text)),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Search a new address",
                                  hintStyle: GoogleFonts.poppins(
                                      color: Color.fromARGB(255, 186, 186, 186),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w300),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 20,
                  ),
                  // Current Location
                  locationSearchController.text.length == 0
                      ? Padding(
                          padding: const EdgeInsets.only(
                            left: 18.0,
                            right: 18,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4.5),
                                    child: Icon(
                                      Icons.location_searching,
                                      color: Color(0xFFA25FFF),
                                      size: 17,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15.0,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Current location",
                                        style: GoogleFonts.poppins(
                                            color: Color(0xFFA25FFF),
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Text(
                                        "Enable your current location\nfor better services",
                                        style: GoogleFonts.poppins(
                                            color: Color.fromARGB(
                                                255, 186, 186, 186),
                                            fontSize: 15,
                                            fontWeight: FontWeight.w300),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              InkWell(
                                onTap: ()
                                  {
                                    fetchLocation();
                                  widget.cominglocation == null
                                      ? Get.to(LocationScreen())
                                      : Get.to(userMainScreen());
                                  },
                                child: Container(
                                  // height: 20,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.0),
                                    border: Border.all(
                                        color:
                                            Color.fromARGB(255, 239, 231, 252),
                                        width: 1.0,
                                        style: BorderStyle.solid),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 5),
                                    child: Text(
                                      "Enable",
                                      style: GoogleFonts.poppins(
                                          color: Color(0xFFA25FFF),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : Expanded(
                          child: ListView.builder(
                              itemCount: _placesList.length,
                              itemBuilder: (context, index) {
                                String place =
                                    _placesList[index]["description"];
                                return InkWell(
                                  onTap: () async {
                                    location = await locationFromAddress(
                                        _placesList[index]["description"]);
                                    placemark = [];

                                    placemark = await placemarkFromCoordinates(
                                        location!.last.latitude,
                                        location!.last.longitude);
                                    pmark = placemark![0];
                                    await saveLocationtoSharedPreference();
                                    widget.cominglocation == null
                                        ? Get.to(LocationScreen())
                                        : Get.to(userMainScreen());
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      left: 18.0,
                                      right: 18,
                                      bottom: 12,
                                    ),
                                    child: Container(
                                      height: screenHeight * 0.1,
                                      width: screenWidth,
                                      decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 245, 239, 255),
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        border: Border.all(
                                            color: Color.fromARGB(
                                                255, 239, 231, 252),
                                            width: 1.0,
                                            style: BorderStyle.solid),
                                      ),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Icon(
                                            Icons.location_on,
                                            color: Color(0xFFA25FFF)
                                                .withOpacity(0.8),
                                            size: 40,
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Text(
                                            place.length > 23
                                                ? place.substring(0, 20) +
                                                    "...."
                                                : place,
                                            style: GoogleFonts.poppins(
                                                color:
                                                    Color.fromARGB(255, 0, 0, 0)
                                                        .withOpacity(0.7),
                                                fontSize: 20,
                                                fontWeight: FontWeight.w700),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        )
                ],
              )
            : Column(
                children: [
                  SizedBox(height: 20),
                  // Your Location
                  Text(
                    "Your Location",
                    style: GoogleFonts.poppins(
                        color: Color.fromARGB(255, 82, 82, 82),
                        fontSize: 30,
                        fontWeight: FontWeight.w600),
                  ),

                  Divider(),

                  SizedBox(height: 15),

                  Text(
                    "Your Current Location : \n" + "${widget.cominglocation}",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        color: Color.fromARGB(255, 82, 82, 82),
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),

                  SizedBox(height: 20),
                  // search
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 18.0,
                      right: 18,
                    ),
                    child: Container(
                      // height: 20,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 245, 239, 255),
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(
                            color: Color.fromARGB(255, 239, 231, 252),
                            width: 1.0,
                            style: BorderStyle.solid),
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 12,
                          ),
                          Icon(
                            Icons.search,
                            color: Color.fromARGB(255, 186, 186, 186),
                            size: 25,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  onTap == true;
                                });
                              },
                              child: TextFormField(
                                cursorColor: Color.fromARGB(255, 186, 186, 186),
                                controller: locationSearchController,
                                // onEditingComplete: () => Get.to(OtpScreen(phone: _phoneNumberController.text)),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Search a new address",
                                  hintStyle: GoogleFonts.poppins(
                                      color: Color.fromARGB(255, 186, 186, 186),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w300),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 20,
                  ),
                  // Current Location
                  locationSearchController.text.length == 0
                      ? Padding(
                          padding: const EdgeInsets.only(
                            left: 18.0,
                            right: 18,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4.5),
                                    child: Icon(
                                      Icons.location_searching,
                                      color: Color(0xFFA25FFF),
                                      size: 17,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15.0,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Current location",
                                        style: GoogleFonts.poppins(
                                            color: Color(0xFFA25FFF),
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Text(
                                        "Enable your current location\nfor better services",
                                        style: GoogleFonts.poppins(
                                            color: Color.fromARGB(
                                                255, 186, 186, 186),
                                            fontSize: 15,
                                            fontWeight: FontWeight.w300),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Container(
                                // height: 20,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0),
                                  border: Border.all(
                                      color: Color.fromARGB(255, 239, 231, 252),
                                      width: 1.0,
                                      style: BorderStyle.solid),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 5),
                                  child: Text(
                                    "Enable",
                                    style: GoogleFonts.poppins(
                                        color: Color(0xFFA25FFF),
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : Expanded(
                          child: ListView.builder(
                              itemCount: _placesList.length,
                              itemBuilder: (context, index) {
                                String place =
                                    _placesList[index]["description"];
                                return InkWell(
                                  onTap: () async {
                                    location = await locationFromAddress(
                                        _placesList[index]["description"]);
                                    placemark = [];

                                    placemark = await placemarkFromCoordinates(
                                        location!.last.latitude,
                                        location!.last.longitude);
                                    pmark = placemark![0];

                                    await saveLocationtoSharedPreference();
                                    widget.cominglocation == null
                                        ? Get.to(LocationScreen())
                                        : Get.to(userMainScreen());
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      left: 18.0,
                                      right: 18,
                                      bottom: 12,
                                    ),
                                    child: Container(
                                      height: screenHeight * 0.1,
                                      width: screenWidth,
                                      decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 245, 239, 255),
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        border: Border.all(
                                            color: Color.fromARGB(
                                                255, 239, 231, 252),
                                            width: 1.0,
                                            style: BorderStyle.solid),
                                      ),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Icon(
                                            Icons.location_on,
                                            color: Color(0xFFA25FFF)
                                                .withOpacity(0.8),
                                            size: 40,
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Text(
                                            place.length > 23
                                                ? place.substring(0, 20) +
                                                    "...."
                                                : place,
                                            style: GoogleFonts.poppins(
                                                color:
                                                    Color.fromARGB(255, 0, 0, 0)
                                                        .withOpacity(0.7),
                                                fontSize: 20,
                                                fontWeight: FontWeight.w700),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        )
                ],
              ),
      ),
    );
  }
}
