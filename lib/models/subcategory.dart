
class subCategory
{
  String? subcategory_image;
  bool? Available;
  String? subcategory_name;
  String? subcategory_offer;

  subCategory({ this.subcategory_image, this.subcategory_name, this.subcategory_offer });

  subCategory.fromJson(Map<String, dynamic> json)
  {
      Available = json["Available"];    
      subcategory_image = json["subcategory_image"];
      subcategory_name = json["subcategory_name"];
      subcategory_offer = json["subcategory_offer"];
  }

  Map<String,dynamic> tojson()
  {
    Map<String,dynamic> data = Map<String,dynamic>();
    data["Available"] = Available;
    data["subcategory_image"] = subcategory_image; 
    data["subcategory_name"] = subcategory_name; 
    data["subcategory_offer"] = subcategory_offer; 
    return data;
  }
}