import 'package:feed_your_pet/Pages/petFeedPage.dart';
import 'package:feed_your_pet/Models/trendingPets.dart';
import 'package:five_pointed_star/five_pointed_star.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../Styles/Styles.dart';

class petDetailPage extends StatefulWidget {
  const petDetailPage({Key? key, required this.pets}) : super(key: key);
  final Pets pets;


  @override
  State<petDetailPage> createState() => _petDetailPageState();
}

class _petDetailPageState extends State<petDetailPage> {
  bool ispressed = false;
  var mycount ;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // backgroundColor: Styles.defaultGreenColor,
      backgroundColor: Styles.defaultWhiteColor,
      appBar: AppBar(
        backgroundColor: Styles.defaultGreenColor,
        // backgroundColor: Styles.defaultWhiteColor,
        // iconTheme: IconThemeData(color: Styles.defaultGreenColor),
        iconTheme: IconThemeData(color: Styles.defaultWhiteColor),
        title: Text(widget.pets.type,style: TextStyle(color: Styles.defaultWhiteColor,fontFamily: 'Andika',fontWeight: FontWeight.bold),),
        // title: Text(pets.type,style: TextStyle(color: Styles.defaultGreenColor),),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Stack(
            alignment: Alignment.topRight,
            children : [
              SizedBox(
                width: double.infinity,
                child: Container(
                  height: size.height*0.30,
                  child: Image.asset(widget.pets.image,height: 200,),
                  decoration: BoxDecoration(color: Styles.defaultLightGreyColor.withOpacity(0.2),
                  // decoration: BoxDecoration(color: Styles.defaultGreenColor,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    GestureDetector(child: ispressed ? Icon(CupertinoIcons.heart_fill,color: Styles.defaultRedColor ,size: 30,) : Icon(CupertinoIcons.heart,color: Styles.defaultGreenColor,size: 30,) , onTap: (){
                        setState(() //<--whenever icon is pressed, force redraw the widget
                        {
                          ispressed = true;
                        });
                    },),
                    SizedBox(height: 10,),
                    GestureDetector(child: Icon(CupertinoIcons.play_circle,color: Styles.defaultGreenColor,size: 30,),onTap: (){
                      setState(() //<--whenever icon is pressed, force redraw the widget
                      {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => petFeedPage(pets: widget.pets,)));
                      });
                    }),
                  ],
                ),
                // child: Icon(CupertinoIcons.heart,color: Styles.defaultWhiteColor,),
              ),
            ],
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: Styles.defaultLimeGreenColor.withOpacity(1),
                  // color: Styles.defaultWhiteColor,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(30) ,topRight: Radius.circular(30)),
                boxShadow: [
                  BoxShadow(
                    color: Styles.defaultBlackColor.withOpacity(0.3),
                    offset: const Offset(
                      -3.0,
                      -3.0,
                    ),
                    blurRadius: 6.0,
                    spreadRadius: 0.8,
                  ), //BoxShadow
                  BoxShadow(
                    color: Styles.defaultWhiteColor,
                    offset: const Offset(0.0, 0.0),
                    blurRadius: 0.0,
                    spreadRadius: 0.0,
                  ), //BoxShadow
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text("Difficulty : ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Styles.defaultWhiteColor,fontFamily: 'Andika'),),
                              FivePointedStar(
                                defaultSelectedCount: widget.pets.difficulty.length,
                                selectedColor: Styles.defaultYellowColor,
                                onChange: null,
                              ),
                            ],
                          ),
                          Divider(),
                          RichText(
                            text: TextSpan(
                                text: 'Description : ',
                                style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Styles.defaultWhiteColor,fontFamily: 'Andika'),
                                children: [
                                  TextSpan(text: widget.pets.description,
                                      style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Styles.defaultBlackColor,fontFamily: 'Andika')),
                                ]
                            ),
                          ),
                          Divider(),
                          RichText(
                            text: TextSpan(
                                text: 'Color : ',
                                style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Styles.defaultWhiteColor,fontFamily: 'Andika'),
                                children: [
                                  TextSpan(text: widget.pets.color,
                                      style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Styles.defaultBlackColor,fontFamily: 'Andika')),
                                ]
                            ),
                          ),
                          Divider(),
                          RichText(
                            text: TextSpan(
                                text: 'Height : ',
                                style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Styles.defaultWhiteColor,fontFamily: 'Andika'),
                                children: [
                                  TextSpan(text: widget.pets.height,
                                      style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Styles.defaultBlackColor,fontFamily: 'Andika')),
                                ]
                            ),
                          ),
                          Divider(),
                          RichText(
                            text: TextSpan(
                                text: 'Weight : ',
                                style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Styles.defaultWhiteColor,fontFamily: 'Andika'),
                                children: [
                                  TextSpan(text: widget.pets.weight,
                                      style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Styles.defaultBlackColor,fontFamily: 'Andika')),
                                ]
                            ),
                          ),
                          Divider(),
                          RichText(
                            text: TextSpan(
                                text: 'Temperament : ',
                                style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Styles.defaultWhiteColor,fontFamily: 'Andika'),
                                children: [
                                  TextSpan(text: widget.pets.temperament,
                                      style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Styles.defaultBlackColor,fontFamily: 'Andika')),
                                ]
                            ),
                          ),
                          Divider(),
                          RichText(
                            text: TextSpan(
                                text: 'Origin : ',
                                style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Styles.defaultWhiteColor,fontFamily: 'Andika'),
                                children: [
                                  TextSpan(text: widget.pets.origin,
                                      style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Styles.defaultBlackColor,fontFamily: 'Andika')),
                                ]
                            ),
                          ),
                          Divider(),
                          RichText(
                            text: TextSpan(
                                text: 'Life Expectancy : ',
                                style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Styles.defaultWhiteColor,fontFamily: 'Andika'),
                                children: [
                                  TextSpan(text: widget.pets.life,
                                      style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Styles.defaultBlackColor,fontFamily: 'Andika')),
                                ]
                            ),
                          ),
                        ],
                      ),
                      Divider(),
                      GestureDetector(onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => petFeedPage(pets: widget.pets,)));
                      },child: SizedBox(
                        width: double.infinity,
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Styles.defaultWhiteColor,
                          ),
                            child: Center(child: Text("Feed Me",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24,fontFamily: 'Andika'),))),
                      )),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
