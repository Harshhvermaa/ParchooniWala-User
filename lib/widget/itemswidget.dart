import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parchooniwala_user/Global/global.dart';
import 'package:parchooniwala_user/models/categorymodel.dart';
import 'package:parchooniwala_user/models/items.dart';

class Itemswidget extends StatefulWidget {
  ItemsModel? itemsModel;
  Itemswidget({super.key, this.itemsModel});

  @override
  State<Itemswidget> createState() => _ItemswidgetState();
}

class _ItemswidgetState extends State<Itemswidget> {
  bool AddedorNOt = false;

  addDataToFirestore() async {
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("Cart")
        .doc(widget.itemsModel!.Item_Name.toString())
        .set({
      "AddedOrNot": true,
      "Available": true,
      "Item_Name": widget.itemsModel!.Item_Name,
      "Item_picurl": widget.itemsModel!.Item_picurl,
      "Item_Weight": widget.itemsModel!.Item_Weight,
      "Item_wunit": widget.itemsModel!.Item_wunit,
      "Date": DateTime.now(),
      "Item_userPrice": widget.itemsModel!.Item_userPrice,
      "Item_adminPrice": widget.itemsModel!.Item_adminPrice,
      "Item_cutPrice": widget.itemsModel!.Item_cutPrice,
      "Item_offer": widget.itemsModel!.Item_offer,
      "Item_quantity": widget.itemsModel!.Item_quantity,
      "Description": widget.itemsModel!.Description
    });

    // .then((value) async => await updateBooleanToTrue())

    // TotalItemInCart = TotalItemInCart! + 1;
  }

  updateBooleanToTrue() async {
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("Cart")
        .doc(widget.itemsModel!.Item_Name.toString())
        .update({"AddedOrNot": true});
  }

  updateBooleanToFalse() async {
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("Cart")
        .doc(widget.itemsModel!.Item_Name.toString())
        .update({"AddedOrNot": false});
  }

  updateAddedorNottoTrue() async {
    var itemdata = await FirebaseFirestore.instance
        .collection("Users")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("Cart")
        .doc(widget.itemsModel!.Item_Name)
        .get();
    setState(() {
      AddedorNOt = itemdata.data()!["AddedOrNot"];
    });
  }

  AddQuantity() async {
    // await FirebaseFirestore.instance
    //     .collection("Users")
    //     .doc(firebaseAuth.currentUser!.uid)
    //     .collection("Cart")
    //     .doc(widget.itemsModel!.Item_Name)
    //     .update({"AddedOrNot": true});
    // setState(() {});
    var data = await FirebaseFirestore.instance
        .collection("Users")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("Cart")
        .doc(widget.itemsModel!.Item_Name)
        .get();
    int valu = data.data()!["Item_quantity"];
    // int.parse( data.data()!["Item_quantity"] );
    int value = valu;
    int addedValue = value + 1;
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("Cart")
        .doc(widget.itemsModel!.Item_Name)
        .update({
      "AddedOrNot": true,
      "Item_quantity": addedValue,
    });
    // await TotalQuantityOfEachProduct(widget.itemsModel!.Item_Name.toString());
  }

   CheckAddedOrNot() async {
    var itemData = await FirebaseFirestore.instance
        .collection("Users")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("Cart")
        .doc(widget.itemsModel!.Item_Name)
        .get()
        .then((snapshot) {
      if (snapshot.exists) {
        setState(() {
          AddedorNOt = snapshot.data()!["AddedOrNot"];
        });
      }
    });
  }

  DeleteItem() async {
    FirebaseFirestore.instance
        .collection("Users")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("Cart")
        .doc(widget.itemsModel!.Item_Name)
        .delete();
  }

  SubtractQuantity() async {
    var data = await FirebaseFirestore.instance
        .collection("Users")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("Cart")
        .doc(widget.itemsModel!.Item_Name)
        .get();
    int valu = data.data()!["Item_quantity"];
    int value = valu;
    int subValue = value - 1;
    // await data.data()!.update("Item_quantity", (subValue) => null );

    await FirebaseFirestore.instance
        .collection("Users")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("Cart")
        .doc(widget.itemsModel!.Item_Name)
        .update({"Item_quantity": subValue});
    // await TotalQuantityOfEachProduct(widget.itemsModel!.Item_Name.toString());
  }

  RemoveButton() async {
    var data = await FirebaseFirestore.instance
        .collection("Users")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("Cart")
        .doc(widget.itemsModel!.Item_Name)
        .get();
    int valu = await data.data()!["Item_quantity"];
    if (valu <= 1) {
      await updateBooleanToFalse();
      var itemdata = await FirebaseFirestore.instance
          .collection("Users")
          .doc(firebaseAuth.currentUser!.uid)
          .collection("Cart")
          .doc(widget.itemsModel!.Item_Name)
          .get()
          .then((value) => setState(() {
                AddedorNOt = value.data()!["AddedOrNot"];
              }));
      await DeleteItem();
      // SubtractQuantity();
      // await TotalQuantityOfEachProduct(
      //   widget.itemsModel!.Item_Name.toString(),
      // );
    } else {
      SubtractQuantity();
    }
  }

  addQuantity() async {
    var data = await FirebaseFirestore.instance
        .collection("Users")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("Cart")
        .doc(widget.itemsModel!.Item_Name)
        .get();
    int valu = data.data()!["Item_quantity"];
    int value = valu;
    int addition = value + 1;
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("Cart")
        .doc(widget.itemsModel!.Item_Name)
        .update({"Item_quantity": addition});
    // await TotalQuantityOfEachProduct(widget.model!.name.toString());
  }

  @override
  void initState() {
    // TODO: implement initState
    CheckAddedOrNot();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding:
              const EdgeInsets.only(left: 8.0, top: 8, bottom: 10, right: 10),
          child: Container(
              height: 180,
              width: 150,
              margin: EdgeInsets.all(0),
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Color(0xFFA25FFF).withOpacity(0.4),
                        spreadRadius: -5,
                        blurRadius: 6,
                        offset: Offset(-2, 5))
                  ],
                  borderRadius: BorderRadius.circular(12),
                  color: Color.fromARGB(255, 255, 255, 255)),
              child: Column(
                children: [
                  // image
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image(
                      height: 75,
                      width: 75,
                      image: CachedNetworkImageProvider(
                        widget.itemsModel!.Item_picurl.toString(),
                      ),
                    ),
                  ),
                  // name
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 8.0, right: 8.0, bottom: 0, top: 5),
                    child: SizedBox(
                      height: 28,
                      child: Text(
                        textAlign: TextAlign.start,
                        maxLines: 2,
                        widget.itemsModel!.Item_Name.toString().length > 20
                            ? widget.itemsModel!.Item_Name.toString() + "..."
                            : widget.itemsModel!.Item_Name.toString(),
                        style: GoogleFonts.poppins(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontSize: 15,
                            height: 1,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  // Cut pricing
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 22.26,
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 8.0, top: 5),
                                  child: Stack(
                                    children: [
                                      Text(
                                        textAlign: TextAlign.center,
                                        "₹ " +
                                            widget.itemsModel!.Item_cutPrice
                                                .toString(),
                                        style: GoogleFonts.poppins(
                                            color: Color.fromARGB(255, 0, 0, 0),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      Positioned(
                                          top: -4.8,
                                          right: -5,
                                          child: Stack(
                                            children: [
                                              Image(
                                                image: AssetImage(
                                                    "assets/line.png"),
                                                height: 30,
                                                width: 45,
                                              ),
                                            ],
                                          ))
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, right: 8.0),
                                child: Stack(
                                  children: [
                                    Text(
                                      textAlign: TextAlign.center,
                                      "₹ " +
                                          widget.itemsModel!.Item_userPrice
                                              .toString(),
                                      style: GoogleFonts.poppins(
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      
                      AddedorNOt == false
                          ? Padding(
                              padding: const EdgeInsets.only(right: 15.0),
                              child: Container(
                                height: 35,
                                width: 35,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        color:
                                            Color(0xFFA25FFF).withOpacity(0.5),
                                        spreadRadius: -3,
                                        blurRadius: 5,
                                        blurStyle: BlurStyle.outer,
                                        offset: Offset(0, 4))
                                  ],
                                  borderRadius: BorderRadius.circular(8),
                                  color: Color.fromARGB(255, 255, 255, 255),
                                ),
                                child: InkWell(
                                    onTap: () async {
                                      await addDataToFirestore();
                                      await AddQuantity();
                                      await CheckAddedOrNot();
                                      // await updateAddedorNottoTrue();
                                      // print("buttonTaped");
                                      // print("saved to firestore");
                                      // await updateBooleanToTrue();
                                      // print("Update bool to true");
                                      // await updateAddedorNottoTrue();
                                      // print("Update widget");
                                      // await AddQuantity();
                                      // print("Quantity Added");
                                    },
                                    child: Icon(
                                      Icons.add,
                                      color: Color(0xFFA25FFF),
                                    )),
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.only(right: 6.0),
                              child: Container(
                                height: 35,
                                width: 75,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        color:
                                            Color(0xFFA25FFF).withOpacity(0.5),
                                        spreadRadius: -1,
                                        blurRadius: 3,
                                        blurStyle: BlurStyle.outer,
                                        offset: Offset(0, 0))
                                  ],
                                  borderRadius: BorderRadius.circular(8),
                                  color: Color.fromARGB(255, 255, 255, 255),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        await RemoveButton();
                                      },
                                      child: const Icon(
                                        Icons.remove,
                                        color: Color(0xFFA25FFF),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                      width: 15,
                                      child: StreamBuilder(
                                          stream: FirebaseFirestore.instance
                                              .collection("Users")
                                              .doc(
                                                  firebaseAuth.currentUser!.uid)
                                              .collection("Cart")
                                              .doc(widget.itemsModel!.Item_Name)
                                              .snapshots(),
                                          builder: (context,
                                              AsyncSnapshot snapshot) {
                                            if (snapshot.hasData) {
                                              return Text(
                                                snapshot.data!["Item_quantity"]
                                                    .toString(),
                                                style: TextStyle(fontSize: 15),
                                              );
                                            } else {
                                              return CircularProgressIndicator();
                                            }
                                          }),
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        await addQuantity();
                                      },
                                      child: Icon(
                                        Icons.add,
                                        color: Color(0xFFA25FFF),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                    ],
                  ),
                ],
              )),
        ),
        Positioned(
            top: 0,
            right: 0,
            child: Stack(
              children: [
                Image(
                  image: AssetImage("assets/discount.png"),
                  height: 30,
                  width: 30,
                ),
                Positioned(
                  top: 7,
                  right: widget.itemsModel!.Item_offer.toString().length > 1
                      ? 4
                      : 7,
                  child: Center(
                    child: Text(
                      widget.itemsModel!.Item_offer.toString() + " %",
                      style: GoogleFonts.poppins(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 13,
                          letterSpacing: -1,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                )
              ],
            ))
      ],
    );
  }
}
