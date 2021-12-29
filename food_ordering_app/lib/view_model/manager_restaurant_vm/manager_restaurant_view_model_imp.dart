import 'package:food_ordering_app/firebase/server_user_reference.dart';
import 'package:food_ordering_app/models/server_user_model.dart';
import 'package:food_ordering_app/sate/server_manager_state.dart';
import 'package:food_ordering_app/view_model/manager_restaurant_vm/manager_restaurant_view_model.dart';
import 'package:get/get.dart';

class ManagerRestaurantVMImp implements ManagerRestaurantViewModel {
  ServerManagerState serverManagerState = Get.find();
  @override
  Future regiserServerUser(ServerUserModel serverUserModel) async {
    var result = await writeServerToFirebase(serverUserModel);
    if(result) {
      serverManagerState.isServerLogin.value = await checkIsServerUser(serverUserModel.uid);
      Get.back();
    }
  } 
}