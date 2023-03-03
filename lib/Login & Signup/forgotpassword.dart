import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:feed_your_pet/Login%20&%20Signup/login.dart';
import 'package:feed_your_pet/main.dart';

class forgotPasswordPage extends StatefulWidget {
  const forgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<forgotPasswordPage> createState() => _forgotPasswordPageState();
}

class _forgotPasswordPageState extends State<forgotPasswordPage> {

  String loginPassword = "";
  String loginEmail = "";
  String recoverEmail = "";
  bool changeButton = false;

  final _FormKey = GlobalKey<FormState>();


  TextEditingController userEmailController = TextEditingController();

  @override
  void dispose(){
    userEmailController.dispose();

    super.dispose();
  }

  Future verifyEmail() async{
    showDialog(context: context, barrierDismissible: false,builder: (context) => Center(child: CircularProgressIndicator(),));
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
          email: userEmailController.text);
      print("working 1");
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Password Reset Email Sent')));
      print("working 2");
      navigatorKey.currentState!.popUntil((route) => route.isFirst);
      print("working 3");
    } on FirebaseAuthException catch(e){
      print(e);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
      Navigator.of(context).pop();
      print("working 4");
    }

  }

  Widget _menuItem({String title = 'Title Menu', isActive = false}) {
    return Padding(
      padding: const EdgeInsets.only(right: 75),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Column(
          children: [
            Text(
              '$title',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isActive ? Colors.deepPurple : Colors.grey,
              ),
            ),
            SizedBox(
              height: 6,
            ),
            isActive
                ? Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: BorderRadius.circular(30),
              ),
            )
                : SizedBox()
          ],
        ),
      ),
    );
  }

  Widget _moveToLoginPage() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => LoginPage()));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              spreadRadius: 10,
              blurRadius: 12,
            ),
          ],
        ),
        child: Text(
          'Login',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black54,
          ),
        ),
      ),
    );
  }

  moveToHomePage(BuildContext context) async {
    if (_FormKey.currentState!.validate()) {
      setState(() {
        changeButton = true;
      });
      await Future.delayed(Duration(seconds: 1));
      await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
      setState(() {
        changeButton = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SingleChildScrollView(
        child: Container(
          // color: Colors.yellow,
          // margin: EdgeInsets.only(left: 75,right: 75),
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  // color: Colors.indigo,
                  padding: const EdgeInsets.symmetric(vertical: 30,),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // _menuItem(title: 'Home'),
                          _menuItem(title: 'About us'),
                          _menuItem(title: 'Contact us'),
                          _menuItem(title: 'Help'),
                        ],
                      ),
                      // Row(
                      //   children: [
                      //     _menuItem(title: 'Sign Up', isActive: true),
                      //     _moveToLoginPage()
                      //   ],
                      // ),
                    ],
                  ),),
              ),
              Row(
                children: [
                  MediaQuery.of(context).size.width >= 600 ? Expanded(
                    child: Container(
                      // color: Colors.green,
                      // height: 600,
                      width: MediaQuery.of(context).size.width/3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Welcome \nLet\'s Build',
                            style: TextStyle(
                              fontSize: 45,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              Text(
                                "Already have an account ?",
                                style: TextStyle(
                                    color: Colors.black54, fontWeight: FontWeight.bold),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => _moveToLoginPage()));
                                  },
                                  child: Text(
                                    "Register here!",
                                    style: TextStyle(
                                        color: Colors.deepPurple,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Image.asset(
                              'assets/login & signup/illustration-2.png',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ): Container(width: 0,),
                  MediaQuery.of(context).size.width >= 960 ?Expanded(
                    child: Container(
                      // color: Colors.greenAccent,
                      //   height: 600,
                        width: MediaQuery.of(context).size.width/4,
                        // color: Colors.black,
                        child:Image.asset('assets/login & signup/forgotpassword.png',)
                    ),
                  ): Container(width: 0,),
                  MediaQuery.of(context).size.width >= 600 ? Expanded(
                    child: Container(
                      // height: 600,
                      width: MediaQuery.of(context).size.width/4,
                      // color: Colors.pink,
                      padding: EdgeInsets.all(40),
                      child: Form(
                        key: _FormKey,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                _menuItem(title: 'Recover Account', isActive: true),
                              ],),
                            SizedBox(height: 60),
                            Column(
                              children: [
                                Container(height: 150, width: 150,child: Image.asset('assets/login & signup/resetpasswordnew.png',)),
                                Text("Reset Password",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 36),),
                                Center(child: Text("Enter Your email address and we'll send you an \nemail with instructions to reset your password",style: TextStyle(fontSize: 15,color: Colors.grey,fontWeight: FontWeight.w400),)),
                              ],
                            ),
                            SizedBox(height: 30,),
                            Container(
                              decoration: BoxDecoration(
                                  // boxShadow: [
                              //   BoxShadow(
                              //     color: Colors.grey.shade300,
                              //     spreadRadius: 2,
                              //     blurRadius: 3,
                              //   ),
                              // ],
                                borderRadius: BorderRadius.circular(15)
                              ),
                              child: TextFormField(
                                controller: userEmailController,
                                decoration: InputDecoration(
                                  hintText: 'Enter Email Or Phone Number',
                                  labelText: "Email / Phone",
                                  fillColor: Colors.white,
                                  filled: true,
                                  labelStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 16, color: Colors.deepPurple.shade500),
                                  hintStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 13, color: Colors.grey),
                                  contentPadding: EdgeInsets.only(left: 30),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blueGrey),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blueGrey),
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
                            ),
                            SizedBox(height: 30),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                                // boxShadow: [
                                //   BoxShadow(
                                //     color: Colors.grey.shade500,
                                //     spreadRadius: 8,
                                //     blurRadius: 15,
                                //   ),
                                // ],
                              ),
                              child: ElevatedButton(
                                child: Container(
                                    width: double.infinity,
                                    height: 50,
                                    child: Center(child: Text("Reset Password"))),
                                onPressed: () => verifyEmail(),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.deepPurple,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ) : Expanded(child: Container(
                      // height: 600,
                      width: MediaQuery.of(context).size.width/4,
                      // color: Colors.pink,
                      padding: EdgeInsets.all(40),
                      child: Form(
                        key: _FormKey,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                _menuItem(title: 'Recover Account', isActive: true),
                              ],),
                            SizedBox(height: 60),
                            Column(
                              children: [
                                Container(height: 150, width: 150,child: Image.asset('assets/login & signup/resetpasswordnew.png',)),
                                Text("Reset Password",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 36),),
                                Center(child: Text("Enter Your email address and we'll send you an \nemail with instructions to reset your password",style: TextStyle(fontSize: 15,color: Colors.grey,fontWeight: FontWeight.w400),)),
                              ],
                            ),
                            SizedBox(height: 30,),
                            Container(
                              decoration: BoxDecoration(
                                  // boxShadow: [
                                  //   BoxShadow(
                                  //     color: Colors.grey.shade300,
                                  //     spreadRadius: 2,
                                  //     blurRadius: 3,
                                  //   ),
                                  // ],
                                  borderRadius: BorderRadius.circular(15)
                              ),
                              child: TextFormField(
                                controller: userEmailController,
                                decoration: InputDecoration(
                                  hintText: 'Enter Email',
                                  labelText: "Email",
                                  fillColor: Colors.white,
                                  filled: true,
                                  labelStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 16, color: Colors.deepPurple.shade500),
                                  hintStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 13, color: Colors.grey),
                                  contentPadding: EdgeInsets.only(left: 30),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blueGrey),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blueGrey),
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
                            ),
                            SizedBox(height: 30),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                                // boxShadow: [
                                //   BoxShadow(
                                //     color: Colors.grey.shade500,
                                //     spreadRadius: 8,
                                //     blurRadius: 15,
                                //   ),
                                // ],
                              ),
                              child: ElevatedButton(
                                child: Container(
                                    width: double.infinity,
                                    height: 50,
                                    child: Center(child: Text("Reset Password"))),
                                onPressed: () => verifyEmail(),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.deepPurple,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
