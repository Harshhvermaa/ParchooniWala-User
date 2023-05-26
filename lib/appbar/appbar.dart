import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parchooniwala_user/Global/global.dart';
import 'package:parchooniwala_user/Screens/manuallocationscreen.dart';
import 'package:parchooniwala_user/Screens/mobilenumberscreen.dart';

class Appbar extends StatefulWidget {
  String? Address;

  Appbar({Key? key, this.Address}) : super(key: key);

  @override
  State<Appbar> createState() => _AppbarState();
}

class _AppbarState extends State<Appbar> {
  @override
  Widget build(BuildContext context) {
    String address = widget.Address.toString();
    return Container(
      decoration: BoxDecoration(color: Color(0xFFA25FFF)),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                left: 15.0, right: 15, top: 50, bottom: 7 ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        // Navigator.push(context, MaterialPageRoute(builder: (c)=> manualLocation())) 
                        Get.to(() => manualLocation(cominglocation: sharedPreferences!.getString("appbarAddress"),));
                      },
                      child: Text(
                        address.substring(0,12) + "...",
                        style: GoogleFonts.poppins(
                            color: Color.fromARGB(255, 251, 251, 251),
                            fontSize: 25,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 3.0),
                      child: Image(
                        image: AssetImage("assets/darrow.png"),
                        color: Colors.white,
                        height: 10,
                        width: 10,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Image(
                      image: AssetImage("assets/user.png"),
                      color: Colors.white,
                      height: 20,
                      width: 20,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    InkWell(
                        onTap: () {
                          firebaseAuth.signOut();
                          Get.offAll(() => Mobilenumberscreen());
                        },
                        child: Icon(
                          Icons.exit_to_app,
                          color: Colors.white,
                        )),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 15.0, right: 15, top: 15, bottom: 20),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  SizedBox(width: 20),
                  Icon(
                    Icons.search,
                    color: Color.fromARGB(255, 186, 186, 186),
                  ),
                  SizedBox(width: 5),
                  Expanded(
                      child: TextField(
                    style: GoogleFonts.poppins(
                        color: Color.fromARGB(255, 49, 49, 49),
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                    cursorColor: Color.fromARGB(255, 49, 49, 49),
                    cursorWidth: 1,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Search",
                      hintStyle: GoogleFonts.poppins(
                          color: Color.fromARGB(255, 186, 186, 186),
                          fontSize: 20,
                          fontWeight: FontWeight.w400),
                    ),
                  ))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
