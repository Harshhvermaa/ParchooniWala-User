import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:parchooniwala_user/Screens/usermainscreen.dart';
import '../Global/global.dart';

class OtpScreen extends StatefulWidget {
  String phone;
  OtpScreen({Key? key, required this.phone}) : super(key: key);
  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String? completeAddress;
  String? appbarAddress;
  String? defaultDialogText;
  String? _verificationCode;
  final TextEditingController _otp = TextEditingController();

  // Position? position;
  // List<Placemark> placemark = [];

  // fetchLocation() async {
  //   LocationPermission permission;
  //   permission = await Geolocator.requestPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //   }

  //   Get.defaultDialog(
  //       title: "",
  //       content: Column(
  //         children: [
  //           CircularProgressIndicator(),
  //           SizedBox(
  //             height: 15,
  //           ),
  //           Text("Fetching Location...")
  //         ],
  //       ));

  //   Position newposition = await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.high
  //       );

  //   position = newposition;

  //   placemark = await placemarkFromCoordinates(
  //     position!.latitude,
  //     position!.longitude,
  //   );

  //   Placemark pMark = placemark[0];

  //   completeAddress =
  //       await '${pMark.subLocality} ${pMark.locality}, ${pMark.administrativeArea}  ${pMark.subAdministrativeArea}, ${pMark.postalCode}, ${pMark.country}';
  //   appbarAddress = await "${pMark.subLocality}, ${pMark.locality}";
  //   setState(() {});
  //   Navigator.pop(context);
  // }

  createSeller() async 
  {
    // await FirebaseFirestore.instance
    //     .collection("Users")
    //     .doc(firebaseAuth.currentUser!.uid)
    //     .get()
    //     .then((snapshot) async {
    //   if ( snapshot.data()!["MobileNumber"] == widget.phone ) {
    //     SaveDataLocally(firebaseAuth.currentUser);
    //     Get.to(userMainScreen());
    //   } else {
        print("Save Data To firestore");
        await FirebaseFirestore.instance
            .collection("Users")
            .doc(firebaseAuth.currentUser!.uid)
            .set({
          "MobileNumber": widget.phone,
          "sellerUid": firebaseAuth.currentUser!.uid,
          "completeAddress": sharedPreferences!.getString("CompleteAddress"),
          "appbarAddress": sharedPreferences!.getString("appbarAddress"),
          // "Date:Time" : DateFormat( "dd:mm:yyyy" ),
          "status": "approved",
          "lat": sharedPreferences!.getString("Latitude"),
          "lng": sharedPreferences!.getString("Longitude"),
        });
        await SaveDataLocally(firebaseAuth.currentUser);
        Get.to(userMainScreen());
      // }
    // });
  }

  SaveDataLocally(User? currentUser) async 
  {
    print("Save Data Locally");
    try
    {
      await FirebaseFirestore.instance
        .collection("Users")
        .doc(currentUser!.uid)
        .get()
        .then((snapshot) async {
      await sharedPreferences!
          .setString("sellerUid", snapshot.data()!["sellerUid"]);
      await sharedPreferences!
          .setString("MobileNumber", snapshot.data()!["MobileNumber"]);
      await sharedPreferences!
          .setString("completeAddress", snapshot.data()!["completeAddress"]);
      await sharedPreferences!
          .setString("appbarAddress", snapshot.data()!["appbarAddress"]);
      await sharedPreferences!.setString("lat", snapshot.data()!["lat"]);
      await sharedPreferences!.setString("lng", snapshot.data()!["lng"]);
    });
    }catch(e)
    {
        print(e.toString());
    }
  }

  SignInWithCredential() async 
  {
    await FirebaseAuth.instance
        .signInWithCredential(PhoneAuthProvider.credential(
            verificationId: _verificationCode!, smsCode: _otp.text))
        .then((value) async {
      if (value.user != null) {
        print("Success");
        Get.defaultDialog(
            title: "",
            content: Column(
              children: [
                CircularProgressIndicator(),
                SizedBox(
                  height: 15,
                ),
                Text("OTP verified Succesfully")
              ],
            ));
        Navigator.pop(context);
        Get.defaultDialog(
            title: "",
            content: Column(
              children: [
                CircularProgressIndicator(),
                SizedBox(
                  height: 15,
                ),
                Text("OTP verified sucessfully\ncreating account",textAlign: TextAlign.center,)
              ],
            ));
        await createSeller();
      }
    });
  }

  _verifyPhone() async 
  {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91${widget.phone}',
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
            if (value.user != null) {
              Get.defaultDialog(
                  title: "",
                  content: Column(
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(
                        height: 15,
                      ),
                      Text("OTP verified successfully\nCreating Account",textAlign: TextAlign.center,)
                    ],
                  ));
              await createSeller();
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
          Get.defaultDialog(
            title: "",
            content: Column(
              children: [
                Image(
                  image: AssetImage("assets/warning.png"),
                  height: 100,
                  width: 100,
                ),
                SizedBox(
                  height: 15,
                ),
                Text(e.message.toString())
              ],
            ),
          );
        },
        codeSent: (String? verficationID, int? resendToken) {
          setState(() {
            _verificationCode = verficationID;
          });
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          setState(() {
            _verificationCode = verificationID;
          });
        },
        timeout: Duration(seconds: 120));
  }

  @override
  void initState() 
  {
    super.initState();
     _verifyPhone();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            shadowColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false,
            title: InkWell(
              onTap: (() => Navigator.pop(context)),
              child: Icon(
                Icons.arrow_back,
                color: Color.fromARGB(255, 51, 51, 51),
              ),
            ),
          ),
          body: SizedBox(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: SizedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //Verify mobile number
                          Padding(
                            padding: const EdgeInsets.only(left: 18.0),
                            child: Text(
                              "Verify Mobile Number",
                              style: GoogleFonts.poppins(
                                  color: Color.fromARGB(255, 1, 1, 1),
                                  fontSize: 22,
                                  letterSpacing: -1.5,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          //Enter the otp
                          Padding(
                            padding: const EdgeInsets.only(left: 18.0),
                            child: Text(
                              "Enter the OTP sent to +91 " +
                                  "${widget.phone.toString()}",
                              style: GoogleFonts.poppins(
                                  color: Color.fromARGB(255, 169, 168, 168),
                                  fontSize: 15,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                  
                          const SizedBox(
                            height: 10,
                          ),
                  
                          Divider(),
                  
                          const SizedBox(
                            height: 10,
                          ),
                          // textField
                  
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 18.0),
                            child: TextField(
                              controller: _otp,
                              onSubmitted: (value) async {
                                try 
                                {
                                  SignInWithCredential();
                                } catch (e) 
                                {
                                  Get.defaultDialog(
                                    title: "",
                                    content: Column(
                                      children: [
                                        Image(
                                          image: AssetImage("assets/warning.png"),
                                          height: 100,
                                          width: 100,
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Text("OTP incorrect")
                                      ],
                                    ),
                                  );
                                }
                              },
                              cursorHeight: 20,
                              maxLength: 6,
                              style: TextStyle(fontSize: 20),
                              keyboardType: TextInputType.number,
                              cursorColor: Color(0xFFA25FFF),
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.only(bottom: -20),
                                hintText: "Enter OTP",
                                hintStyle: GoogleFonts.poppins(
                                    color: const Color.fromARGB(255, 169, 168, 168),
                                    fontSize: 20,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w400),
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 77, 77, 77),
                                      width: 1),
                                ),
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xFFA25FFF), width: 2),
                                ),
                              ),
                            ),
                          ),
                  
                          SizedBox(
                            height: 40,
                          ),
                  
                          SizedBox(
                            height: 40,
                          ),
                          // Didnt Receive Otp
                  
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Didn't receive OTP?",
                                style: GoogleFonts.poppins(
                                    color: Color.fromARGB(255, 59, 59, 59),
                                    fontSize: 15,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w400),
                              ),
                              TextButton(
                                onPressed: () {
                                  _verifyPhone();
                                },
                                child: Text(
                                  "Resend OTP",
                                  style: GoogleFonts.poppins(
                                      color: Color(0xFFA25FFF),
                                      fontSize: 15,
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.w400),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Button

                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10.0, vertical: 25),
                  child: Container(
                    width: double.infinity,
                    height: screenHeight * 0.059,
                    child: ElevatedButton(
                      onPressed: () async {
                        try {
                          // _verifyPhone();
                         SignInWithCredential();
                        } catch (e) {
                          Get.defaultDialog(
                            title: "",
                            content: Column(
                              children: [
                                Image(
                                  image: AssetImage("assets/warning.png"),
                                  height: 100,
                                  width: 100,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text("OTP incorrect")
                              ],
                            ),
                          );
                          // ScaffoldMessenger.of(context).showSnackBar(
                          //     SnackBar(content: Text("Otp incorrect")));
                        }
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Color(0xFFA25FFF)),
                          shape: MaterialStateProperty.all(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)))),
                      child: Text(
                        "Verify and continue",
                        style: GoogleFonts.poppins(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 15,
                            letterSpacing: 0,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }

  
}
