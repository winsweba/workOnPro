import 'package:food_ordering_app/screen/category.dart';
import 'package:food_ordering_app/view_model/menu_vm/menu_viewmodel.dart';
import 'package:get/get.dart';

class MenuViewModelImp implements MenuViewModel {
  @override
  void navigateCategory() {
    Get.to(() => CategoryScreen());
  }
  
}