import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_auth_ui/flutter_auth_ui.dart';
import 'package:food_ordering_app/screen/category.dart';
import 'package:food_ordering_app/screen/restaurent_home.dart';
import 'package:food_ordering_app/strings/main_strings.dart';
import 'package:food_ordering_app/utils/const.dart';
import 'package:food_ordering_app/view_model/menu_vm/menu_viewmodel.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
class MenuViewModelImp implements MenuViewModel {
  @override
  void navigateCategory() {
    Get.to(() => CategoryScreen());
  }

  @override
  void backToRestaurantList() {
    Get.back(closeOverlays: true, canPop: false);
  }

  @override
  bool checkLoginState(BuildContext context) {
    return FirebaseAuth.instance.currentUser != null ? true : false;
  }

  @override
  void login(BuildContext context) {
    var user = FirebaseAuth.instance.currentUser;
    if(user == null ){
      FlutterAuthUi.startUi(items: [AuthUiProvider.phone], tosAndPrivacyPolicy: TosAndPrivacyPolicy(tosUrl: 'https://google.com', privacyPolicyUrl: 'https://youtube.com'),
      androidOption: AndroidOption(
        enableSmartLock: false,
        showLogo: true,
      ),
      ).then((value) {
        navigationHome(context);
      }).catchError((e) {
        Get.snackbar('Error', '$e');
      });
    }
  }

  @override
  void logout(BuildContext context) {
    Get.defaultDialog(
      title: logoutTitle,
      content: Text(logoutText),
      backgroundColor: Colors.white,
      cancel: ElevatedButton(onPressed: () => Get.back(), child: Text(cancelText) ),
      confirm: ElevatedButton(onPressed: () {
        FirebaseAuth.instance
        .signOut()
        .then((value) => Get.offAll(RestaurantHome(),),);

      }, child: Text(confirmText, style: TextStyle(color: Colors.yellow),), ),
      
    );
    
  }

  @override
  void navigationHome(BuildContext context) async {
    var token = await FirebaseAuth.instance.currentUser!.getIdToken();
    var box = GetStorage();
    box.write(KEY_TOKEN, token);
  }
}
