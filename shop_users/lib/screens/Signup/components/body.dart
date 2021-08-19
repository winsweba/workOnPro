import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shop_users/block/toast_mg_block.dart';
import 'package:shop_users/components/already_have_an_account_acheck.dart';
import 'package:shop_users/components/rounded_button.dart';
import 'package:shop_users/components/rounded_input_field.dart';
import 'package:shop_users/components/rounded_password_field.dart';
import 'package:shop_users/screens/Login/login_screen.dart';
import 'package:shop_users/screens/Signup/components/background.dart';
import 'package:shop_users/screens/Signup/components/or_divider.dart';
import 'package:shop_users/screens/Signup/components/social_icon.dart';
import 'package:shop_users/screens/home_screen.dart';
import 'package:shop_users/servers/firestore_servers.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {

  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "SIGNUP",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/signup.svg",
              height: size.height * 0.35,
            ),
            RoundedInputField(
              controller: emailTextEditingController,
              hintText: "Your Email",
              onChanged: (value) {},
            ),
            RoundedPasswordField(
              controller: passwordTextEditingController,
              onChanged: (value) {},
            ),
            RoundedButton(
              text: "SIGNUP",
              press: () {
                  if (!emailTextEditingController.text.contains("@") )
                  {
                    displayToastMessage("Email address is not Valid", context);
                  }
                  else if (passwordTextEditingController.text.length < 6 )
                  {
                    displayToastMessage("Password must be at lest 6 characters.", context);
                  }

                  else
                {
                  registerNewUser(context);
                }
              },
            ),
            SizedBox(height: size.height * 0.03),
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
            // OrDivider(),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: <Widget>[
            //     SocalIcon(
            //       iconSrc: "assets/icons/facebook.svg",
            //       press: () {},
            //     ),
            //     SocalIcon(
            //       iconSrc: "assets/icons/twitter.svg",
            //       press: () {},
            //     ),
            //     SocalIcon(
            //       iconSrc: "assets/icons/google-plus.svg",
            //       press: () {},
            //     ),
            //   ],
            // )
          ],
        ),
      ),
    );
  }

  void registerNewUser(BuildContext context) async {
    try {
      UserCredential user =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailTextEditingController.text,
        password: passwordTextEditingController.text,
      );
      // User updateUser = FirebaseAuth.instance.currentUser;
      userSetup(emailTextEditingController.text);
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => HomePage()));
          
          displayToastMessage("Thank you for Signning up ", context);
    } catch (e) {
      print(e.toString());
      displayToastMessage("Error:::: " + e.toString(),context);
    }
  }
}
