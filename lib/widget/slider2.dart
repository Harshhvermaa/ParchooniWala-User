import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class customSlider2 extends StatefulWidget {
   customSlider2({Key? key}) : super(key: key);

  @override
  State<customSlider2> createState() => _customSlider2State();
}

class _customSlider2State extends State<customSlider2> {
  Stream? stream;
  List<dynamic>? slidesList;
  Stream? dbquery() 
  {
    stream = FirebaseFirestore
    .instance
    .collection("Slider2")
    .snapshots()
    .map((snapshot) => snapshot.docs.map((doc) => doc.data() ));
  }

@override
  void initState() {
    // TODO: implement initState
     dbquery();
    super.initState();
  }

  

 @override
  Widget build(BuildContext context) {
    return  StreamBuilder(
      stream: stream,
      builder: (context ,AsyncSnapshot snapshot) 
      {
        if ( snapshot.hasData ) 
        {
          slidesList =  snapshot.data!.toList();
          return Container(
            margin: EdgeInsets.only(bottom: 35,top: 4),
            // transform: Matrix4.translationValues(0.0, -12.0, 0.0),
            child: CarouselSlider(
                      options: CarouselOptions(
                      // height: MediaQuery.of(context).size.height * .3,
                      height: MediaQuery.of(context).size.height * 0.15,
                        // width: MediaQuery.of(context).size.width,
                      // aspectRatio: 16 / 8,
                      viewportFraction: 0.98,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: false,
                      autoPlayInterval: const Duration(seconds: 5),
                      autoPlayAnimationDuration:
                        const Duration(milliseconds: 500),
                      autoPlayCurve: Curves.decelerate,
                      // enlargeCenterPage: true,
                      scrollDirection: Axis.horizontal,
                      ),
                      
                      items: slidesList!.map((index) {
                      var url =  index["SliderImageUrl"];
                      // print("dsfdsfsd");
                      // print("$url");

                      return Builder(builder: (BuildContext context) {
                      return Container(
                        // transform: Matrix4.translationValues(0.0, -50.0, 0.0),
                        width: double.infinity,
                        margin: const EdgeInsets.only( right: 4.0,left: 4 ,),
                        decoration: BoxDecoration
                        (
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(image: CachedNetworkImageProvider(url),fit: BoxFit.cover)
                        ),
                        // child: CachedNetworkImage(imageUrl: url,fit: BoxFit.cover,),
                      );
                      });
                      }).toList(),
                  ),
          );
        }
        else
        {
          return CircularProgressIndicator();
        }
      }
      );
  }
}