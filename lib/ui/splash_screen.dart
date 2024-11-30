import 'package:firebase_project/firebaseServices/splash_services.dart';
import 'package:flutter/material.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
 SplashServices splashServices = SplashServices();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    splashServices.isLogin(context);
  }
  @override

  Widget build(BuildContext context) {
    return Scaffold(
       body:
     const Center(
      child:
      Text('Fire base Tutorials',style: TextStyle(color: Colors.green,fontSize: 50),),
    ),
    );
  }
}
