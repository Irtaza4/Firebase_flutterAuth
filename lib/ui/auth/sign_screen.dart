import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project/Widgets/round_button.dart';
import 'package:firebase_project/ui/auth/login_screen.dart';
import 'package:firebase_project/utils/utils.dart';
import 'package:flutter/material.dart';
class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool loading =false;
  final _formKey = GlobalKey<FormState>();
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
  }
  void login(){
    setState(() {
      loading= true;
    });
    _auth.createUserWithEmailAndPassword(email: emailcontroller.text.toString(),
      password: passwordcontroller.text.toString(),
    ).then((value) {
      loading= false;
    }).onError((error, stackTrace) {
      loading = false;
      Utils().toastMessage(error.toString());
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: const Text('SignUp',style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body:
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                        controller: emailcontroller,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            hintText: 'Email',
                            helperText: 'enter email e.g jon@gmail.com' ,
                            prefixIcon: Icon(Icons.alternate_email,color: Colors.deepPurple,)),
                        validator: (value){
                          if(value!.isEmpty){
                            return 'Enter Email';
                          }
                          return null;
                        }




                    ),
                    SizedBox(height: 10,),
                    TextFormField(
                        controller: passwordcontroller,
                        obscureText: true,

                        decoration: InputDecoration(

                            hintText: 'Password',

                            helperText: 'Enter your password' ,
                            prefixIcon: Icon(Icons.lock_open_rounded,color: Colors.deepPurple,)),
                        validator: (value){
                          if(value!.isEmpty){
                            return 'Enter Password';
                          }
                          return null;
                        }
                    ),

                  ],
                )),
            SizedBox(height: 50,),

            RoundButton(title: 'Sign Up',
              loading: loading,
              onTap: (){
                if(_formKey.currentState!.validate()){
                login();
                }
              },),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account?" ),
                TextButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                }, child: Text('Login',style: TextStyle(color: Colors.deepPurple),))
              ],
            )
          ],
        ),
      ),
    );
  }
}
