import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sms_autofill/sms_autofill.dart';

import 'OtpScreen.dart';

class Mobilenumberscreen extends StatefulWidget {
  const Mobilenumberscreen({Key? key}) : super(key: key);

  @override
  State<Mobilenumberscreen> createState() => _MobilnnumbesScreenState();
}

class _MobilnnumbesScreenState extends State<Mobilenumberscreen> {
      final formKey = GlobalKey();
  final TextEditingController _phoneNumberController = TextEditingController();

  submit(context)async
  {
    if (_phoneNumberController.text.length < 10) {
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
            Text("Please enter valid\nmobile number",textAlign: TextAlign.center,)
          ],
        ),
      );
    } else {
      Get.to(OtpScreen(phone: _phoneNumberController.text,));
    }
  }
  
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      // resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  height: screenHeight,
                  width: screenWidth * 1.0,
                  child: Image(
                    image: AssetImage("assets/bg.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 0.0,
                  child: Container(
                    height: screenHeight * 0.3,
                    width: screenWidth * 1.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(18),
                            topRight: Radius.circular(18)),
                        color: Color(0xFFFFFFFF)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: Text(
                            "Get Started with us",
                            style: Theme.of(context).textTheme.headline1,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: Text(
                            "Enter your mobile number",
                            style: GoogleFonts.poppins(
                                color: Color.fromARGB(255, 186, 186, 186),
                                fontSize: 13,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 12.0, right: 12.0),
                          child: Container(
                            // height: 20,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              border: Border.all(
                                  color: Color.fromARGB(255, 186, 186, 186),
                                  width: 1.0,
                                  style: BorderStyle.solid),
                            ),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 12,
                                ),
                                Icon(
                                  Icons.call,
                                  color: Color.fromARGB(255, 186, 186, 186),
                                  size: 25,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "+91",
                                  style: GoogleFonts.poppins(
                                      color: Color.fromARGB(255, 1, 1, 1),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: TextFormField(
                                    controller: _phoneNumberController,
                                    onEditingComplete: () => submit(context),
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 5),
                          child: InkWell(
                            onTap: ()=> submit(context),
                            child: Container(
                              height: screenHeight * 0.06,
                              width: screenWidth,
                              decoration: BoxDecoration(
                                color: Color(0xFFA25FFF),
                                borderRadius: BorderRadius.circular(12.0),
                                border: Border.all(
                                    color: Color.fromARGB(255, 239, 231, 252),
                                    width: 1.0,
                                    style: BorderStyle.solid),
                              ),
                              child: Center(child: Text("Continue",
                               style: GoogleFonts.poppins(
                                            color: Color.fromARGB(255, 255, 255, 255),
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700),)),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  }
