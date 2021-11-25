import 'package:admin_olx/MainScreens/home.dart';
import 'package:flutter/material.dart';
import 'package:image_slider/image_slider.dart';



class AdsDescriptionScreen extends StatefulWidget
{
  final String title, urlImage1, urlImage2, urlImage3, urlImage4, urlImage5;
  final String itemColor, userNumber, description, address;

  AdsDescriptionScreen({
    this.title,
    this.itemColor,
    this.urlImage1,
    this.urlImage2,
    this.urlImage3,
    this.urlImage4,
    this.urlImage5,
    this.userNumber,
    this.description,
    this.address,
});


  @override
  _AdsDescriptionScreenState createState() => _AdsDescriptionScreenState();
}


class _AdsDescriptionScreenState extends State<AdsDescriptionScreen> with SingleTickerProviderStateMixin
{
  TabController tabController;
  static List<String> links = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getLinks();
    tabController = TabController(length: 5, vsync: this);
  }

  getLinks()
  {
    links.add(widget.urlImage1);
    links.add(widget.urlImage2);
    links.add(widget.urlImage3);
    links.add(widget.urlImage4);
    links.add(widget.urlImage5);
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

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, style: TextStyle(letterSpacing: 2.0),),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: ()
          {
            Route newRoute = MaterialPageRoute(builder: (_) => HomeScreen());
            Navigator.pushReplacement(context, newRoute);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: _screenWidth * .5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 20.0, left: 6.0, right: 12.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.location_pin, color: Colors.deepPurple),
                      SizedBox(width: 4.0,),
                      Expanded(
                        child: Text(
                          widget.address,
                          textAlign: TextAlign.justify,
                          overflow: TextOverflow.fade,
                          style: TextStyle(letterSpacing: 2.0),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.0,),
                Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 2),
                  ),
                  child: ImageSlider(
                    showTabIndicator: false,
                    tabIndicatorColor: Colors.lightBlue,
                    tabIndicatorSelectedColor: Color.fromARGB(255, 0, 0, 255),
                    tabIndicatorHeight: 16,
                    tabIndicatorSize: 16,
                    tabController: tabController,
                    curve: Curves.fastOutSlowIn,
                    width: _screenWidth * .5,
                    height: _screenHeight * .5,
                    autoSlide: true,
                    duration: new Duration(seconds: 5),
                    allowManualSlide: true,
                    children: links.map((String link){
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          link,
                          width: _screenWidth,
                          height: 220,
                          fit: BoxFit.fill,
                        ),
                      );
                    }).toList(),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //index 0
                    tabController.index == 0
                    ? Container(
                      width: 0,
                      height: 0,
                    )
                    : ElevatedButton(
                      child: Text("Previous", style: TextStyle(color: Colors.white),),
                      onPressed: ()
                      {
                        tabController.animateTo(tabController.index - 1);
                        setState(() {

                        });
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.deepPurple,
                      ),
                    ),


                    //index 4
                    tabController.index == 4
                        ? Container(
                      width: 0,
                      height: 0,
                    )
                        : ElevatedButton(
                      onPressed: () {
                        tabController.animateTo(tabController.index + 1);
                        setState(() {});
                      },
                      child: Text("Next", style: TextStyle(color: Colors.white),),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.deepPurple,
                      ),
                    ),

                  ],
                ),
                SizedBox(height: 30,),
                Padding(
                  padding: EdgeInsets.only(left: 15.0, right: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //itemColor
                      Row(
                        children: [
                          Icon(Icons.brush_outlined),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Align(
                              child: Text(widget.itemColor),
                              alignment: Alignment.topLeft,
                            ),
                          ),
                        ],
                      ),
                      //userNumber
                      Row(
                        children: [
                          Icon(Icons.phone_android),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Align(
                              child: Text(widget.userNumber),
                              alignment: Alignment.topRight,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15,),
                //description
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  child: Text(
                    widget.description,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.6),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
