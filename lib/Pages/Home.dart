import 'package:feed_your_pet/Login%20&%20Signup/signup.dart';
import 'package:feed_your_pet/Pages/bottomNavigationBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState){
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Something went Wrong!'));
            } else if (snapshot.hasData) {
              return bottomNavigationBar(userEmail: "", userFullName: "", userProfileImage: "", id: '',);
            } else {
              return signUpPage();
            }
          }
      ),
    );
  }
}
