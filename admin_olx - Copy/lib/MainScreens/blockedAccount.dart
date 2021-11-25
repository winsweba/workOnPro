import 'package:admin_olx/MainScreens/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class BlockedAccountsScreen extends StatefulWidget {
  @override
  _BlockedAccountsScreenState createState() => _BlockedAccountsScreenState();
}


class _BlockedAccountsScreenState extends State<BlockedAccountsScreen>
{
  QuerySnapshot users;

  Future<bool> showDialogForBlockingAccount(selectedDoc) async
  {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context)
        {
          return AlertDialog(
            title: Text(
              "Block Account",
              style: TextStyle(fontSize: 24, letterSpacing: 2.0, fontWeight: FontWeight.bold),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Do you want to block this account ?"),
              ],
            ),
            actions: [
              ElevatedButton(
                child: Text(
                  "No",
                ),
                onPressed: ()
                {
                  Navigator.pop(context);
                },
              ),
              ElevatedButton(
                child: Text(
                  "Yes",
                ),
                onPressed: ()
                {
                  Map<String, dynamic> userData =
                  {
                    "status": "not approved",
                  };
                  FirebaseFirestore.instance.collection("users")
                      .doc(selectedDoc)
                      .update(userData).then((value)
                  {
                    print("Account Blocked successfully.");

                    Route newRoute = MaterialPageRoute(builder: (_) => HomeScreen());
                    Navigator.pushReplacement(context, newRoute);
                  });
                },
              ),
            ],
          );
        }
    );
  }


  @override
  void initState() {
    super.initState();

    FirebaseFirestore.instance.collection("users")
        .where("status", isEqualTo: "approved")
        .get().then((results)
    {
      setState(() {
        users = results;
      });
    });
  }

  @override
  Widget build(BuildContext context)
  {
    double _screenWidth = MediaQuery
        .of(context)
        .size
        .width,
        _screenHeight = MediaQuery
            .of(context)
            .size
            .height;

    Widget showActivatedAccountList()
    {
      if(users != null)
      {
        return ListView.builder(
          itemCount: users.docs.length,
          padding: EdgeInsets.all(8.0),
          itemBuilder: (context, i)
          {
            return Card(
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: [

                  //listtile
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: ListTile(
                      leading: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(users.docs[i].get("imgPro")),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      title: Text(users.docs[i].get("userName")),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.phone_android,),
                          SizedBox(width: 20,),
                          Text(
                            users.docs[i].get("userNumber"),
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 2.0),
                          ),
                        ],
                      ),
                    ),
                  ),

                  //button
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: ElevatedButton.icon(
                      icon: Icon(Icons.person_pin_sharp, color: Colors.white,),
                      label: Text(
                        "Block this Account".toUpperCase(),
                        style: TextStyle(fontSize: 14.0, color: Colors.white, fontFamily: "Varela", letterSpacing: 3.0),
                      ),
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(EdgeInsets.all(20)),
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      ),
                      onPressed: ()
                      {
                        showDialogForBlockingAccount(users.docs[i].id);
                      },
                    ),
                  ),

                  SizedBox(height: 20.0,),

                ],
              ),
            );
          },
        );
      }
      else
      {
        return Center(
          child: Text(
            "Loading...",
          ),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: ()
          {
            Route newRoute = MaterialPageRoute(builder: (_) => HomeScreen());
            Navigator.pushReplacement(context, newRoute);
          },
        ),
        actions:
        [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: IconButton(
              icon: Icon(Icons.refresh, color: Colors.white),
              onPressed: ()
              {
                Route newRoute = MaterialPageRoute(builder: (_) => BlockedAccountsScreen());
                Navigator.pushReplacement(context, newRoute);
              },
            ),
          ),
        ],
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors:
              [
                Colors.deepPurple,
                Colors.green,
              ],
              begin: FractionalOffset(0.0, 0.0),
              end: FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp,
            ),
          ),
        ),
        title: Text(("All Active Accounts"),),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          width: _screenWidth,
          child: showActivatedAccountList(),
        ),
      ),
    );
  }
}
