import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:olx_app/DialogBox/loading_dialog.dart';
import 'package:olx_app/otherScreens/global_avaribles.dart';
import 'package:olx_app/otherScreens/home_screene.dart';
import 'package:toast/toast.dart';
import 'package:path/path.dart' as Path;

class UploadAddScreen extends StatefulWidget {

  @override
  _UploadAddScreenState createState() => _UploadAddScreenState();
}

class _UploadAddScreenState extends State<UploadAddScreen> {

  String userPhotoUrl = "";
  
  bool uploading = false, next = false;
  double val = 0;
  CollectionReference imgRef;
  firebase_storage.Reference ref;
  String imgFule = "", imgFule1 = "", imgFule2 = "", imgFule3 = "", imgFule4 = "", imgFule5 = "";

  List<File> _image = [];
  List<String> urlsList = [];
  final _picker = ImagePicker();

  FirebaseAuth auth = FirebaseAuth.instance;
  String userName = "";
  String userNumber = "";
  String itemPrice = "";
  String itemModel = "";
  String itemColor = "";
  String description = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          next ? "Please write Items's Info " : "Choose Item Images",
          style: TextStyle(fontSize: 10.0, fontFamily: "Lobster", letterSpacing: 2.0 ),
        ),
        actions: [
          next ? Container()
          : ElevatedButton(
            onPressed: () {
              if (_image.length == 5) {
                setState(() {
                uploading = true;
                next = true;

                },
                );
              }
              else{
                showToast(
                  "Please select all 5 images only..... ",
                  context,
                  duration: 2,
                  gravity: Toast.CENTER
                );
              }
            },
            child: Text(
              'Next',
              style: TextStyle(fontSize: 18.0, color: Colors.white, fontFamily: "varela"),
            ),
          )
        ],
      ),
      body: next ? SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(hintText: "Enter Your Name"),
                onChanged: (value) {
                  this.userName = value;
                },
              ),
              SizedBox(height: 5.0,),
              TextField(
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(hintText: "Enter Your Number"),
                onChanged: (value) {
                  this.userNumber = value;
                },
              ),
              SizedBox(height: 5.0,),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(hintText: "Enter Item price"),
                onChanged: (value) {
                  this.itemPrice = value;
                },
              ),
              SizedBox(height: 5.0,),
              TextField(
                decoration: InputDecoration(hintText: "Enter Item Name"),
                onChanged: (value) {
                  this.itemModel = value;
                },
              ),
              SizedBox(height: 5.0,),
              TextField(
                decoration: InputDecoration(hintText: "Enter Item Color"),
                onChanged: (value) {
                  this.itemColor = value;
                },
              ),
              SizedBox(height: 5.0,),
              TextField(
                maxLines: 4,
                decoration: InputDecoration(hintText: "Write item Description "),
                onChanged: (value) {
                  this.description = value;
                },
              ),
              SizedBox(height: 10.0,),
              Container(
                width: MediaQuery.of(context).size.width * 0.5,
                child: ElevatedButton(
                  onPressed: () {
                    

                    if(this.userName.length < 3){
                      showToast("User Name must not be less then 3", context,duration: 2,gravity: Toast.CENTER);
                    }
                    else if(this.userNumber.length < 8 ){
                      showToast("User Nummber Must be 10", context,duration: 2,gravity: Toast.CENTER);
                    }
                    else if(this.itemPrice == '' ){
                      showToast("Item Price is needed", context,duration: 2,gravity: Toast.CENTER);
                    }
                    else if(this.itemModel.length < 2 ){
                      showToast("Item Tepy is needed", context,duration: 2,gravity: Toast.CENTER);
                    }
                    else if(this.description.length < 5 ){
                      showToast("Description must not be less then 5", context,duration: 2,gravity: Toast.CENTER);
                    }
                    else{

                      showDialog(context: context, builder: (con) {
                      return LoadingAlertDialog(
                        message: "Uploading........",
                      );
                    });

                      uploadFile().whenComplete(() { 
                      Map<String, dynamic> addData ={
                        'userName' : this.userName,
                        'uId': auth.currentUser.uid,
                        'userNumber': this.userNumber,
                        'itemPrice': this.itemPrice,
                        'itemModel': this.itemModel,
                        'itemColor': this.itemColor,
                        'description': this.description,
                        'urlImage1': urlsList[0].toString(),
                        'urlImage2': urlsList[1].toString(),
                        'urlImage3': urlsList[2].toString(),
                        'urlImage4': urlsList[3].toString(),
                        'urlImage5': urlsList[4].toString(),
                        'imgPro': userPhotoUrl,
                        'lat': position.latitude,
                        'lng': position.longitude,
                        'address': completeAddress,
                        'time': DateTime.now(),
                        'status': "not approved",
                        
                      };
                      FirebaseFirestore.instance.collection('items').add(addData).then((value) {
                        print("Data Added Successfully");
                        Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreene()));
                      }).catchError((onError){
                        print(onError);
                      });
                    });

                    }

                    // uploadFile().whenComplete(() { 
                    //   Map<String, dynamic> addData ={
                    //     'userName' : this.userName,
                    //     'uId': auth.currentUser.uid,
                    //     'userNumber': this.userNumber,
                    //     'itemPrice': this.itemPrice,
                    //     'itemModel': this.itemModel,
                    //     'itemColor': this.itemColor,
                    //     'description': this.description,
                    //     'urlImage1': urlsList[0].toString(),
                    //     'urlImage2': urlsList[1].toString(),
                    //     'urlImage3': urlsList[2].toString(),
                    //     'urlImage4': urlsList[3].toString(),
                    //     'urlImage5': urlsList[4].toString(),
                    //     'imgPro': userImageUrl,
                    //     'lat': position.latitude,
                    //     'lng': position.longitude,
                    //     'address': completeAddress,
                    //     'time': DateTime.now(),
                    //     'status': "not approved",
                        
                    //   };
                    //   FirebaseFirestore.instance.collection('items').add(addData).then((value) {
                    //     print("Data Added Successfully");
                    //     Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreene()));
                    //   }).catchError((onError){
                    //     print(onError);
                    //   });
                    // });
                  },
                  child: Text("Upload", style: TextStyle(color: Colors.white),),
                ),
              ),
              SizedBox( height: 20.0,)
            ],
          ),
        ),
      ): Stack(
        children: [
          Container(
            padding: EdgeInsets.all(4),
            child: GridView.builder(
              itemCount: _image.length +1,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemBuilder: (context, index) {
                return index == 0 
                  ? Center(
                    child: IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () => 
                      !uploading ? chooseImage() : null,
                    ),
                  ): Container(
                    margin: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: FileImage(_image[index - 1]),
                        fit: BoxFit.cover,
                      )
                    ),
                  );
              },
            ),
          ),
          uploading ? Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  child: Text("uploading...", style: TextStyle(fontSize: 20.0),),
                ),
                CircularProgressIndicator(
                  value: val,
                  valueColor: AlwaysStoppedAnimation<Color> (Colors.white),
                )
              ],
            ),
          ) :
          Container()
        ],
      ),
      
    );
  }



  chooseImage() async {
    PickedFile image;
    File croppedFile;


   
    
      //Get Image From Divce 
    image =await _picker.getImage(source: ImageSource.gallery);
    
    
    //Upload to Firebase
    if(image != null) {
      // _isUploading.sink.add(true);
      // Geting Image Properties
      ImageProperties properties = await FlutterNativeImage.getImageProperties(image.path);


      //CropImage
      if(properties.height > properties.width){
        var yoffset = (properties.height - properties.width)/2;
        croppedFile = await FlutterNativeImage.cropImage(image.path, 0, yoffset.toInt(),properties.width, properties.width);
      } else if (properties.width > properties.height){
        var xoffset = (properties.width - properties.height)/2;
        croppedFile = await FlutterNativeImage.cropImage(image.path, xoffset.toInt(), 0 , properties.height, properties.height);
      } else {
        croppedFile = File(image.path);
      }

      File compressedFile = await FlutterNativeImage.compressImage(croppedFile.path, quality: 100, targetHeight: 600, targetWidth: 600);

      setState(() {
      _image.add(File(compressedFile.path));
    });
      
    }else{
      print('No Path Received');
    }
  }

  // chooseImage() async{
  //   final pickedFile = await _picker.getImage(source: ImageSource.gallery);
  //   setState(() {
  //         _image.add(File(pickedFile?.path));
  //       });
  //       if (pickedFile.path == null ) retriveeLostData();
  // }

  Future<void> retriveeLostData() async {
    final LostData response = await _picker.getLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file == null){
      setState(() {
              _image.add(File(response.file.path));
            });
    }
    else{
      print(response.file);
    }
  }

  Future uploadFile() async{
    int i = 1;

    for(var img in _image ){
      setState(() {
              val = i / _image.length;
            });
            ref = firebase_storage.FirebaseStorage.instance.ref().child('image/${Path.basename(img.path)}');

            await ref.putFile(img).whenComplete(() async{
              await ref.getDownloadURL().then((value) {
                urlsList.add(value);
              });
            });
    }
  }

  void showToast(String msg,BuildContext context ,{int duration, int gravity}){
    Toast.show( msg, context, duration: duration, gravity: gravity);
  }

  @override
    void initState() {
      // TODO: implement initState
      super.initState();
      imgRef = FirebaseFirestore.instance.collection("imageUrls");
    }
}