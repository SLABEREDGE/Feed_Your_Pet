import 'package:feed_your_pet/Pages/profilePage.dart';
import 'package:feed_your_pet/Pages/specificPetPage.dart';
import 'package:feed_your_pet/Models/trendingPets.dart';
import 'package:feed_your_pet/Styles/Styles.dart';
import 'package:flutter/material.dart';

import '../Services/UserService.dart';



class HomePage extends StatefulWidget {
  final String userFullName;
  final String userEmail;
  final String userProfileImage;
  final String id;
  const HomePage({super.key, required this.userEmail, required this.userFullName, required this.userProfileImage, required this.id});



  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String,String> userInfo = {} ;
  String? uid;

  UserService userService = UserService();

  @override
  void initState() {
    super.initState();
    var userId = userService.getCurrentUserId();
    if (widget.id.length > 0) {
      print(widget.id);
      print("user id" + uid!);
      userService.getUserById(widget.id).then((snapshot) {
        // userProfileImage.text = snapshot.get("ProfileImage");
        userProfileImage = snapshot.get("ProfileImage");
        // userFullName.text = snapshot.get("FullName");
        userFullName = snapshot.get("FullName");
        // userEmail.text = snapshot.get("Email");
        userEmail = snapshot.get("Email");
        // userPhoneNo.text = snapshot.get("PhoneNo");
        // userAddress.text = snapshot.get("Address");
        // userGender.text = snapshot.get("Gender");
        print(userProfileImage);
        print(userFullName);
        print(userEmail);
      });
    }
  }

  String userFullName = "";
  String userProfileImage = "";
  String userEmail = "";

  @override
  Widget build(BuildContext context) {
    var userId = userService.getCurrentUserId();
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Styles.defaultWhiteColor.withOpacity(0.9),
        appBar: AppBar(
          backgroundColor: Styles.defaultGreenColor,
          elevation: 0,
          title: Text(
            'Feed Your Pet',style: TextStyle(color: Styles.defaultWhiteColor,fontFamily: 'Andika',fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child:
                GestureDetector(
                  onTap: () async {
                    var userId = await userService.getCurrentUserId();
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => profilePage(id: userId)));
                  },
                  child: CircleAvatar(
                    backgroundColor: Styles.defaultWhiteColor,
                    child: Icon(Icons.person,color: Styles.defaultLimeGreenColor,),
                  ),
                ),
            )
          ],
        ),
        // drawer: Drawer(
        // ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Container(
                  height: size.height * 0.3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Styles.defaultLimeGreenColor,
                    boxShadow: [
                      BoxShadow(
                        color: Styles.defaultBlackColor.withOpacity(0.2),
                        offset: const Offset(
                          3.0,
                          3.0,
                        ),
                        blurRadius: 5.0,
                        spreadRadius: 1.0,
                      ), //BoxShadow
                      BoxShadow(
                        color: Styles.defaultWhiteColor,
                        offset: const Offset(0.0, 0.0),
                        blurRadius: 0.0,
                        spreadRadius: 0.0,
                      ), //BoxShadow
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: size.width/2,
                          child: Padding(
                        padding: const EdgeInsets.only(left: 20,top: 10,bottom: 10),
                        child: Text('Play with you dream pet and enjoy !!',style: TextStyle(fontSize:24,fontWeight: FontWeight.bold,color: Styles.defaultWhiteColor,fontFamily: 'Andika')),
                      )),
                      Padding(
                        padding: const EdgeInsets.only(right: 20,top: 10,bottom: 10),
                        child: Image.asset("assets/pets/dogs/GoldenRetriever3.png",height: 160,),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Pet\'s Category',style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Styles.defaultBlackColor,fontFamily: 'Andika'),),
              ),
              SizedBox(
                height: size.height * 0.30,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: trending.length,
                  itemBuilder: (context,index){
                    return InkWell(onTap: (){
                      if (trending[index].name== "Dog")
                        {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => specificPetPage(petsType: "Dog",)));
                        } else if(trending[index].name== "Cat"){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => specificPetPage(petsType: 'Cat',)));
                      }else if (trending[index].name== "Rabbit"){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => specificPetPage(petsType: 'Rabbit',)));
                      } else if (trending[index].name== "Tortoise"){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => specificPetPage(petsType: 'Tortoise',)));
                      }else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Something Went Wrong')));
                      }
                    },child: petCards(index));
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8,right: 8,bottom: 8,top: 8),
                child: Text('Newly Added',style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Styles.defaultBlackColor,fontFamily: 'Andika',),),
              ),
              SizedBox(
                height: size.height * 0.3,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: trending.length,
                  itemBuilder: (context,index){
                    return petCards(index);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }
  Widget petCards(int index) => Padding(
    padding: const EdgeInsets.only(left: 8.0,right: 8),
    child: Container(
      decoration: BoxDecoration(color: Styles.defaultWhiteColor.withOpacity(0.8),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Styles.defaultLimeGreenColor,width: 2),
        boxShadow: [
          BoxShadow(
            color: Styles.defaultBlackColor.withOpacity(0.2),
            offset: const Offset(
              3.0,
              3.0,
            ),
            blurRadius: 5.0,
            spreadRadius: 1.0,
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
        padding: const EdgeInsets.only(left: 8,right: 8,top: 8,bottom: 8),
        child: Column(
          children: [
            Container(
              height: 170,
              width: 170,
              child: Image.asset(trending[index].image,fit: BoxFit.fill,),
              decoration: BoxDecoration(color: Styles.defaultWhiteColor.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(15),
                // border: Border.all(color: Styles.defaultLimeGreenColor,width: 2),
                boxShadow: [
                  BoxShadow(
                    color: Styles.defaultBlackColor.withOpacity(0.2),
                    offset: const Offset(
                      3.0,
                      3.0,
                    ),
                    blurRadius: 5.0,
                    spreadRadius: 1.0,
                  ), //BoxShadow
                  BoxShadow(
                    color: Styles.defaultWhiteColor,
                    offset: const Offset(0.0, 0.0),
                    blurRadius: 0.0,
                    spreadRadius: 0.0,
                  ), //BoxShadow
                ],
              ),
            ),
            SizedBox(height: 5,),
            Text(trending[index].name,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Styles.defaultBlackColor,fontFamily: 'Andika'),),
          ],
        ),
      ),
    ),
  );
}
