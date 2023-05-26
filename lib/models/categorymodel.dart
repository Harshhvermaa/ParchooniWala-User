import 'package:flutter/material.dart';

class CategoriesModel
{
  String? category_image;
  String? category_name;
  String? category_offer;
  bool? Available;

  CategoriesModel({ this.category_image, this.category_name, this.category_offer,this.Available });

  CategoriesModel.fromJson(Map<String, dynamic> json)
  {
      category_image = json["category_image"];
      category_name = json["category_name"];
      Available = json["Available"];
      category_offer = json["category_offer"];
  }

  Map<String,dynamic> tojson()
  {
    Map<String,dynamic> data = Map<String,dynamic>();
    data["category_image"] = category_image; 
    data["category_name"] = category_name; 
    data["Available"] = Available;
    data["category_offer"] = category_offer; 
    return data;
  }
}