import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feed_your_pet/Styles/Styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:feed_your_pet/main.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  String uid = "";

  changePassword(String oldPassword, String newPassword) async {
    bool success = false;

    //Create an instance of the current user.
    var user = await FirebaseAuth.instance.currentUser!;
    showDialog(context: context, barrierDismissible: false,builder: (context) => Center(child: CircularProgressIndicator(),));
    //Must re-authenticate user before updating the password. Otherwise it may fail or user get signed out.
    if (user != null) {
      uid = user.uid;
      print(uid);
    }

    final cred = await EmailAuthProvider.credential(email: user.email!, password: oldPassword);
    await user.reauthenticateWithCredential(cred).then((value) async {
      await user.updatePassword(newPassword).then((_) async {
        success = true;
        FirebaseFirestore.instance
            .collection('Users')
            .doc(uid).update({"Password": newPassword});
        print("working");
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Your Password Is Updated')));
        print("working");
        navigatorKey.currentState!.popUntil((route) => route.isFirst);

        await Future.delayed(Duration(seconds: 1));
      }).catchError((e) async {
        print(e);
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('No user Found with this Email')));
        await Future.delayed(Duration(seconds: 1));
        Navigator.of(context).pop();
      });
    }).catchError((e) async {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())));
      await Future.delayed(Duration(seconds: 1));
      Navigator.of(context).pop();
      print(e);
    });

    return success;
  }

  TextEditingController newPassword = TextEditingController();
  TextEditingController oldPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Styles.defaultLimeGreenColor,
        body: Column(
          children: [
            Container(
              height: size.height*0.3,
              color: Styles.defaultLimeGreenColor,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(30) ,topRight: Radius.circular(30)),
                  color: Styles.defaultWhiteColor,),
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("Change Password",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 32,color: Styles.defaultLimeGreenColor,fontFamily: 'Andika'),),
                        Image.asset('assets/login & signup/ChangePassword.png',width: 150,height: 150,),
                        TextFormField(
                          controller: oldPassword,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: Icon(Icons.password_sharp,color: Styles.defaultLimeGreenColor,),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Styles.defaultLimeGreenColor,width: 2),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: Styles.defaultLimeGreenColor,width: 2),
                            ),
                            contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                            labelText: "Current Password",
                            labelStyle: TextStyle(fontWeight: FontWeight.bold, color: Styles.defaultLimeGreenColor,fontFamily: 'Andika'),
                            hintText: "Enter Current Password",
                            hintStyle: TextStyle(fontWeight: FontWeight.bold, color: Styles.defaultLimeGreenColor,fontFamily: 'Andika'),
                          ),
                          validator: (value){
                            if(value == null || value.isEmpty){
                              return "Password. Can\'t Be Empty";
                            }else if(value.length < 8) {
                              return "Password Length Must Be 8 or More.";
                            }
                          },
                        ),
                        SizedBox(height: 10,),
                        TextFormField(
                          controller: newPassword,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: Icon(Icons.password_sharp,color: Styles.defaultLimeGreenColor,),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color:Styles.defaultLimeGreenColor,width: 2),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: Styles.defaultLimeGreenColor,width: 2),
                            ),
                            contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                            labelText: "New Password",
                            labelStyle: TextStyle(fontWeight: FontWeight.bold, color: Styles.defaultLimeGreenColor,fontFamily: 'Andika'),
                            hintText: "Enter New Password",
                            hintStyle: TextStyle(fontWeight: FontWeight.bold, color: Styles.defaultLimeGreenColor,fontFamily: 'Andika'),
                          ),
                          validator: (value){
                            if(value == null || value.isEmpty){
                              return "Password. Can\'t Be Empty";
                            }else if(value.length < 8) {
                              return "Password Length Must Be 8 or More.";
                            }
                          },
                        ),
                        SizedBox(height: 10,),
                        GestureDetector(
                          onTap: (){
                            changePassword(oldPassword.text, newPassword.text);
                          },
                          child: SizedBox(
                            width: double.infinity,
                            child: Container(padding: EdgeInsets.all(10),decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Styles.defaultLimeGreenColor,
                            ),
                                child: Center(child: Text('Update',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Styles.defaultWhiteColor,fontFamily: 'Andika')))),
                          ),),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        // body: GestureDetector(
        //   onTap: () {
        //     showDialog(
        //         context: context,
        //         builder: (BuildContext context) {
        //           return AlertDialog(
        //             // title: Text(title),
        //             content: Column(
        //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //               mainAxisSize: MainAxisSize.min,
        //               children: [
        //                 Text("Change Password",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 32,color: Colors.deepPurple),),
        //                 Image.asset('ChangePassword.png',width: 200,height: 200,),
        //                 TextFormField(
        //                   controller: oldPassword,
        //                   decoration: InputDecoration(
        //                     filled: true,
        //                     fillColor: Colors.white,
        //                     prefixIcon: Icon(Icons.password_sharp,color: Colors.deepPurple,),
        //                     border: OutlineInputBorder(
        //                       borderRadius: BorderRadius.circular(10),
        //                       borderSide: BorderSide(color: Colors.deepPurple,width: 2),
        //                     ),
        //                     focusedBorder: OutlineInputBorder(
        //                       borderRadius: BorderRadius.circular(15),
        //                       borderSide: BorderSide(color: Colors.deepPurple.shade500,width: 2),
        //                     ),
        //                     contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
        //                     labelText: "Current Password",
        //                     labelStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.deepPurple.shade500),
        //                     hintText: "Enter Current Password",
        //                     hintStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.deepPurple.shade500),
        //                   ),
        //                   validator: (value){
        //                     if(value == null || value.isEmpty){
        //                       return "Password. Can\'t Be Empty";
        //                     }else if(value.length < 8) {
        //                       return "Password Length Must Be 8 or More.";
        //                     }
        //                   },
        //                 ),
        //                 SizedBox(height: 10,),
        //                 TextFormField(
        //                   controller: newPassword,
        //                   decoration: InputDecoration(
        //                     filled: true,
        //                     fillColor: Colors.white,
        //                     prefixIcon: Icon(Icons.password_sharp,color: Colors.deepPurple,),
        //                     border: OutlineInputBorder(
        //                       borderRadius: BorderRadius.circular(10),
        //                       borderSide: BorderSide(color: Colors.deepPurple,width: 2),
        //                     ),
        //                     focusedBorder: OutlineInputBorder(
        //                       borderRadius: BorderRadius.circular(15),
        //                       borderSide: BorderSide(color: Colors.deepPurple.shade500,width: 2),
        //                     ),
        //                     contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
        //                     labelText: "New Password",
        //                     labelStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.deepPurple.shade500),
        //                     hintText: "Enter New Password",
        //                     hintStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.deepPurple.shade500),
        //                   ),
        //                   validator: (value){
        //                     if(value == null || value.isEmpty){
        //                       return "Password. Can\'t Be Empty";
        //                     }else if(value.length < 8) {
        //                       return "Password Length Must Be 8 or More.";
        //                     }
        //                   },
        //                 ),
        //                 SizedBox(height: 10,),
        //                 GestureDetector(
        //                   onTap: (){
        //                     changePassword(oldPassword.text, newPassword.text);
        //                   },
        //                   child: Container(padding: EdgeInsets.all(10),decoration: BoxDecoration(
        //                     borderRadius: BorderRadius.circular(10),
        //                     color: Colors.deepPurple,
        //                   ),
        //                       child: Text('Update',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.white))),),
        //               ],
        //             ),
        //             actions: [
        //               GestureDetector(
        //                   onTap: () {
        //                     Navigator.of(context).pop();
        //                   },
        //                   child: Text("Close")),
        //             ],
        //           );
        //         });
        //   },
        //   child: Padding(
        //     padding: const EdgeInsets.symmetric(vertical: 8.0),
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //       children: [
        //         Text(
        //           'Change Password',
        //           style: TextStyle(
        //             fontSize: 18,
        //             fontWeight: FontWeight.w500,
        //             color: Colors.grey[600],
        //           ),
        //         ),
        //         Icon(
        //           Icons.arrow_forward_ios,
        //           color: Colors.grey,
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
      ),
    );;
  }
}
