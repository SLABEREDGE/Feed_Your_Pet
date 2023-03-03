import 'dart:io';
import 'package:feed_your_pet/Models/trendingPets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../Styles/Styles.dart';
import 'Tips.dart';
class petFeedPage extends StatefulWidget {
  final Pets pets;
  const petFeedPage({Key? key, required this.pets}) : super(key: key);

  @override
  State<petFeedPage> createState() => _petFeedPageState();
}

class _petFeedPageState extends State<petFeedPage> {

  File? file;
  Uint8List webImage = Uint8List(8);


  Future<void> _pickImage() async {
    if (!kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var selected = File(image.path);
        setState(() {
          file = selected;
        });
      } else {
        print('No image has been picked');
      }
    } else if (kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var f = await image.readAsBytes();
        setState(() {
          webImage = f;
          file = File('a');
        });
      } else {
        print('No image has been picked');
      }
    } else {
      print('Something went wrong');
    }
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Styles.defaultLimeGreenColor,
        appBar: AppBar(
          backgroundColor: Styles.defaultLimeGreenColor,
          elevation: 0,
        ),
        body: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: Container(
                color: Styles.defaultLimeGreenColor,
                height: size.height* 0.35,
                child: Column(
                  children: [
                    Image.asset(widget.pets.image,
                      fit: BoxFit.fitHeight,height: size.height*0.3,),
                    Text(widget.pets.type,style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,fontFamily: 'Andika'),),
                  ],
                ),
              ),
            ),
            Expanded(
              child: SizedBox(
                width: size.width,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(30) ,topRight: Radius.circular(30)),
                      color: Styles.defaultWhiteColor,
                    boxShadow: [
                      BoxShadow(
                        color: Styles.defaultBlackColor.withOpacity(0.2),
                        offset: const Offset(
                          -3.0,
                          -3.0,
                        ),
                        blurRadius: 10.0,
                        spreadRadius: 4.0,
                      ), //BoxShadow
                      BoxShadow(
                        color: Styles.defaultWhiteColor,
                        offset: const Offset(0.0, 0.0),
                        blurRadius: 0.0,
                        spreadRadius: 0.0,
                      ), //BoxShadow
                    ],
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                         ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxHeight: 310,
                                  maxWidth: 282,
                                ),
                                child: Image.asset("assets/Food/plate2.png",)),
                            file != null ? Container(
                              height: 185,
                              width: 185,
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                color: Colors.yellow,
                                shape: BoxShape.circle
                              ),
                              child: Image.file(file!, fit: BoxFit.fill,),)
                                : CircleAvatar(backgroundColor: Colors.transparent, radius: 90,)
                          ],
                        ),
                        file == null ? Text("Click Your Meal",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,fontFamily: 'Andika'),) : Text("Will you eat this ?",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,fontFamily: 'Andika'),),
                        file == null ? GestureDetector(
                          onTap: () {
                            _pickImage();
                          },
                          child: Padding(padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(radius: 30,child: Icon(Icons.photo_camera,size: 40,)))) :
                        GestureDetector(onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => TipsPage(tips: tips, pets: widget.pets,)));
                            },child: CircleAvatar(radius: 30,child: Icon(Icons.check,size: 40,))),
                      ],
                    ),
                  ),
                ),
              ),)
          ],
        ),
      ),
    );
  }
}
