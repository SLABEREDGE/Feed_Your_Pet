import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feed_your_pet/Pages/bottomNavigationBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:feed_your_pet/Login%20&%20Signup/forgotpassword.dart';
import 'package:feed_your_pet/Login%20&%20Signup/signup.dart';
import 'package:feed_your_pet/Styles/Styles.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:feed_your_pet/main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);


  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {


  String? userEmail = "";
  String userFullName = "";
  String userProfileImage = "";
  String loginPassword = "";
  String loginEmail = "";
  bool changeButton = false;
  bool _isVisible = false;
  bool? _isChecked = false;
  String? uid;
  TextEditingController userEmailController = new TextEditingController();
  TextEditingController userPasswordController = new TextEditingController();

  final _FormKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  Future<User?> signInWithEmailPassword(String Email, String Password) async {
    await Firebase.initializeApp();
    User? user;
    print("working");
    showDialog(context: context, barrierDismissible: false,builder: (context) => Center(child: CircularProgressIndicator(),));

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: Email,
        password: Password,
      );
      print("working");
      user = userCredential.user;

      if (user != null)  {
        uid = user.uid;
        userEmail = user.email;

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('auth', true);
      }

      print("working1");
      // navigatorKey.currentState!.popUntil((route) => route.isFirst);
      showSnack('You are Logged in');
      print("working2");
      navigatorKey.currentState!.popUntil((route) => route.isFirst);

      await Future.delayed(Duration(seconds: 1));
      navigatorKey.currentState!.popUntil((route) => route.isFirst);
      print("working3");
      await Navigator.push(
        context,
        // MaterialPageRoute(builder: (context) => HomePage(userEmail: userEmailController.text, userFullName: userFullName, userProfileImage: userProfileImage,)),
        MaterialPageRoute(builder: (context) => bottomNavigationBar(userEmail: userEmailController.text, userFullName: userFullName, userProfileImage: userProfileImage, id: uid!,)),
      );
      print("working");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print(e.code);
        showSnack('No user Found with this Email');
        await Future.delayed(Duration(seconds: 1));
        // Navigator.of(context).pop();
      } else if (e.code == 'wrong-password') {
        print(e.code);
        showSnack('Password did not match');
        await Future.delayed(Duration(seconds: 1));
        Navigator.of(context).pop();
      }
    } catch (e) {
      print(e);
      showSnack(e.toString());
      await Future.delayed(Duration(seconds: 1));
      Navigator.of(context).pop();
    }
    Navigator.of(context).pop();
  }

  Widget _moveToSignUpPage() {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => signUpPage()));
        },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Styles.defaultBlueColor,width: 2)
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.grey.shade200,
          //     spreadRadius: 10,
          //     blurRadius: 12,
          //   ),
          // ],
        ),
        child: Text(
          'Sign Up',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Styles.defaultBlackColor,
          ),
        ),
      ),
    );
  }


  Future<UserCredential> signInWithGoogle() async {
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
      await FirebaseFirestore.instance.collection('Users').add({
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
      // MaterialPageRoute(builder: (context) => HomePage(userEmail: userEmailController.text, userFullName: userFullName, userProfileImage: userProfileImage,)),
      MaterialPageRoute(builder: (context) => bottomNavigationBar(userEmail: userEmailController.text, userFullName: userFullName, userProfileImage: userProfileImage, id: uid!,)),
    );
    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  moveToDashboardPage(BuildContext context) async {
    if (_FormKey.currentState!.validate()) {
      setState(() {

      });
      signInWithEmailPassword( userEmailController.text, userPasswordController.text);
      setState(() {

      });
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
                                text: "Doesn't have Account ? ",
                                style : TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Styles.defaultWhiteColor,fontFamily: 'Andika'),
                                children: [
                                  TextSpan(
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => signUpPage()));
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
                    padding: EdgeInsets.all(30),
                    child: SingleChildScrollView(
                      child: Form(
                        key: _FormKey,
                        child: Column(
                          children: [
                            GestureDetector(onTap: (){
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => signUpPage()));
                            }, child : Text("Sign In",textAlign: TextAlign.right,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),
                            Divider(color: Colors.transparent,),
                            TextFormField(
                              controller: userEmailController,
                              decoration: InputDecoration(
                                hintText: 'Enter Email',
                                labelText: "Email",
                                fillColor: Styles.defaultWhiteColor,
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
                              // onChanged: (value){
                              //   loginEmail = value;
                              //   print(loginEmail);
                              //   setState(() {
                              //
                              //   });
                              // },
                              validator: (value){
                                if(value == null || value.isEmpty){
                                  print("Email Can\'t Be Empty");
                                  showSnack('Email Can\'t Be Empty');
                                  // ScaffoldMessenger.of(context).showSnackBar(
                                  //     SnackBar(content: Text("Email Can\'t Be Empty")));

                                }else if (!RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(value)) { print("Please Enter Correct Email");
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text("Please Enter Correct Email")));

                                }
                              },
                            ),
                            Divider(color: Colors.transparent,),
                            TextFormField(
                              controller: userPasswordController,
                              obscureText: !_isVisible,
                              decoration: InputDecoration(
                                fillColor: Styles.defaultWhiteColor,
                                filled: true,
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
                                validator: (value){
                                if(value == null || value.isEmpty)
                                { ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text("Password Can\'t Be Empty")));
                                } else if (value.length < 8)
                                { ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text("Password Length atleast be of 8")));
                                }
                                },
                            ),
                            Divider(color: Colors.transparent,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children:[
                                GestureDetector(
                                    child: Text(
                                      'Forget Password?',
                                      style: TextStyle(color: Styles.defaultGreyColor,fontSize: 15,fontWeight: FontWeight.bold),
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => forgotPasswordPage()));
                                    }),
                              ],
                            ),
                            Divider(color: Colors.transparent,),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                                // boxShadow: [
                                //   BoxShadow(
                                //     color: Colors.deepPurple,
                                //     spreadRadius: 10,
                                //     blurRadius: 20,
                                //   ),
                                // ],
                              ),
                              child: ElevatedButton(
                                child: Container(
                                    width: double.infinity,
                                    height: 50,
                                    child: Center(child: Text("Sign In",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),))),
                                onPressed: () => moveToDashboardPage(context),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Styles.defaultLimeGreenColor,
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
                                  color: Styles.defaultOliveGreenColor,
                                  height: 50,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                child: Text("Or continue with",style: TextStyle( color: Styles.defaultBlackColor,fontSize: 16,),),
                              ),
                              Expanded(
                                child: Divider(
                                  color: Styles.defaultOliveGreenColor,
                                  height: 20,
                                ),
                              ),
                            ]),
                            Divider(color: Colors.transparent,),
                            GestureDetector(onTap: (){
                              signInWithGoogle();
                            },child: SizedBox(
                              width: double.infinity,
                              child: Container(
                                  height: 70,
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
                                      Text("Login in with Google",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,fontFamily: 'Andika'),)
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
