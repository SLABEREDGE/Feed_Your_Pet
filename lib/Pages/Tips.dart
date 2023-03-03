import 'dart:ui';
import 'package:feed_your_pet/Models/trendingPets.dart';
import 'package:feed_your_pet/Styles/Styles.dart';
import 'package:feed_your_pet/Pages/petDetailPage.dart';
import 'package:flutter/material.dart';

import 'Home.dart';

class TipsPage extends StatefulWidget {
  const TipsPage({Key? key, required this.tips, required this.pets}) : super(key: key);
  final List<Tips> tips;
  final Pets pets;

  @override
  State<TipsPage> createState() => _TipsPageState();
}

class _TipsPageState extends State<TipsPage> {
  @override
  Widget build(BuildContext context) {
    var randomTips = (tips.toList()..shuffle()).first;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Styles.defaultGreenColor,
        body: Stack(
          alignment: Alignment.topRight,
          children: [
            GestureDetector(onTap: (){
              setState(() {
                final route = MaterialPageRoute(builder: (context) => petDetailPage(pets: widget.pets));
                Navigator.of(context).popUntil((route) => route.isFirst);
                // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => petDetailPage(pets: widget.pets,)) as RoutePredicate);
              });
            },child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.close,size: 30,color: Styles.defaultWhiteColor,),
            )),
            Center(child: Text(randomTips.tips,textAlign: TextAlign.center,style: TextStyle(color: Styles.defaultWhiteColor,fontFamily: 'Andika',fontWeight: FontWeight.bold,fontSize: 36),),
          ),
          ],
        ),
      ),
    );
  }
}
