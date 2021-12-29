import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_app/firebase/server_user_reference.dart';
import 'package:food_ordering_app/models/server_user_model.dart';
import 'package:food_ordering_app/sate/main_state.dart';
import 'package:food_ordering_app/sate/server_manager_state.dart';
import 'package:food_ordering_app/strings/cart_strings.dart';
import 'package:food_ordering_app/strings/manager_restaurant_string.dart';
import 'package:food_ordering_app/strings/place_order_string.dart';
import 'package:food_ordering_app/strings/restaurant_home_string.dart';
import 'package:food_ordering_app/view_model/manager_restaurant_vm/manager_restaurant_view_model.dart';
import 'package:food_ordering_app/view_model/manager_restaurant_vm/manager_restaurant_view_model_imp.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';

class ManagerResturantScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ManagerResturantScreenState();
}

class ManagerResturantScreenState extends State<ManagerResturantScreen> {
  ServerManagerState serverManagerState = Get.put(ServerManagerState());
  MainStateController mainStateController = Get.find();

  ManagerRestaurantViewModel managerRestaurantViewModel =
      new ManagerRestaurantVMImp();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      var result =
          await checkIsServerUser(FirebaseAuth.instance.currentUser!.uid);
      serverManagerState.isServerLogin.value = result;

      if (!result) // if user not login
        showRegisterDialog();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(managerResturantText),
      ),
      body: Center(
          child: Obx(
        () =>
            Text('Is Server Login: ${serverManagerState.isServerLogin.value}'),
      )),
    );
  }

  void showRegisterDialog() {
    final firstNameController = TextEditingController();
    final lastNameController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    Get.defaultDialog(
      title: registerManagerText,
      content: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Expanded(
                child: TextFormField(
                  controller: firstNameController,
                  validator: ValidationBuilder(
                          requiredMessage: '$firstNameText $isRequiredText')
                      .required()
                      .build(),
                  decoration: InputDecoration(
                      hintText: firstNameText,
                      label: Text(firstNameText),
                      border: OutlineInputBorder()),
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: TextFormField(
                  controller: lastNameController,
                  validator: ValidationBuilder(
                          requiredMessage: '$lastNameText $isRequiredText')
                      .required()
                      .build(),
                  decoration: InputDecoration(
                      hintText: lastNameText,
                      label: Text(lastNameText),
                      border: OutlineInputBorder()),
                ),
              ),
            ])
          ]),
        ),
      ),
      textConfirm: registerText,
      textCancel: cancelText,
      confirmTextColor: Colors.white,
      onConfirm: () async {
        ServerUserModel serverUserModel = new ServerUserModel(
          '${firstNameController.text} ${lastNameController.text}',
          mainStateController.selectedRestaurant.value.restaurantId,
          FirebaseAuth.instance.currentUser!.uid,
          FirebaseAuth.instance.currentUser!.phoneNumber.toString(),
        );
        await managerRestaurantViewModel.regiserServerUser(serverUserModel);
      },
    );
  }
}
