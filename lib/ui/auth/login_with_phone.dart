import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project/Widgets/round_button.dart';
import 'package:firebase_project/ui/auth/verify_code.dart';
import 'package:firebase_project/utils/utils.dart';
import 'package:flutter/material.dart';

class LoginWithPhone extends StatefulWidget {
  const LoginWithPhone({super.key});

  @override
  State<LoginWithPhone> createState() => _LoginWithPhoneState();
}

class _LoginWithPhoneState extends State<LoginWithPhone> {
  bool loading = false;
  final phoneController = TextEditingController();
  final _auth =FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: Colors.deepPurple,
        centerTitle: true
        ,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            SizedBox(height: 80,),
            TextFormField(
              keyboardType: TextInputType.phone,
            controller: phoneController,
              decoration: InputDecoration(
                hintText: '+1 233 456',
              ),
            ),
            SizedBox(height: 80,),
            RoundButton(title: 'Login',loading: loading, onTap: (){
            setState(() {
              loading =true;
            });
              _auth.verifyPhoneNumber(

              phoneNumber: phoneController.text,
                verificationCompleted: (_){
                  setState(() {
                    loading =false;
                  });
                },
                verificationFailed: (e){
                Utils().toastMessage(e.toString());
                setState(() {
                  loading =false;
                });
                },
                codeSent: (String verificationId, int? token){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>VerifyCode(VerificationId: verificationId)));
                setState(() {
                  loading =false;
                });
                },
                codeAutoRetrievalTimeout: (e){
              Utils().toastMessage(e.toString());
              setState(() {
                loading =false;
              });
              });

            })
          ],
        ),
      ),
    );
  }
}
