//hh
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:finalchat1/screens/chat_screen.dart';
import 'package:finalchat1/screens/auth_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter demo',
      theme: ThemeData(
        primarySwatch: Colors.pink ,
        backgroundColor: Colors.pink ,
        accentColor: Colors.deepPurple ,
        accentColorBrightness: Brightness.dark,
        buttonTheme: ButtonTheme.of(context).copyWith(
          buttonColor: Colors.pink,
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
      home: StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(),
          builder: (ctx, snapShot){
            if(snapShot.hasData) {
              return ChatScreen();
            }else{
              return AuthScreen();
            }
          }),
    ); //MaterialApp
  }
}