
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_project/ui/auth/login_screen.dart';
import 'package:firebase_project/ui/auth/posts/add_posts.dart';
import 'package:firebase_project/utils/utils.dart';
import 'package:flutter/material.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  final _auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref('Post');
  final searchController = TextEditingController();
  final editController = TextEditingController();
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
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>AddPosts()));
      },
      child: Icon(Icons.add),
      ),
      body: Column(
        children: [
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: TextFormField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search',
                border: OutlineInputBorder(),
              ),
              onChanged: (String value){
                setState(() {

                });
              },
            ),
          ),
          Expanded(
            child: FirebaseAnimatedList(query: ref,
                defaultChild: Text('loading'),
                itemBuilder: (context,snapshot,animation,index){
                  final title=snapshot.child('title').value.toString();
                  if(searchController.text.isEmpty){
                    return ListTile(

                      title: Text(snapshot.child('title').value.toString()),
                      subtitle: Text(snapshot.child('id').value.toString()),
                      trailing: PopupMenuButton(
                          icon: Icon(Icons.more_vert),
                          itemBuilder: (context)=>[
                        PopupMenuItem(
                            child: ListTile(
                              onTap: (){
                                Navigator.pop(context);
                                showMydialog(title,snapshot.child('id').value.toString());
                              },
                          title: Text('Edit',),
                              
                        )),
                            PopupMenuItem(child: ListTile(
                              title: Text('Delete'),
                              onTap: (){
                                Navigator.pop(context);
                                ref.child(snapshot.child('id').value.toString()).remove();
                              },
                            ))
                      ]),
                    );
                  }
                  else if (title.toLowerCase().contains(searchController.text.toLowerCase().toString())){
                    return ListTile(

                      title: Text(snapshot.child('title').value.toString()),
                      subtitle: Text(snapshot.child('id').value.toString()),
                    );
                  }
                  else{
                    return Container();
                  }

            }),
          ),

        ],
      ),
    );
  }
  Future<void> showMydialog(String title,String id)async{
    editController.text=title;
    return showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(

            title: Text('Update'),
            content: Container(
              child: TextField(
                controller: editController,
                decoration: InputDecoration(
                  hintText: 'Edit'
                ),
              ),
            ),
            actions: [
              TextButton(onPressed: (){
                Navigator.pop(context);
              }, child: Text('Cancel')),
              TextButton(onPressed: (){
                Navigator.pop(context);
                ref.child(id).update({
                  'title':editController.text.toLowerCase()
                }).then((value){
                  Utils().toastMessage('Post Updated');
                }).onError((error,stackTrace){
                  Utils().toastMessage(error.toString());
                });
              }, child: Text('Update'))
            ],
          );
        });
  }
}


/*Expanded(
child: StreamBuilder(stream: ref.onValue,
builder: (context,AsyncSnapshot<DatabaseEvent> snapshot){

if(!snapshot.hasData){
return CircularProgressIndicator();
}
else{
Map<dynamic, dynamic> map = snapshot.data!.snapshot.value as dynamic;
List<dynamic> list = [];
list.clear();
list= map.values.toList();
return ListView.builder(
itemCount: snapshot.data!.snapshot.children.length,
itemBuilder: (context,index){

return ListTile(
title: Text(list[index]['title']),
subtitle: Text(list[index]['id']),
);
});
}

})),*/