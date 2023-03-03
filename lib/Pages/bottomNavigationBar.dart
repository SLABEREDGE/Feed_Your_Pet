import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:feed_your_pet/Pages/petsPage.dart';
import 'package:feed_your_pet/Pages/settingsPage.dart';
import 'package:flutter/material.dart';
import '../Services/UserService.dart';
import '../Styles/Styles.dart';
import 'HomePage.dart';


class bottomNavigationBar extends StatefulWidget {
  const bottomNavigationBar({Key? key, required this.userFullName, required this.userEmail, required this.userProfileImage, required this.id}) : super(key: key);
  final String userFullName;
  final String userEmail;
  final String userProfileImage;
  final String id;

  @override
  State<bottomNavigationBar> createState() => _bottomNavigationBarState();
}

class _bottomNavigationBarState extends State<bottomNavigationBar> {
  UserService userService = UserService();
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  int index = 0;
  final items = const [
    Icon(Icons.home_sharp, size: 30,color: Colors.white,),
    Icon(Icons.pets, size: 30,color: Colors.white),
    Icon(Icons.settings, size: 30,color: Colors.white),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getSelectedWidget(index: index),
      bottomNavigationBar: CurvedNavigationBar(
        height: 60.0,
        items: <Widget>[
          Icon(Icons.home_sharp, size: 30,color: Styles.defaultWhiteColor,),
          Icon(Icons.pets, size: 30,color: Styles.defaultWhiteColor),
          Icon(Icons.settings, size: 30,color: Styles.defaultWhiteColor),
        ],
        index: index,
        onTap: (selctedIndex){
          setState(() {
            index = selctedIndex;
          });
        },
        color: Styles.defaultGreenColor,
        buttonBackgroundColor: Styles.defaultGreenColor,
        backgroundColor: Styles.defaultLimeGreenColor,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 300),
        // animationCurve: ,
      ),
    );
  }
  Widget getSelectedWidget({required int index}){
    Widget widget;
    switch(index){
      case 0:
        widget = const HomePage(userEmail: '', userFullName: '', userProfileImage: '', id: '',);
        break;
      case 1:
        widget = const petsPage();
        break;
      case 2:
        widget = const settingsPage(id: '');
        break;
      default :
        widget = const HomePage(userEmail: '', userFullName: '', userProfileImage: '', id: '',);
        break;
    }
    return widget;
  }
}
