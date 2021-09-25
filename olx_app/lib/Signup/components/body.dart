import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:olx_app/DialogBox/error_dialog.dart';
import 'package:olx_app/DialogBox/loading_dialog.dart';
import 'package:olx_app/Login/login_screen.dart';
import 'package:olx_app/Signup/components/background.dart';
import 'package:olx_app/Welcome/welcome_screen.dart';
import 'package:olx_app/Widgets/already_have_an_account_acheck.dart';
import 'package:olx_app/Widgets/rounded_button.dart';
import 'package:olx_app/Widgets/rounded_input_field.dart';
import 'package:olx_app/Widgets/rounded_password_field.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebaseStorage;
import 'package:olx_app/otherScreens/global_avaribles.dart';
import 'package:olx_app/otherScreens/home_screene.dart';
import 'package:olx_app/otherScreens/uploadAddScreen.dart';
import 'package:toast/toast.dart';
class SignupBody extends StatefulWidget {
  @override
  _SignupBodyState createState() => _SignupBodyState();
}

class _SignupBodyState extends State<SignupBody> {

  String userPhotoUrl = "";

  File _image;
  final _picker = ImagePicker();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;


  // chooseImage() async {
  //   final pickedFile = await picker.getImage(source: ImageSource.gallery);
  //   File file = File(pickedFile.path);

  //   setState(() {
  //     _image = file;
  //   });
  // }

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
      _image = compressedFile;
    });
      
    }else{
      print('No Path Received');
    }
  }

  upload() async{
    showDialog(
      context: context,
      builder: (_){
        return LoadingAlertDialog();
      }
    );

    String fileName = DateTime
    .now()
    .millisecondsSinceEpoch
    .toString();

    firebaseStorage.Reference reference = 
      firebaseStorage.FirebaseStorage.instance.ref(fileName);
    firebaseStorage.UploadTask uploadTask = reference.putFile(_image);
    firebaseStorage.TaskSnapshot storageTaskSnapshot = await uploadTask.whenComplete(() {

    } );

    await storageTaskSnapshot.ref.getDownloadURL().then((url) {
      userPhotoUrl = url;
      print(userPhotoUrl);
      _register();
    } );

    // await storageTaskSnapshot.ref.getDownloadURL().then((url) {
    //   userImageUrl = url;
    //   print(userImageUrl);
    //   _register();
    // } );

  }

  void _register() async {
    User currentUser;

    await _auth.createUserWithEmailAndPassword(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim()
    ).then((auth) {
      currentUser = auth.user;
      userId = currentUser.uid;
      userEmail = currentUser.email;
      getUserName = _nameController.text.trim();

      saveUserData();
    }).catchError((error){
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (con){
          return ErrorAlertDialog(
            message: error.message.toString(),
          );
        }
      );
    });

    if ( currentUser != null ) {
      Route newRoute = MaterialPageRoute(
              builder: (context) => HomeScreene()
            );
            Navigator.pushReplacement(context, newRoute);
    }
  }

  void saveUserData() {
    Map<String, dynamic> userData = {
      'userName' : _nameController.text.trim(),
      'uid': userId,
      'userNumber': _phoneController.text.trim(),
      'imgPro': userPhotoUrl,
      // 'imgPro': userImageUrl,
      'time': DateTime.now(),
      'status': "approved",
    };

    FirebaseFirestore.instance.collection('users').doc(userId).set(userData);
  }

  @override
  Widget build(BuildContext context) {

    double _screenWidth = MediaQuery.of(context).size.width,
    _screenHeight = MediaQuery.of(context).size.height;


    return SignupBackground(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InkWell(
              onTap: (){
                chooseImage();
              },
              child: CircleAvatar(
                radius: _screenWidth * 0.20,
                backgroundColor: Colors.deepPurple[100],
                backgroundImage: _image==null?null:FileImage(_image),
                child: _image == null
                ? Icon(
                  Icons.add_photo_alternate,
                  size: _screenWidth * 0.20,
                  color: Colors.white,
                )
                    : null,
              )),
            SizedBox(height: _screenHeight * 0.01),
            RoundedInputField(
              hintText: "Name",
              icon: Icons.person,
              onChanged: (value)
              {
                _nameController.text = value;
              },
            ),
            RoundedInputField(
              hintText: "Email",
              icon: Icons.person,
              onChanged: (value)
              {
                _emailController.text = value;
              },
            ),
            RoundedPasswordField(
              onChanged: (value)
              {
                _passwordController.text = value;
              },
            ),
            RoundedButton(
              text: "SIGNUP",
              press: ()
              {

                if (_nameController.text.length < 3 )
                  {
                    showToast("Name must be at lest 3 characters.", context,duration: 2,gravity: Toast.CENTER);
                  }

                  else if (!_emailController.text.contains(regExpEmail) )
                  {
                    showToast("Email address is not Valid", context,duration: 2,gravity: Toast.CENTER);
                  }
                  else if (_passwordController.text.length < 6 )
                  {
                    showToast("Password must be at lest 6 characters.", context,duration: 2,gravity: Toast.CENTER);
                  }
                  else{
                    
                upload();
                  }
              },
            ),
            SizedBox(height: _screenHeight * 0.03,),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),

          ],










        ),
      ),
    );
  }
}


  final RegExp regExpEmail = RegExp(
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');