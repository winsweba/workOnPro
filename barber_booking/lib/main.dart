import 'package:barber_booking/screens/home_screen.dart';
import 'package:barber_booking/state/state_mangement.dart';
import 'package:barber_booking/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_ui/firebase_auth_ui.dart';
import 'package:firebase_auth_ui/providers.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:page_transition/page_transition.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //Firebase
  Firebase.initializeApp();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/home':
            return PageTransition(
                settings: settings,
                child: HomePage(), 
                type: PageTransitionType.fade);
            break;
          default:
            return null;
        }
      },
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends ConsumerWidget {
  GlobalKey<ScaffoldState> scaffoldState = new GlobalKey();

  processLogin(BuildContext context) {
    var user = FirebaseAuth.instance.currentUser;

    if (user == null) // User not login, show log in
    {
      FirebaseAuthUi.instance()
          .launchAuth([AuthProvider.phone()]).then((firebaseUser) async{
        // Refesf state
        context.read(userLogged).state = FirebaseAuth.instance.currentUser;

        // ScaffoldMessenger.of(scaffoldState.currentContext)
        //     .showSnackBar(SnackBar(
        //   content: Text(
        //       'Login success ${FirebaseAuth.instance.currentUser.phoneNumber}'),
        // ));
        

        // Start new Screen 
        // Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);

        await checkLoginState(context, true);


      }).catchError((e) {
        if (e is PlatformException) if (e.code ==
            FirebaseAuthUi.kUserCancelledError)
          ScaffoldMessenger.of(scaffoldState.currentContext)
              .showSnackBar(SnackBar(
            content: Text('${e.message}'),
          ));
        else
          ScaffoldMessenger.of(scaffoldState.currentContext)
              .showSnackBar(SnackBar(
            content: Text('Unk Error'),
          ));
      });
    } else {
      // user alreader login, state home page

    }
  }

  @override
  Widget build(BuildContext context, watch) {
    return Scaffold(
        key: scaffoldState,
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/my_bg.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                  padding: const EdgeInsets.all(16),
                  width: MediaQuery.of(context).size.width,
                  child: FutureBuilder(
                    future: checkLoginState(context, false),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting)
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      else {
                        var userState = snapshot.data as LOGIN_STATE;
                        if (userState == LOGIN_STATE.LOGGED) {
                          return Container();
                        } else {
                          return ElevatedButton.icon(
                            onPressed: () => processLogin(context),
                            icon: Icon(Icons.phone, color: Colors.white),
                            label: Text(
                              "LOGIN WITH PHONE",
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.black)),
                          );
                        }
                      }
                    },
                  ))
            ],
          ),
        ));
  }

  Future<LOGIN_STATE> checkLoginState(BuildContext context, bool fromLogin) async {
    await Future.delayed(Duration(seconds: fromLogin == true ? 0 : 3)).then((value) {
      FirebaseAuth.instance.currentUser.getIdToken().then((token) {
        //If get token, we pritn it
        print("$token");
        context.read(userToken).state = token;
        //And because user already login,
        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
      });
    });
    return FirebaseAuth.instance.currentUser != null
        ? LOGIN_STATE.LOGGED
        : LOGIN_STATE.NOT_LOGIN;
  }
}
