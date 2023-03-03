import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserService {

  FirebaseFirestore db = FirebaseFirestore.instance;
  FirebaseAuth CurrentUser = FirebaseAuth.instance;
  // DocumentSnapshot? snapshot ;
  QuerySnapshot? snapshot ;

  Future<QuerySnapshot> getUserDetails() async {
  // Future<QuerySnapshot> getUserDetails() async {

    return await db.collection('Users').get();

  }

  DeleteUser(String id) async{

    await db.collection('Users').doc(id).delete();
  }

  EditUser(Map<String,String> userInfo,String id) async{

    return await db.collection('Users').doc(id).set(userInfo);

  }

  getUserById(String id) async{
    return await db.collection('Users').doc(id).get();
  }

  getCurrentUserId() async{
    var user = await CurrentUser.currentUser;
    return user!.uid;
  }

}
