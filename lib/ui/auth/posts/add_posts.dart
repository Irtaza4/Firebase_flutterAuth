import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_project/Widgets/round_button.dart';
import 'package:firebase_project/ui/auth/posts/posts_screen.dart';
import 'package:firebase_project/utils/utils.dart';
import 'package:flutter/material.dart';

class AddPosts extends StatefulWidget {
  const AddPosts({super.key});

  @override
  State<AddPosts> createState() => _AddPostsState();
}

class _AddPostsState extends State<AddPosts> {
  final postController = TextEditingController();
  bool loading = false;
  final databaseRef =FirebaseDatabase.instance.ref('Post');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Post'),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
          SizedBox(
            height: 30,
          ),
            TextFormField(
              maxLines: 4,
              controller: postController,
              decoration: InputDecoration(
                hintText: 'What is in your mind?',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            RoundButton(title: 'Add',loading: loading, onTap: (){
              setState(() {
                loading=true;
              });
              String id = DateTime.now().millisecondsSinceEpoch.toString();
            databaseRef.child(id).set({
              'title':postController.text.toString(),
              'id': id
            }).then((value){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>PostsScreen()));
              Utils().toastMessage('Post Added');
              setState(() {
                loading=false
                ;
              });
            }).onError((error,stackTrace){
              setState(() {
                loading=false;
              });
              Utils().toastMessage(error.toString());
            });
            })
          ],
        ),
      ),

    );
  }
}
