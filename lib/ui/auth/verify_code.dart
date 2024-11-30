import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project/ui/auth/posts/posts_screen.dart';
import 'package:flutter/material.dart';

import '../../Widgets/round_button.dart';
import '../../utils/utils.dart';

class VerifyCode extends StatefulWidget {
  final String VerificationId;
  const VerifyCode({super.key,required this.VerificationId});

  @override
  State<VerifyCode> createState() => _VerifyCodeState();
}

class _VerifyCodeState extends State<VerifyCode> {
  bool loading = false;
  final verificationCodeController = TextEditingController();
  final _auth =FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verify'),
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
              controller: verificationCodeController,
              decoration: InputDecoration(
                hintText: '6 digit code',
              ),
            ),
            SizedBox(height: 80,),
            RoundButton(title: 'Verify',loading: loading, onTap: ()async{
              setState(() {
                loading = true;
              });
              final credentials = PhoneAuthProvider.credential(verificationId: widget.VerificationId,
                  smsCode: verificationCodeController.text.toString());
              try{
              await _auth.signInWithCredential(credentials);
              Navigator.push(context, MaterialPageRoute(builder: (context)=>PostsScreen()));

              }
              catch(e){
                setState(() {
                  loading = true;
                });
                Utils().toastMessage(e.toString());
              }


            })
          ],
        ),
      ),
    );
  }
}
