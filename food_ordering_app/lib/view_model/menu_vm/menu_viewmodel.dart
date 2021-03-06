import 'package:flutter/cupertino.dart';

abstract class MenuViewModel {
  void navigateCategory();
  void backToRestaurantList(); 
  bool checkLoginState(BuildContext context);
  void login(BuildContext context);
  void logout(BuildContext context);
  void navigationHome(BuildContext context);
  void navigateCat();
  void viewOrderHistory(BuildContext context);
  void managerResturant(BuildContext context);
}