import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../Services/UserService.dart';
import '../Styles/Styles.dart';
import 'HomePage.dart';


class profilePage extends StatefulWidget {
  final String id;
  const profilePage( {required this.id});

  @override
  State<profilePage> createState() => _profilePageState();
}

class _profilePageState extends State<profilePage> {

  final _FormKey = GlobalKey<FormState>();

  Map<String,String> userInfo = {} ;

  UserService userService = UserService();

  File? file;
  // File? _pickedImage;
  Uint8List webImage = Uint8List(8);
  String profilePic = "";

  // chooseImage() async {
  //   XFile? xfile = await ImagePicker().pickImage(source: ImageSource.gallery);
  //   print("file ${xfile?.path}");
  //   file = File(xfile!.path);
  //   setState(() {});
  // }

  getUserProfilePic() async{
    var data = await userService.getUserById(widget.id);
    profilePic = data.get('ProfileImage');
    setState(() {

    });

  }

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

  updateProfile(BuildContext context) async {
    if (_FormKey.currentState!.validate()) {
      Map<String, dynamic> map = Map();
      if (file != null) {
        String url = await uploadImage();
        map['ProfileImage'] = url;
      }
      // map['name'] = _textEditingController.text;
      print("mapping");

      await FirebaseFirestore.instance
          .collection("Users")
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .update(map);
      print("run1");
      editUsersInfo();
      print("run2");
      saveUserDataPage(context);
      print("run3");
      Navigator.pop(context);
    }
  }

  Future<String> uploadImage() async {
    TaskSnapshot taskSnapshot = await FirebaseStorage.instance
        .ref()
        .child("profile")
        .child(
      // "${FirebaseAuth.instance.currentUser?.uid}_${basename(file!.path)}")
        "${FirebaseAuth.instance.currentUser?.uid}")
        .putFile(file!);

    return taskSnapshot.ref.getDownloadURL();

  }




  saveUserDataPage(BuildContext context) async {
    print("called 4");
    if (_FormKey.currentState!.validate()) {
      setState(() {
      });
      await Future.delayed(Duration(seconds: 1));
      await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage(userEmail: "", userFullName: "", userProfileImage: "", id: '',)),
      );
      setState(() {
        print("called 5");
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getUserProfilePic();
    if (widget.id.length > 0) {
      print(widget.id);
      userService.getUserById(widget.id).then((snapshot) {
        userProfileImage.text = snapshot.get("ProfileImage");
        userAbout.text = snapshot.get("About");
        userFullName.text = snapshot.get("FullName");
        userEmail.text = snapshot.get("Email");
        userPhoneNo.text = snapshot.get("PhoneNo");
        userAddress.text = snapshot.get("Address");
        userGender.text = snapshot.get("Gender");
        print(userProfileImage);
      });
    }
  }
  //
  editUsersInfo() async {
    print("called 1");
    var url = await uploadImage();
    if (_FormKey.currentState!.validate()) {
      userInfo = {

        'FullName': userFullName.text,
        'Email': userEmail.text,
        'PhoneNo': userPhoneNo.text,
        'About' : userAbout.text,
        'Gender' : userGender.text,
        'Address': userAddress.text,
        'ProfileImage': url,
        // 'ProfileImage': userProfileImage.text,
      };
      print(userProfileImage.text);
      await userService.EditUser(userInfo,widget.id);
      // updateProfile;
      // updateProfile(context);
      print("called 2");
      // saveUserDataPage(context);
      // saveUserDataPage;
      print("called 3");
    }
  }


  TextEditingController userEmail = TextEditingController();
  TextEditingController userFullName = TextEditingController();
  TextEditingController userProfileImage = TextEditingController();
  TextEditingController userPhoneNo = TextEditingController();
  TextEditingController userGender = TextEditingController();
  TextEditingController userAddress = TextEditingController();
  TextEditingController userAbout = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.all(30),
          color: Styles.defaultLimeGreenColor,
          height: MediaQuery.of(context).size.height,
          child:
          Form(
            key: _FormKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Icon(Icons.close_sharp,size: 30 ,color: Styles.defaultWhiteColor,)),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      _pickImage();
                    },
                    child: Stack(
                      children: [
                        file != null ? ClipOval(
                          child: CircleAvatar(
                            radius: 65,
                            backgroundColor: Colors.yellow,
                            child: kIsWeb ? Image.network(
                              profilePic.toString(), fit: BoxFit.cover,height: 200,
                              width: 200,) : Image.file(file!,fit: BoxFit.cover,height: 200,
                              width: 200,),),)
                            : CircleAvatar(backgroundColor: Colors.white.withOpacity(0.4), radius: 65,
                          child: Icon(Icons.person,size: 100,color: Styles.defaultWhiteColor,),),
                        Positioned(
                          bottom: 0,
                          right: 4,
                          child: ClipOval(
                              child: Container(
                                  padding: EdgeInsets.all(7),
                                  decoration: BoxDecoration(
                                    color: Styles.defaultLimeGreenColor,
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Colors.white,width: 3),
                                  ),
                                  child: Icon(Icons.camera_alt_sharp,color: Colors.white,))),
                        ),
                      ],
                    ),
                  ),
                  // GestureDetector(
                  //   child: Icon(Icons.edit_note_sharp,color: Colors.deepPurple,),
                  // ),
                  Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text("First Name",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Styles.defaultWhiteColor,fontFamily: 'Andika'),),
                      ),
                      TextFormField(
                        controller: userFullName,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person_sharp,color: Styles.defaultLimeGreenColor,),
                          hintText: 'First Name',
                          fillColor: Colors.white,
                          filled: true,
                          hintStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 15, color: Styles.defaultGreyColor,fontFamily: 'Andika'),
                          contentPadding: EdgeInsets.only(left: 30),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Styles.defaultGreenColor),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Styles.defaultGreenColor),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        validator: (value){
                          if(value == null || value.isEmpty){
                            return "First Name Can't Be Empty";
                          }
                        },
                      ),
                      Divider(color: Colors.transparent,),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text("Email",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18, color: Styles.defaultWhiteColor,fontFamily: 'Andika'),),
                      ),
                      TextFormField(
                        controller: userEmail,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email_sharp,color: Styles.defaultLimeGreenColor,),
                          hintText: 'Email',
                          // labelText: "Email",
                          fillColor: Colors.white,
                          filled: true,
                          // labelStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 16, color: Colors.deepPurple.shade500),
                          hintStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 15, color: Styles.defaultGreyColor,fontFamily: 'Andika'),
                          contentPadding: EdgeInsets.only(left: 30),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Styles.defaultGreenColor),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Styles.defaultGreenColor),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        validator: (value){
                          if(value == null || value.isEmpty){
                            return "Email Can\'t Be Empty";
                          }else if (!RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value)) {
                            return "Please Enter Correct Email";
                          }
                        },
                      ),
                      Divider(color: Colors.transparent,),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text("Phone No.",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18, color: Styles.defaultWhiteColor,fontFamily: 'Andika'),),
                      ),
                      TextFormField(
                        controller: userPhoneNo,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email_sharp,color: Styles.defaultLimeGreenColor,),
                          hintText: 'Phone Number',
                          fillColor: Colors.white,
                          filled: true,
                          hintStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 15, color: Styles.defaultGreyColor,fontFamily: 'Andika'),
                          contentPadding: EdgeInsets.only(left: 30),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Styles.defaultGreenColor),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Styles.defaultGreenColor),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        validator: (value){
                          if(value == null || value.isEmpty){
                            return "Phone Can\'t Be Empty";
                          }else if (value.length < 10) {
                            return "Please Enter Correct Phone Number";
                          }
                        },
                      ),
                      Divider(color: Colors.transparent,),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text("Gender",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18, color: Styles.defaultWhiteColor,fontFamily: 'Andika'),),
                      ),
                      TextFormField(
                        controller: userGender,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.family_restroom_sharp,color: Styles.defaultLimeGreenColor,),
                          hintText: 'Gender',
                          // labelText: "Gender",
                          fillColor: Colors.white,
                          filled: true,
                          // labelStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 16, color: Colors.deepPurple.shade500),
                          hintStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Styles.defaultGreyColor,fontFamily: 'Andika'),
                          contentPadding: EdgeInsets.only(left: 30),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Styles.defaultGreenColor),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Styles.defaultGreenColor),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      Divider(color: Colors.transparent,),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text("About",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18, color: Styles.defaultWhiteColor,fontFamily: 'Andika'),),
                      ),
                      TextFormField(
                        controller: userAbout,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.notes_sharp,color: Styles.defaultLimeGreenColor,),
                          hintText: 'About',
                          // labelText: "About",
                          fillColor: Colors.white,
                          filled: true,
                          // labelStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 16, color: Colors.deepPurple.shade500),
                          hintStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 15, color: Styles.defaultGreyColor,fontFamily: 'Andika'),
                          contentPadding: EdgeInsets.only(left: 30),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Styles.defaultGreenColor),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Styles.defaultGreenColor),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        // validator: (value){
                        //   if(value == null || value.isEmpty){
                        //     return "About Can't Be Empty";
                        //   }
                        // },
                      ),
                      Divider(color: Colors.transparent,),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text("Address",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18, color: Styles.defaultWhiteColor,fontFamily: 'Andika'),),
                      ),
                      TextFormField(
                        keyboardType: TextInputType.multiline,
                        minLines: 1,
                        maxLines: 5,
                        controller: userAddress,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.home_sharp,color: Styles.defaultLimeGreenColor,),
                          hintText: 'Address',
                          // labelText: "Address",
                          fillColor: Colors.white,
                          filled: true,
                          // labelStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 16, color: Colors.deepPurple.shade500),
                          hintStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 15, color: Styles.defaultGreyColor,fontFamily: 'Andika',),
                          contentPadding: EdgeInsets.only(left: 30),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Styles.defaultGreenColor),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Styles.defaultGreenColor),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        // validator: (value){
                        //   if(value == null || value.isEmpty){
                        //     return "Address Can't Be Empty";
                        //   }
                        // },
                      ),
                    ],
                  ),
                  Divider(color: Colors.transparent,),
                  GestureDetector(
                    onTap: () => {
                      // // EditClientPage(widge),
                      // editUsersInfo(),
                      updateProfile(context),
                      print("update"),
                    },
                    child: SizedBox(
                      width: double.infinity,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Styles.defaultGreenColor,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text('Save',textAlign: TextAlign.center,style: TextStyle(color: Styles.defaultWhiteColor,fontFamily: 'Andika',),),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

