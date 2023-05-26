import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parchooniwala_user/models/categorymodel.dart';

class shopbycategorywidget extends StatelessWidget {
  CategoriesModel? categoriesModel;
  shopbycategorywidget({super.key, this.categoriesModel});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            margin: EdgeInsets.all(0),
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Color(0xFFA25FFF).withOpacity(0.56),
                      spreadRadius: -6,
                      blurRadius: 4,
                      offset: Offset(-5, 5))
                ],
                borderRadius: BorderRadius.circular(12),
                color: Color.fromARGB(255, 255, 255, 255)),
            child: ClipRRect(
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 17),
                child: Image(
                  image: CachedNetworkImageProvider(
                    categoriesModel!.category_image.toString(),
                  ),
                ),
              ),
            ),
          ),
        ),
        
        Positioned(
            top: 0,
            right: 3,
            child: Stack(
              children: [
                Image(
                  image: AssetImage("assets/discount.png"),
                  height: 20,
                  width: 20,
                ),
                Positioned(
                  top: 4.5,
                  right: 4,
                  child: Text(
                    categoriesModel!.category_offer.toString() + "%",
                    style: GoogleFonts.poppins(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 8,
                        letterSpacing: -1,
                        fontWeight: FontWeight.w600),
                  ),
                )
              ],
            ))
      
      ],
    );
  }
}
