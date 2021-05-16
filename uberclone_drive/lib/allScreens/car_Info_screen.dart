import 'package:flutter/material.dart';
import 'package:uberclone_drive/allScreens/mainscreen.dart';
import 'package:uberclone_drive/allScreens/registeration_screen.dart';
import 'package:uberclone_drive/configMaps.dart';
import 'package:uberclone_drive/main.dart';

class CarInfoScreen extends StatelessWidget {

  static const String idScreen = "carInfo";

  TextEditingController carModelTextEditingController = TextEditingController();
  TextEditingController carNumberTextEditingController = TextEditingController();
  TextEditingController carColorTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 22.0,),
              Image.asset("images/logo.png", width: 390.0, height: 250.0,),
              Padding(
                padding: EdgeInsets.fromLTRB(22.0, 22.0, 22.0, 32.0),
                child: Column(
                  children: [
                    SizedBox(height: 12.0,),
                    Text("Enter Car Details", style: TextStyle(fontFamily: "Brand-Bold", fontSize: 24.0),),

                    SizedBox(height: 26.0,),
                    TextField(
                      controller: carModelTextEditingController,
                      decoration: InputDecoration(
                        labelText: "Car Model",
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 10.0),
                      ),
                      style: TextStyle(fontSize: 15.0),
                    ),

                    SizedBox(height: 10.0,),
                    TextField(
                      controller: carNumberTextEditingController,
                      decoration: InputDecoration(
                        labelText: "Car Number",
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 10.0),
                      ),
                      style: TextStyle(fontSize: 15.0),
                    ),

                    SizedBox(height: 10.0,),
                    TextField(
                      controller: carColorTextEditingController,
                      decoration: InputDecoration(
                        labelText: "Car Color",
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 10.0),
                      ),
                      style: TextStyle(fontSize: 15.0),
                    ),

                    SizedBox(height: 10.0,),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0 ),
                      child: RaisedButton(
                        onPressed: (){
                          if(carModelTextEditingController.text.isEmpty ){
                            displayToastMessage("Please write car Model", context);
                          }
                          else if(carNumberTextEditingController.text.isEmpty ){
                            displayToastMessage("Please write car Number", context);
                          }
                          else if(carColorTextEditingController.text.isEmpty ){
                            displayToastMessage("Please write car Color", context);
                          }
                          else{
                            saveDriverCarInfo(context);
                          }
                        },
                        color: Theme.of(context).accentColor,
                        child: Padding(
                          padding: EdgeInsets.all(17.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Next", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white,),),
                              Icon(Icons.arrow_forward, color: Colors.white ,size: 26.0,),
                              ],
                            ),
                          )
                        ),
                      ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      
    );
  }

  void saveDriverCarInfo(context){

    String userId = currentFirebaseUser.uid;

    Map carInfoMap = {
      "car_color": carColorTextEditingController.text.trim(),
      "car_number": carNumberTextEditingController.text.trim(),
      "car_model": carModelTextEditingController.text.trim(),
    };

    driversRef.child(userId).child("car_details").set(carInfoMap);

    Navigator.pushNamedAndRemoveUntil(context, MainScreen.idScreen , (route) => false);
  }
}