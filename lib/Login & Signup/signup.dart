import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feed_your_pet/Pages/bottomNavigationBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:feed_your_pet/Login%20&%20Signup/forgotpassword.dart';
import 'package:feed_your_pet/Login%20&%20Signup/login.dart';
import 'package:feed_your_pet/Styles/Styles.dart';
import 'package:feed_your_pet/main.dart';
import '../Services/UserService.dart';
import 'firebaseFuctions.dart';

class signUpPage extends StatefulWidget {
  const signUpPage({Key? key}) : super(key: key);

  @override
  State<signUpPage> createState() => _signUpPageState();
}

class _signUpPageState extends State<signUpPage> {

  String signUpFullName = "";
  String? uid;
  String signUpPhoneNo = "";
  String signUpConfirmPassword = "";
  String signUpEmail = "";
  String signUpPassword = "";
  bool changeButton = false;
  bool _isVisible = false;
  bool? _isChecked = true;
  String? message;
  String userFullName = "";
  String userEmail = '';
  String userAddress = "Default";
  String userGender = 'Default';
  String userPhoneNo = "";
  String userAbout = 'Default';
  String userProfileImage = 'Default';
  String password ="";



  TextEditingController userPhoneNoController = new TextEditingController();
  TextEditingController userFullNameController = new TextEditingController();
  TextEditingController userPasswordController = new TextEditingController();
  TextEditingController userEmailController = new TextEditingController();

  final _FormKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  UserService userService = UserService();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> registerWithEmailPassword(String userFullName, String userEmail, String userPhoneNo,String userGender,String userAbout, String userAddress,String userProfileImage,String password,) async {
    // Initialize Firebase
    await Firebase.initializeApp();
    User? user;
    showDialog(context: context, barrierDismissible: false,builder: (context) => Center(child: CircularProgressIndicator(),));
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: userEmail,
        password: password,
      );
      await FirebaseAuth.instance.currentUser!.updateDisplayName(userFullName);
      await FirebaseAuth.instance.currentUser!.updateEmail(userEmail);
      await FirestoreServices.saveUser(userCredential.user!.uid,userFullName,userEmail, userPhoneNo, userGender, userAbout,userAddress,userProfileImage,password);
      user = userCredential.user;

      if (user != null) {
        uid = user.uid;
        userEmail = user.email!;
      }
      showSnack('Account Registration is Successful');

      navigatorKey.currentState!.popUntil((route) => route.isFirst);
      await Future.delayed(Duration(seconds: 1));
      await Navigator.push(
        context,
        // MaterialPageRoute(builder: (context) => HomePage(userEmail: userEmailController.text, userFullName: userFullNameController.text, userProfileImage: userProfileImage)),
        MaterialPageRoute(builder: (context) => bottomNavigationBar(userEmail: userEmailController.text, userFullName: userFullNameController.text, userProfileImage: userProfileImage, id: uid!,)),

      );navigatorKey.currentState!.popUntil((route) => route.isFirst);

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print(e.code);
        showSnack('Password Provided is too weak');
        await Future.delayed(Duration(seconds: 1));
        Navigator.of(context).pop();
      } else if (e.code == 'email-already-in-use') {
        print(e.code);
        showSnack('Email Provided already Exists');
        await Future.delayed(Duration(seconds: 1));
        Navigator.of(context).pop();
      }
    } catch (e) {
      print(e);
      showSnack(e.toString());
      Navigator.of(context).pop();
    }
    // navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }


  Future<UserCredential> signInWithGoogle() async {
    var userId = await userService.getCurrentUserId();
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    userEmail = googleUser.email;
    userFullName = googleUser.displayName!;
    userProfileImage = googleUser.photoUrl!;

    try {
      // CommanDialog.showLoading();
      var userCredential;
      var response =
      await FirebaseFirestore.instance.collection('Usersdata').add({
        'UID': googleUser.id,
        'userName': userFullName,
        "ProfileImage": userProfileImage,
        'joinDate': DateTime.now().millisecondsSinceEpoch,
        'email': userEmail
      });
      print("Firebase response1111 ${response.id}");
      // CommanDialog.hideLoading();
    } catch (exception) {
      // CommanDialog.hideLoading();
      print("Error Saving Data at firestore $exception");
    }
    // SearchBar(userEmail: emailController.text, userFullName: emailController.text, userProfileImage: userProfileImage,);
    Navigator.pushReplacement(
      context,
      // MaterialPageRoute(builder: (context) => HomePage(userEmail: userEmailController.text, userFullName: userFullName, userProfileImage: userProfileImage!,)),
      MaterialPageRoute(builder: (context) => bottomNavigationBar(userEmail: userEmailController.text, userFullName: userFullNameController.text, userProfileImage: userProfileImage, id: userId,)),
    );
    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  moveToHomePage(BuildContext context) async {
    print("moving1");
    if (_FormKey.currentState!.validate()) {
      print("moving2");
      // AuthServices.signinUser(email, password, context);
      registerWithEmailPassword( userFullNameController.text, userEmailController.text,userPhoneNoController.text,userAbout,userAddress,userProfileImage,userGender, userPasswordController.text);
      print("moving3");
    }
  }

  void showSnack(String title) {
    final snackbar = SnackBar(
        content: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15,
          ),
        ));
    scaffoldMessengerKey.currentState?.showSnackBar(snackbar);
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: ScaffoldMessenger(
        key: scaffoldMessengerKey,
        child: Scaffold(
          body: Material(
            color: Styles.defaultLimeGreenColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: Styles.defaultLimeGreenColor,
                  height: size.height*0.30,
                  width: double.infinity,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 100),
                      child: Column(
                        children: [
                          Text("Welcome", style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold,color: Styles.defaultWhiteColor,fontFamily: 'Andika'),),
                          RichText(
                            text: TextSpan(
                                text: "Already have an Account ? ",
                                style : TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Styles.defaultWhiteColor,fontFamily: 'Andika'),
                                children: [
                                  TextSpan(
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginPage()));
                                        },
                                      text : "SignUp",
                                      style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.blue,fontFamily: 'Andika')),
                                ]
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(30) ,topRight: Radius.circular(30)),
                      color: Styles.defaultWhiteColor,),
                    padding: EdgeInsets.all(20),
                    child: Form(
                      key: _FormKey,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              child: Column(
                                children: [
                                  Text("Sign Up",textAlign: TextAlign.right,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                                  Divider(color: Colors.transparent,),
                                  TextFormField(
                                    controller: userFullNameController,
                                    decoration: InputDecoration(
                                      hintText: 'Full Name',
                                      labelText: "Full Name",
                                      fillColor: Colors.white,
                                      filled: true,
                                      labelStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 16, color: Styles.defaultGreenColor),
                                      hintStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 13, color: Styles.defaultGreyColor),
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

                                    onChanged: (value){
                                      signUpFullName = value;
                                      print(signUpFullName);
                                      setState(() {

                                      });
                                    },
                                    validator: (value){
                                      if(value == null || value.isEmpty){
                                        return "Name Can't Be Empty";
                                      }
                                    },
                                  ),
                                  Divider(color: Colors.transparent,),
                                  TextFormField(
                                    controller: userEmailController,
                                    decoration: InputDecoration(
                                      hintText: 'Enter Email',
                                      labelText: "Email",
                                      fillColor: Colors.white,
                                      filled: true,
                                      labelStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 16, color: Styles.defaultGreenColor),
                                      hintStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 13, color: Styles.defaultGreyColor),
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
                                    onChanged: (value){
                                      signUpEmail = value;
                                      print(signUpEmail);
                                      setState(() {

                                      });
                                    },
                                    validator: (value){
                                      if(value == null || value.isEmpty){
                                        return "Email cannot be empty";
                                      }
                                    },
                                  ),
                                  Divider(color: Colors.transparent,),
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15)
                                    ),
                                    child: TextFormField(
                                      controller: userPasswordController,
                                      obscureText: !_isVisible,
                                      decoration: InputDecoration(
                                        suffixIcon: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              _isVisible = !_isVisible;
                                            });
                                          },
                                          icon: _isVisible
                                              ? Icon(Icons.visibility, color: Styles.defaultGreenColor)
                                              : Icon(Icons.visibility_off,color: Styles.defaultGreyColor),
                                        ),
                                        hintText: 'Password',
                                        labelText: 'Password',
                                        fillColor: Colors.white,
                                        filled: true,
                                        labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,color: Styles.defaultGreenColor),
                                        hintStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 13, color: Styles.defaultGreyColor),
                                        // counterText: 'Forgot password?',
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
                                      onChanged: (value){
                                        signUpPassword = value;
                                        print(signUpPassword);
                                        setState(() {

                                        });
                                      },
                                      validator: (value){
                                        if(value == null || value.isEmpty){
                                          return "Password cannot be empty";
                                        } else if(value.length < 8) {
                                          return "Password Length Must Be 8 or More.";
                                        }
                                      },
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Checkbox(
                                        activeColor: Styles.defaultGreenColor,
                                        value: _isChecked,
                                        onChanged: (value){
                                          setState(() {
                                            _isChecked = value;
                                          });
                                        },
                                      ),
                                      Divider(color: Colors.transparent,),
                                      GestureDetector(
                                          child: Text("Remember Me", style: TextStyle(color: Styles.defaultGreyColor,fontSize: 15,fontWeight: FontWeight.bold)),
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => forgotPasswordPage()));
                                          }),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: ElevatedButton(
                                child: Container(
                                    width: double.infinity,
                                    height: 50,
                                    child: Center(child: Text("Sign In"))),
                                onPressed: () async {
                                  moveToHomePage(context);
                                  },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Styles.defaultGreenColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                              ),
                            ),
                            Divider(color: Colors.transparent,),
                            Row(children: [
                              Expanded(
                                child: Divider(
                                  color: Styles.defaultGreenColor,
                                  height: 50,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                child: Text("Or continue with"),
                              ),
                              Expanded(
                                child: Divider(
                                  color: Styles.defaultGreenColor,
                                  height: 50,
                                ),
                              ),
                            ]),
                            Divider(color: Colors.transparent,),
                            GestureDetector(onTap: (){
                              signInWithGoogle();
                            },child: SizedBox(
                              width: double.infinity,
                              child: Container(
                                  height: 50,
                                  decoration:
                                  BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(color: Styles.defaultLimeGreenColor,width: 2),
                                  ),child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Center(child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Image.asset("assets/login & signup/google.png",),
                                  )),
                                  Text("SignUp in with Google",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,fontFamily: 'Andika'),)
                                ],
                              )),
                            ),),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

