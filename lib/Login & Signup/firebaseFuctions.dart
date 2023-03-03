import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirestoreServices {
  static saveUser(uid,String userFullName, String userEmail, String userPhoneNo,String userGender,
      String userAbout, String userAddress,String userProfileImage,String password,
      ) async {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        // .set({'Email': Email, 'FirstName': userFirstName,'LastName': userLastName,'UID' : uid,});
        .set({'UID' : uid,'FullName': userFullName,'Email': userEmail,'PhoneNo' : userPhoneNo,
       'Gender' : userGender, 'About' : userAbout,'Address' : userAddress, 'ProfileImage' : userProfileImage,'Password' : password,
    });
  }
}


// class FirestoreServices {
//   static saveUser(String name, email, uid) async {
//     await FirebaseFirestore.instance
//         .collection('Usersdata')
//         .doc(uid)
//         .set({'email': email, 'name': name});
//   }
// }

class GoogleServices{
  static saveGoogleUser(uid,String userFullName, String userEmail,String userProfileImage,
      // String userAbout, String userAddress, String userPhoneNo,String userGender,
      // String Password,
      ) async {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
    // .set({'Email': Email, 'FirstName': userFirstName,'LastName': userLastName,'UID' : uid,});
        .set({'FullName': userFullName,'Email': userEmail,'ProfileImage' : userProfileImage,
      // 'UID' : uid,'Gender' : userGender, 'About' : userAbout,'Address' : userAddress,'PhoneNo' : userPhoneNo,
      // 'Password' : Password,
    });
  }
}

class FirebaseServices  {

  final _auth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();


  // Future<UserCredential> signInWithGoogle() async {
  //   // Trigger the authentication flow
  //   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  //
  //   // Obtain the auth details from the request
  //   final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
  //   // Create a new credential
  //   final credential = GoogleAuthProvider.credential(
  //     accessToken: googleAuth.accessToken,
  //     idToken: googleAuth.idToken,
  //   );
  //
  //   var userEmail = googleUser.email;
  //   var userFullName = googleUser.displayName!;
  //   var userProfileImage = googleUser.photoUrl!;
  //
  //   try {
  //     // CommanDialog.showLoading();
  //     var userCredential;
  //     var response =
  //     await FirebaseFirestore.instance.collection('Users').add({
  //       'UID': googleUser.id,
  //       'userName': userFullName,
  //       "ProfileImage": userProfileImage,
  //       'joinDate': DateTime.now().millisecondsSinceEpoch,
  //       'email': userEmail
  //     });
  //     print("Firebase response1111 ${response.id}");
  //     // CommanDialog.hideLoading();
  //
  //   } catch (exception) {
  //     // CommanDialog.hideLoading();
  //     print("Error Saving Data at firestore $exception");
  //   }
  //
  //   // var emailController;
  //   // SearchBar(userEmail: emailController.text, userFullName: userFullName, userProfileImage: userProfileImage,);
  //   // Navigator.pushReplacement(
  //   //   context,
  //   //   MaterialPageRoute(builder: (context) => DashboardPage(userEmail: emailController.text, userFullName: userFullName, userProfileImage: userProfileImage,)),
  //   // );
  //
  //   // Once signed in, return the UserCredential
  //   return await FirebaseAuth.instance.signInWithCredential(credential);
  // }

  googleSignOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }
}