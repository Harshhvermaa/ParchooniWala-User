import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class customSlider extends StatefulWidget {
  const customSlider({Key? key}) : super(key: key);

  @override
  State<customSlider> createState() => _customSliderState();
}

class _customSliderState extends State<customSlider> {
  Stream? stream;
  List<dynamic>? slidesList;
  Stream? dbquery() 
  {
    stream = FirebaseFirestore
    .instance
    .collection("Slider")
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
            transform: Matrix4.translationValues(0.0, 10.0, 0.0),
            child: CarouselSlider(
                      options: CarouselOptions(
                      // height: MediaQuery.of(context).size.height * .3,
                      height: MediaQuery.of(context).size.height * 0.2,
                        // width: MediaQuery.of(context).size.width,
                      // aspectRatio: 16 / 8,
                      viewportFraction: 0.9,
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
                      // print("$url");
                      // var data = slidesList[index];
                      // print(slidesList[index]);
                      // print(slidesList[index] + "dsf");
                      return Builder(builder: (BuildContext context) {
                      return Container(
                        // transform: Matrix4.translationValues(0.0, -50.0, 0.0),
                        width: double.infinity,
                        margin: const EdgeInsets.only( right: 8.0 ,),
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