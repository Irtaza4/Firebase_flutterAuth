import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project/Widgets/round_button.dart';
import 'package:firebase_project/ui/auth/login_with_phone.dart';
import 'package:firebase_project/ui/auth/posts/posts_screen.dart';
import 'package:firebase_project/ui/auth/sign_screen.dart';
import 'package:firebase_project/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final _auth = FirebaseAuth.instance;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
  }
  void login(){
    setState(() {
      loading =true;
    });
    _auth.signInWithEmailAndPassword(email: emailcontroller.text, password: passwordcontroller.text).then((value){
      Utils().toastMessage(value.user!.email.toString());
      Navigator.push(context, MaterialPageRoute(builder: (context)=>PostsScreen()));
      setState(() {
        loading =false;
      });
    }).onError((error,stackTrace){
      debugPrint(error.toString());
      Utils().toastMessage(error.toString());
      setState(() {
        loading =false;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Login',style: TextStyle(color: Colors.white),),
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
                              prefixIcon: Icon(Icons.lock_open_outlined,color: Colors.deepPurple,)),
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

              RoundButton(title: 'Login',
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
                  Text("Don't have an account?" ),
                  TextButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>SignupScreen()));
                  }, child: Text('Sing up',style: TextStyle(color: Colors.deepPurple),))
                ],
              ),
              SizedBox(height: 50),
              InkWell(
                onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginWithPhone()));
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                      color: Colors.black
                    ),
                  ),
                  child: Center(
                    child: Text('Login with phone number'),
                  ),
                ),
              )
            
            ],
          ),
        ),
      );

  }
}