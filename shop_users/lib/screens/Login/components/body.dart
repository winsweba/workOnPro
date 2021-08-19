import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shop_users/block/toast_mg_block.dart';
import 'package:shop_users/components/already_have_an_account_acheck.dart';
import 'package:shop_users/components/rounded_button.dart';
import 'package:shop_users/components/rounded_input_field.dart';
import 'package:shop_users/components/rounded_password_field.dart';
import 'package:shop_users/screens/Login/components/background.dart';
import 'package:shop_users/screens/Signup/signup_screen.dart';
import 'package:shop_users/screens/home_screen.dart';

class Body extends StatefulWidget {
  const Body({
    Key key,
  }) : super(key: key);

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
              "LOGIN",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/login.svg",
              height: size.height * 0.35,
            ),
            SizedBox(height: size.height * 0.03),
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
              text: "LOGIN",
              press: () {
                if (!emailTextEditingController.text.contains("@")) {
                  displayToastMessage("Email address is not Valid", context);
                } else if (passwordTextEditingController.text.isEmpty) {
                  displayToastMessage("Password is Mand", context);
                } else {
                  loginAndAuthenticateUser(context);
                }
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
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

  void loginAndAuthenticateUser(BuildContext context) async {
    try {
      UserCredential user =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailTextEditingController.text,
        password: passwordTextEditingController.text,
      );
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => HomePage()));
      displayToastMessage("You are now Login ", context);
    } catch (e) {
      print(e.toString());
      displayToastMessage("Error:::: " + e.toString(), context);
    }
  }
}
