import 'dart:async';



import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_pratice/screens/login_screen.dart';
import 'package:firebase_pratice/screens/post_screen.dart';
import 'package:flutter/material.dart';

class SplashService{
   void isLogin(BuildContext context){
     final _auth = FirebaseAuth.instance;
     final user = _auth.currentUser;
     if(user!=null){
       Timer(Duration(seconds: 3), () {
         Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
       });
     }
     else{
       Timer(Duration(seconds: 3), () {
         Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
       });
     }
   }
}