import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Pages/Home.dart';
import 'Utils/HorizontalScroll.dart';






Future  main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: kIsWeb || Platform.isAndroid
        ? FirebaseOptions(
      apiKey: "AIzaSyDvhYkruXPcQOX8vD8CXdzQCMaMxdfmEIM",
      appId: "1:536893362696:android:23e7dccad6b0b59de7f7bd",
      messagingSenderId: "536893362696",
      projectId: "feed-your-pet-ec328",
      storageBucket: "feed-your-pet-ec328.appspot.com",
      // iosClientId : '1006254553006-2k8b0n3mc2uegfjfe8ms6rui36c6oe9g.apps.googleusercontent.com',
    )
        : null,
  );
  // await Firebase.initializeApp(options: FirebaseOptions(apiKey: "AIzaSyAaOFfENLfNzYzV6t_1O5jMagmhgitNRKU", appId: '1:1006254553006:android:304e62708f3868c8c2fa3f', messagingSenderId: '1006254553006' , projectId: 'quote-management-20526', iosClientId : '1006254553006-2k8b0n3mc2uegfjfe8ms6rui36c6oe9g.apps.googleusercontent.com'));
  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: MyCustomScrollBehavior(),
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      // theme: ThemeData.Colors.deepPurple,
      home: Home()
    );
  }
}
