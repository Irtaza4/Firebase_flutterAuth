
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project/ui/auth/login_screen.dart';
import 'package:firebase_project/ui/auth/posts/posts_screen.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class SplashServices{

  void isLogin(BuildContext context){
    final _auth = FirebaseAuth.instance;
    final user = _auth.currentUser;
    if (user!=null){
      Timer(Duration(seconds: 3),()=>  Navigator.push( context, MaterialPageRoute(builder:
          (context)=>PostsScreen())));
    }
    else{
      Timer(Duration(seconds: 3),()=>  Navigator.push( context, MaterialPageRoute(builder: (context)=>LoginScreen())));
    }

  }
}