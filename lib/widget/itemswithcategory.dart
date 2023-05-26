import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart ';
import 'package:google_fonts/google_fonts.dart';
import 'package:parchooniwala_user/models/categorymodel.dart';
import 'package:parchooniwala_user/models/items.dart';
import 'package:parchooniwala_user/models/subcategory.dart';
import 'package:parchooniwala_user/widget/itemswidget.dart';
import 'package:parchooniwala_user/widget/itemswithcategorieswidget.dart';
import 'package:sms_autofill/sms_autofill.dart';

class itemswithcategory extends StatefulWidget {
  itemswithcategory({super.key});

  @override
  State<itemswithcategory> createState() => itemswithcategoryState();
}

class itemswithcategoryState extends State<itemswithcategory> {
  bool? addORnot = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(),
      child: Container(
        transform: Matrix4.translationValues(0.0, -10.0, 0.0),
        // width: double.infinity,
        // decoration: BoxDecoration(
        //   color: Color.fromARGB(255, 104, 59, 165).withOpacity(0.1),
        // ),
        child: Column(
          children: [
            // Padding(
            //   padding: const EdgeInsets.only(left: 12.0, right: 12.0,bottom: 5),
            // child: Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Text(
            //       "Trending",
            //       style: GoogleFonts.poppins(
            //           color: Color.fromARGB(255, 0, 0, 0),
            //           fontSize: 25,
            //           fontWeight: FontWeight.w600),
            //     ),
            // Row(
            //   children: [
            //     Text(
            //       "SeeAll",
            //       style: GoogleFonts.poppins(
            //           color: Color(0xFFA25FFF),
            //           fontSize: 22,
            //           fontWeight: FontWeight.w600),
            //     ),
            //     SizedBox(
            //       width: 5,
            //     ),
            //     Image(
            //       image: AssetImage("assets/rarrow.png"),
            //       height: 13,
            //       width: 13,
            //       color: Color(0xFFA25FFF),
            //     ),
            //   ],
            // )
            // ],
            // ),
            // ),
            // Divider( thickness:10 , ),

            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("subCategory")
                  .snapshots(),
              builder: (context,AsyncSnapshot snapshot1) {
                if (snapshot1.hasData)  {
                  return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot1.data!.docs.length,
                      itemBuilder: (context, index) {
                        subCategory ItemswithSubCategories = subCategory
                            .fromJson( snapshot1.data.docs[index].data() );

                        return StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection("subCategory")
                              .doc(ItemswithSubCategories.subcategory_name
                                  .toString())
                              .collection("Items")
                              .snapshots(),
                          builder: (context, AsyncSnapshot snapshot2) {
                            if ( snapshot2.hasData ) {
                               return snapshot2.data.docs.length > 3
                                ? Column(
                                    children: [
                                      Divider(
                                        thickness: 10,
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(bottom: 20),
                                        child: itemswithcategorieswidget(
                                          ItemswithSubCategories:
                                              ItemswithSubCategories,
                                        ),
                                      ),
                                    ],
                                  )
                                : SizedBox();
                            }
                            return CircularProgressIndicator();
                          },
                        );
                        // Column(
                        //   children: [
                        //     Divider( thickness:10 , ),
                        //     Container(
                        //       margin: EdgeInsets.only(bottom: 20),
                        //       child: itemswithcategorieswidget(
                        //           ItemswithSubCategories :  ItemswithSubCategories,
                        //         ),
                        //     ),
                        //   ],
                        // );
                      });
                } else {
                  return CircularProgressIndicator();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
