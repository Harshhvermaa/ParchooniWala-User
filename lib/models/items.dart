import 'package:cloud_firestore/cloud_firestore.dart';

class ItemsModel{
  String? Item_Name;
  String? Item_picurl;
  int? Item_Weight;
  String? Item_wunit;
  int? Item_userPrice;
  int? Item_adminPrice;
  int? Item_cutPrice;
  int? Item_offer;
  Timestamp? Date;
  bool? AddedOrNot;
  int? Item_quantity;
  String? Description;

  ItemsModel({
    this.Item_Name,
    this.Item_picurl,
    this.Item_Weight,
    this.Item_wunit,
    this.Item_userPrice,
    this.Item_adminPrice,
    this.Item_cutPrice,
    this.Item_offer,
    this.Date,
    this.AddedOrNot,
    this.Item_quantity,
    this.Description,
  });


ItemsModel.fromJson(Map<String , dynamic> json)
{
Item_Name = json["Item_Name"];
Item_picurl    = json["Item_picurl"];
Item_Weight    = json["Item_Weight"];
Item_wunit   = json["Item_wunit"];
Item_userPrice    = json["Item_userPrice"];
Item_adminPrice    = json["Item_adminPrice"];
Item_cutPrice   = json["Item_cutPrice"];
AddedOrNot   = json["AddedOrNot"];
Item_offer    = json["Item_offer"];
Date    = json["Date"];
Item_quantity   = json["Item_quantity"];
Description   = json["Description"];
}

Map<String,dynamic> toJson()
{
  Map<String,dynamic> data = Map<String,dynamic>();
data["Item_Name"] = Item_Name  ;
data["Item_picurl"] = Item_picurl  ;
data["Item_Weight"] = Item_Weight  ;
data["Item_wunit"] = Item_wunit  ;
data["Item_userPrice"] = Item_userPrice  ;
data["Item_adminPrice"] = Item_adminPrice  ;
data["AddedOrNot"] = AddedOrNot  ;
data["Item_cutPrice"] = Item_cutPrice  ;
data["Item_offer"] = Item_offer  ;
data["Date"] = Date  ;
data["Item_quantity"] = Item_quantity  ;
data["Description"] = Description  ;
return data;
}

}