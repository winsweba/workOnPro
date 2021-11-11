import 'package:admin_olx/DialogBox/errorDialog.dart';
import 'package:admin_olx/DialogBox/loadingDialog.dart';
import 'package:admin_olx/Login/backgroundPainter.dart';
import 'package:admin_olx/MainScreens/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';




class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}



class _LoginScreenState extends State<LoginScreen>
{
  String email="";
  String password="";

  returnEmailField(IconData icon, bool isObscure)
  {
    return TextField(
      onChanged: (value)
      {
        email = value;
      },
      obscureText: isObscure,
      style: TextStyle(fontSize: 15.0, color: Colors.white),
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.green),
        ),
        hintText: "Email",
        hintStyle: TextStyle(color: Colors.white),
        icon: Icon(
          icon,
          color: Colors.green,
        ),
      ),
    );
  }

  returnPasswordField(IconData icon, bool isObscure)
  {
    return TextField(
      onChanged: (value)
      {
        password = value;
      },
      obscureText: isObscure,
      style: TextStyle(fontSize: 15.0, color: Colors.white),
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.green),
        ),
        hintText: "Password",
        hintStyle: TextStyle(color: Colors.white),
        icon: Icon(
          icon,
          color: Colors.green,
        ),
      ),
    );
  }

  returnLoginButton()
  {
    return ElevatedButton(
      onPressed: ()
      {
        if(email != "" && password != "")
        {
          //login
          loginAdmin();
        }
      },
      child: Text(
        "Login",
        style: TextStyle(
          color: Colors.white,
          letterSpacing: 2.0,
          fontSize: 16.0,
        ),
      ),
    );
  }

  loginAdmin() async
  {
    showDialog(
      context: context,
      builder: (context)
      {
        return LoadingAlertDialog(
          message: "please wait...",
        );
      }
    );

    User currentUser;
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    ).then((aAuth)
    {
      currentUser = aAuth.user;
    }).catchError((error)
    {
      Navigator.pop(context);

      showDialog(
          context: context,
          builder: (context)
          {
            return ErrorAlertDialog(
              message: "Error Occured: " + error.toString(),
            );
          }
      );
    });

    if(currentUser != null)
    {
      //homepage
      Route newRoute = MaterialPageRoute(builder: (context) => HomeScreen());
      Navigator.pushReplacement(context, newRoute);
    }
    else
    {
      //loginPage
      Route newRoute = MaterialPageRoute(builder: (context) => LoginScreen());
      Navigator.pushReplacement(context, newRoute);
    }
  }


  @override
  Widget build(BuildContext context)
  {
    double _screenWidth = MediaQuery.of(context).size.width,
        _screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black87,
      body: Stack(
        alignment: Alignment.lerp(
            Alignment.lerp(Alignment.centerRight, Alignment.center, 0.3),
            Alignment.topCenter,
            0.15,
        ),
        children: [
          CustomPaint(
            painter: BackgroundPainter(),
            child: Container(height: _screenHeight,),
          ),
          Center(
            child: Container(
              width: _screenWidth,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 40.0),
                        child: Image.asset("images/admin.png", width: 250, height: 250,),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 50.0),
                      child: returnEmailField(Icons.person, false),
                    ),
                    SizedBox(height: 20.0,),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 50.0),
                      child: returnPasswordField(Icons.person, true),
                    ),
                    SizedBox(height: 40.0,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 50.0),
                          child: returnLoginButton(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
