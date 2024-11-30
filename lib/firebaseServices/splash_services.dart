
import 'package:firebase_project/ui/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class SplashServices{

  void isLogin(BuildContext context){
    Timer(Duration(seconds: 3),()=>  Navigator.push( context, MaterialPageRoute(builder: (context)=>LoginScreen())));
  }
}