import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalchat1/widgets/auth/AuthFrom.dart';

class AuthScreen extends StatefulWidget {

  @override
  _AuthScreenState createState() => _AuthScreenState();

}
class _AuthScreenState extends State<AuthScreen>{

  final _auth =FirebaseAuth.instance ;
  bool _isloading =false ;


  void _submitAuthForm(String email,String password, String username,
      bool islogin,BuildContext ctx) async{
    UserCredential authResult ;
    try {
      setState(() {
        _isloading=true ;
      });
      if(islogin){
        authResult = await _auth.signInWithEmailAndPassword(
            email: email,
            password: password
        );

      }else{
        authResult= await _auth.createUserWithEmailAndPassword(
            email: email,
            password: password);
        await FirebaseFirestore.instance.collection('users').doc(authResult.user.uid)
            .set({'username':username,
          'password':password,
        });
      }

    } on FirebaseAuthException catch (e) {
      String message ="error Occurred";
      if (e.code == 'weak-password') {
        message='The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        message='The account already exists for that email.';
      } else if (e.code == 'user-not-found') {
        message='No user found for that email.';
      } else if (e.code == 'wrong-password') {
        message='Wrong password provided for that user.';
      }
      Scaffold.of(ctx).showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(ctx).errorColor,

      ));
      setState(() {
        _isloading=false ;
      });
    } catch (e) {
      print(e);
      setState(() {
        _isloading=false ;
      });
    }

  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthFrom(_submitAuthForm,_isloading),
    );
  }
}

