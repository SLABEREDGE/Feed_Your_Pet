import 'package:feed_your_pet/Login%20&%20Signup/ChangePassword.dart';
import 'package:feed_your_pet/Login%20&%20Signup/firebaseFuctions.dart';
import 'package:feed_your_pet/Pages/profilePage.dart';
import 'package:feed_your_pet/Styles/Styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Login & Signup/login.dart';
import '../Services/UserService.dart';


class settingsPage extends StatefulWidget {
  const settingsPage({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  State<settingsPage> createState() => _settingsPageState();
}

class _settingsPageState extends State<settingsPage> {
  UserService userService = UserService();
  Map<String,String> userInfo = {} ;
  String? uid;
  void initState() {
    super.initState();
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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Styles.defaultWhiteColor,
      appBar: AppBar(
        title: Text("Settings",style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Andika',color: Styles.defaultWhiteColor),),
        centerTitle: true,
        backgroundColor: Styles.defaultGreenColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                GestureDetector(
                  onTap: () async {
                    var userId = await userService.getCurrentUserId();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => profilePage(id: userId)));
                  },
                  child: SizedBox(
                    width: double.infinity,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Styles.defaultLimeGreenColor,
                        borderRadius: BorderRadius.circular(20)
                      ),
                      height: size.height*0.2,
                      child:
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(radius: 50,backgroundColor: Styles.defaultWhiteColor,),
                            Spacer(),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children:[
                                Text('Name : UserName',style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Andika',fontSize: 16,color: Styles.defaultWhiteColor)),
                                Text('Email : username@gmail.com',style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Andika',fontSize: 16,color: Styles.defaultWhiteColor),),
                              ]
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Divider(color: Colors.transparent,),
                GestureDetector(
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChangePassword()));
                  },
                  child: SizedBox(
                    width: double.infinity,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Styles.defaultLimeGreenColor,
                          borderRadius: BorderRadius.circular(20)
                      ),
                      height: 60,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.password,color: Styles.defaultWhiteColor,),
                            SizedBox(width: 10,),
                            Text(
                              'Change Password',style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Andika',fontSize: 20,color: Styles.defaultWhiteColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Divider(color: Colors.transparent,),
                Container(
                  decoration: BoxDecoration(
                      color: Styles.defaultLimeGreenColor,
                      borderRadius: BorderRadius.circular(20)
                  ),
                  height: 60,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.people,color: Styles.defaultWhiteColor,),
                        SizedBox(width: 10,),
                        Text(
                          'About Us',style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Andhika',fontSize: 20,color: Styles.defaultWhiteColor),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(
              width: double.infinity,
              child: GestureDetector(
                onTap: () async {
                  await FirebaseServices().googleSignOut();
                  await FirebaseAuth.instance.signOut();
                  setState(() {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => LoginPage()),
                            (route) => false);
                  });
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(color: Colors.red,
                  borderRadius: BorderRadius.circular(20)),
                  child: Center(
                    child: Text(
                      "Logout",style: TextStyle(fontFamily: 'Andika',fontWeight: FontWeight.bold,color: Styles.defaultWhiteColor,fontSize: 24),
                    ),
                  ),
                ),
              ),
            ),
            // Divider(color: Colors.transparent,),
          ],
        ),
      ),
    );
  }
}
