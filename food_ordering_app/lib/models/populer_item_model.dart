// Populer and best Deals 

class PopulerItemModel{
  String foodId = "",name = "",menuId = "",image = "";

  PopulerItemModel({
    required this.foodId,
    required this.name,
    required this.menuId,
    required this.image,
  });

  PopulerItemModel.fromJson(Map<String, dynamic> json) {
    foodId = json["food_id"] == null ? '' : json['food_id'];
    name = json["name"] == null ? '' : json['name'];
    menuId = json["menu_id"] == null ? '' : json['menu_id'];
    image = json["image"] == null ? '' : json['image'];
  }

  Map<String, dynamic> toJson(){
   var data = Map<String, dynamic>();
   data['food_id'] = this.foodId;
   data['name'] = this.name;
   data['menu_id'] = this.menuId;
   data['image'] = this.image;

   return data;
  }
}