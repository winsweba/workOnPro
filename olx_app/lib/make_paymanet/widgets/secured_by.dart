import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:olx_app/make_paymanet/utils/ui_color.dart';

class SecuredByFooter extends StatelessWidget {
  const SecuredByFooter({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        
        // SizedBox(
        //   width: 5,
        // ),

        SizedBox(
          width: 5,
        ),

        Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
          // Icons.lock,
          FontAwesome.lock,
          size: 18,
          color: UIColors.primaryColor,
        ),
              //icon
              Text(
                "Secured by",
                style: TextStyle(
                  color: UIColors.primaryColor,
                ),
              ),
              Image(
                image: AssetImage("assets/images/paystacklogo.png",),
                height: 40,
                width: 50,
              ),
            ],
          ),
        ),

        SizedBox(
          width: 5,
        ),
        Image(
          image: AssetImage(
            "assets/images/momo.jpg",
          ),
          height: 400,
          width: 500,
        ),
      ],
    );
  }
}
