import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parchooniwala_user/models/categorymodel.dart';

import '../models/items.dart';
import '../models/subcategory.dart';
import 'itemswidget.dart';

class itemswithcategorieswidget extends StatelessWidget {
  subCategory? ItemswithSubCategories;

  itemswithcategorieswidget({super.key, this.ItemswithSubCategories});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("subCategory")
          .doc(ItemswithSubCategories!.subcategory_name.toString())
          .collection("Items")
          .snapshots(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return snapshot.data!.docs.length > 3
              ? Container(
                  padding: EdgeInsets.only(left: 5, top: 10, bottom: 5),
                  height: 252,
                  margin: EdgeInsets.only(left: 5, right: 5, top: 15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(
                          width: 0.5,
                          style: BorderStyle.solid,
                          color: Colors.grey)),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              ClipRRect(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(right: 2, left: 7),
                                  child: Image(
                                    image: CachedNetworkImageProvider(
                                      ItemswithSubCategories!.subcategory_image
                                          .toString(),
                                    ),
                                    height: 35,
                                    width: 35,
                                  ),
                                ),
                              ),
                              Text(
                                ItemswithSubCategories!.subcategory_name
                                            .toString()
                                            .length >
                                        15
                                    ? ItemswithSubCategories!.subcategory_name
                                        .toString()
                                        .substring(0, 14)
                                    : ItemswithSubCategories!.subcategory_name
                                        .toString(),
                                style: GoogleFonts.poppins(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 20,
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
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: Expanded(
                          child: StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection("subCategory")
                                .doc(ItemswithSubCategories!.subcategory_name
                                    .toString())
                                .collection("Items")
                                .snapshots(),
                            builder: (context, AsyncSnapshot snapshot) {
                              if (snapshot.hasData) {
                                // print("fghfg");
                                // print(snapshot.data!.docs.length);
                                return SizedBox(
                                  height: 200,
                                  child: ListView.builder(
                                      physics: const BouncingScrollPhysics(),
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: snapshot.data!.docs.length,
                                      itemBuilder: (context, index) {
                                        ItemsModel itemsModel =
                                            ItemsModel.fromJson(snapshot
                                                .data!.docs[index]
                                                .data());
                                        // print(snapshot.data!.docs[index].data());
                                        return snapshot.data!.docs.length > 3
                                            ? Itemswidget(
                                                itemsModel: itemsModel,
                                              )
                                            : Container();
                                      }),
                                );
                              } else {
                                return CircularProgressIndicator();
                              }
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                )
              : SizedBox();
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
