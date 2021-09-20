// Populer and best Deals 

class PopulerItemModel{
  String foodId = "",name = "",menuId = "",image = "";

  PopulerItemModel({
    this.foodId,
    this.name,
    this.menuId,
    this.image,
  });

  PopulerItemModel.fromJson(Map<String, dynamic> json) {
    foodId = json["foodId"];
    name = json["name"];
    menuId = json["menuId"];
    image = json["image"];
  }

  Map<String, dynamic> toJson(){
   var data = Map<String, dynamic>();
   data['foodId'] = this.foodId;
   data['name'] = this.name;
   data['menuId'] = this.menuId;
   data['image'] = this.image;

   return data;
  }
}