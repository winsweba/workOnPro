import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:olx_app/DialogBox/error_dialog.dart';
import 'package:olx_app/DialogBox/loading_dialog.dart';
import 'package:olx_app/Login/components/background.dart';
import 'package:olx_app/Login/login_screen.dart';
import 'package:olx_app/Signup/signup_screen.dart';
import 'package:olx_app/Widgets/already_have_an_account_acheck.dart';
import 'package:olx_app/Widgets/rounded_button.dart';
import 'package:olx_app/Widgets/rounded_input_field.dart';
import 'package:olx_app/Widgets/rounded_password_field.dart';
import 'package:olx_app/otherScreens/home_screene.dart';

class LoginBody extends StatefulWidget {
  @override
  _LoginBodyState createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _login() async{
    showDialog(
      context: context,
      builder: (_){
        return LoadingAlertDialog();
      }
    );

    User currentUser;

    await _auth.signInWithEmailAndPassword(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    ).then((auth) {
      currentUser = auth.user;
    }).catchError((error) {
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (con){
          return ErrorAlertDialog(
            message: error.message.toString(),
          );
        }
      );
    },);

    if(currentUser != null ){
      getUserData(currentUser.uid);
    }
    else{
      print("Error.....");
    }

  }

  getUserData(String uid) async{
      await FirebaseFirestore.instance.collection('users').doc(uid).get().then((result) {
        String status = result.data()['status'];
        if (status == 'approved'){
          Route newRoute = MaterialPageRoute(builder: (context) => HomeScreene());
          Navigator.pushReplacement(context, newRoute);
        }
        else{
          _auth.signOut();

          Navigator.pop(context);
          Route newRoute = MaterialPageRoute(builder: (context) => LoginScreen());
          Navigator.pushReplacement(context, newRoute);

          showDialog(
        context: context,
        builder: (con){
          return ErrorAlertDialog(
            message: "This Account has been block by admin. Please contact the our helpline: 0241012217",
          );
        }
      );
        }
      });
    }
  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return LoginBackground(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.03,),
            SvgPicture.asset(
              "assets/icons/login.svg",
              height: size.height * 0.35,
            ),
            SizedBox(height: size.height * 0.03,),
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
              text: "LOGIN",
              press: (){
                _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty
                ? _login()
                : showDialog(
        context: context,
        builder: (con){
          return ErrorAlertDialog(
            message: "Please write email & password for login",
          );
        }
      );
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              login: true,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
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
