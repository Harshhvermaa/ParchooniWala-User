import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parchooniwala_user/models/categorymodel.dart';
import 'package:parchooniwala_user/widget/shopbycategorywidget.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import 'shopbycategorywidget2.dart';

class shopbycategory extends StatefulWidget {
  const shopbycategory({super.key});

  @override
  State<shopbycategory> createState() => _shopbycategoryState();
}

class _shopbycategoryState extends State<shopbycategory> {

// fetchsellerCategory() async
// {
//  var data = FirebaseFirestore
//  .instance
//  .collection(collectionPath)
// }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 45,
        ),
        Container(
          height: 35,
          decoration: BoxDecoration(
              // color: Color(0xFFA25FFF),
              ),
          child: Padding(
            padding: const EdgeInsets.only(left: 12.0, right: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Explore By Category",
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
        ),
        // SizedBox(height: 10,),
        
        StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection("Categories").snapshots(),
            builder: (Context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Container(
                  // transform: Matrix4.translationValues(0.0, -15.0, 0.0),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 8,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4, childAspectRatio: 1.0),
                    itemBuilder: (context, index) {
                      CategoriesModel categoriesModel =
                          CategoriesModel.fromJson(
                              snapshot.data!.docs[index]!.data());
                      // print(categoriesModel.toString());
                      if (index == 7) {
                        return shopbycategorywidget2(
                          categoriesModel: categoriesModel,
                        );
                      }
                      return shopbycategorywidget(
                        categoriesModel: categoriesModel,
                      );
                    },
                  ),
                );
              } else {
                return CircularProgressIndicator();
              }
            },
            ),
        
        SizedBox(height: 40,),
      ],
    );
  }
}
