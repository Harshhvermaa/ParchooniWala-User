import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parchooniwala_user/appbar/appbar.dart';
import 'package:parchooniwala_user/widget/slider.dart';

import '../Global/global.dart';
import '../widget/itemswithcategory.dart';
import '../widget/trending.dart';
import '../widget/newarrivals.dart';
import '../widget/shopbycategory.dart';
import '../widget/slider2.dart';

class userMainScreen extends StatefulWidget {
  const userMainScreen({Key? key}) : super(key: key);

  @override
  State<userMainScreen> createState() => _userMainScreenState();
}

class _userMainScreenState extends State<userMainScreen> {
  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setNavigationBarColor(Color(0xFFA25FFF));
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Column(
            children: [
              Appbar(
                Address: sharedPreferences!.getString("appbarAddress"),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      customSlider(),
                      shopbycategory(),
                      newarrival(),
                      customSlider2(),
                      trending(),
                      itemswithcategory()
                    ],
                  ),
                ),
              ),
            ],
          ),
          
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("Users")
                  .doc(firebaseAuth.currentUser!.uid)
                  .collection("Cart")
                  .snapshots(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.docs.length > 0) {
                    int? separateAmount;
                    int? TotalAmount = 0;
                    for (int i = 0; i < snapshot.data!.docs.length; i++) {
                      int itemQuantity =
                          snapshot.data!.docs[i].data()!["Item_quantity"];

                      int prize = int.parse(snapshot.data!.docs[i]
                          .data()!["Item_userPrice"]
                          .toString());

                      separateAmount = itemQuantity * prize;

                      TotalAmount = TotalAmount! + separateAmount;
                    }
                    String? itemsInCart = snapshot.data!.docs.length.toString();
                    return Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color(0xFFA25FFF),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        margin: EdgeInsetsDirectional.only(bottom: 15),
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 6.0, left: 10, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    "${itemsInCart + " items" "\n" + "$TotalAmount"}",
                                    textAlign: TextAlign.start,
                                    style: GoogleFonts.poppins(
                                        color:
                                            Color.fromARGB(255, 251, 251, 251),
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 6.5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "View Cart",
                                      style: GoogleFonts.poppins(
                                          color: Color.fromARGB(
                                              255, 251, 251, 251),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Icon(
                                      Icons.navigate_next,
                                      color: Colors.white,
                                    )
                                  ],
                                ),
                              ),
                              //   } else {
                              //     return CircularProgressIndicator();
                              //   }
                              // })
                            ],
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Container();
                  }
                } else {
                  return CircularProgressIndicator();
                }
              })
        ],
      ),
    );
  }
}
