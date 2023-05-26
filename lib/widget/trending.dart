import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart ';
import 'package:google_fonts/google_fonts.dart';
import 'package:parchooniwala_user/models/items.dart';
import 'package:parchooniwala_user/widget/itemswidget.dart';
import 'package:sms_autofill/sms_autofill.dart';

class trending extends StatefulWidget {
   trending({super.key});

  @override
  State<trending> createState() => trendingState();
}

class trendingState extends State<trending> {
  bool? addORnot = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 0.0),
      child: Container(
        height: 250,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 104, 59, 165).withOpacity(0.1),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 15,bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Trending",
                    style: GoogleFonts.poppins(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: 25,
                        fontWeight: FontWeight.w600),
                  ),
                  Row(
                    children: [
                      Text(
                        "SeeAll",
                        style: GoogleFonts.poppins(
                            color: Color(0xFFA25FFF),
                            fontSize: 22,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Image(
                        image: AssetImage("assets/rarrow.png"),
                        height: 13,
                        width: 13,
                        color: Color(0xFFA25FFF),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("Items")
                    .where("Trending",isEqualTo: "true")
                    .orderBy("Date", descending: true)
                    .snapshots(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return ListView(
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 40, left: 10),
                          child: Text(
                            "Whenever,\nwherever,\nwhatsoever.",
                            style: GoogleFonts.poppins(
                                color: Color.fromARGB(255, 0, 0, 0)
                                    .withOpacity(0.3),
                                fontSize: 36,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          height: 180,
                          child: Padding(
                            padding: const EdgeInsets.only(right : 10.0),
                            child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: snapshot.data!.docs.length > 10
                                    ? 10
                                    : snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  ItemsModel itemsModel = ItemsModel.fromJson(
                                      snapshot.data!.docs[index].data());
                                  return Itemswidget(
                                    itemsModel: itemsModel,
                                  );
                                }),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
