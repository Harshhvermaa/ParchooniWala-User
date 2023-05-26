import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:parchooniwala_user/models/categorymodel.dart';

class shopbycategorywidget2 extends StatelessWidget {
  CategoriesModel? categoriesModel;
  shopbycategorywidget2({super.key, this.categoriesModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        margin: EdgeInsets.all(0),
        decoration: BoxDecoration
        (
          boxShadow: [
           BoxShadow
           (
            color: Color(0xFFA25FFF),
            spreadRadius: -6,
            blurRadius: 4,
            offset: Offset(-2, 5)
           )
          ],
          borderRadius: BorderRadius.circular(12),
          color: Color.fromARGB(255, 255, 255, 255)
        ),
        child: ClipRRect(
          child: Image(
            image: AssetImage("assets/indx7.jpg")
          ),
        ),
      ),
    );
    // SizedBox(
    //     child: Container(
    //   decoration: BoxDecoration(
    //       image: DecorationImage(
    //           image: CachedNetworkImageProvider(
    //             // maxHeight: 622,
    //             // maxWidth: 622,
    //             categoriesModel!.category_image.toString(),
    //           ),
    //           fit: BoxFit.cover)),
    //   // child: CachedNetworkImage(imageUrl: url,fit: BoxFit.cover,),
    // ));
  }
}
