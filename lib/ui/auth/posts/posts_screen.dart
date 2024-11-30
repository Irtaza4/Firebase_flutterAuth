
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project/ui/auth/login_screen.dart';
import 'package:firebase_project/utils/utils.dart';
import 'package:flutter/material.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Post Screen'),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){
            _auth.signOut().then((value){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
            }).onError((error,stackTrace){
              Utils().toastMessage(error.toString());
            });
          }, icon: Icon(Icons.logout_outlined,color: Colors.white,)),
          SizedBox(width: 10,)
        ],
      ),
    );
  }
}
