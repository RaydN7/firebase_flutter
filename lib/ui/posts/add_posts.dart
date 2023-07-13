import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_project/widgets/round_button.dart';
import 'package:flutter/material.dart';
import '../../utils/utils.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final postController = TextEditingController();
  bool loading = false;
  // final databaseRef = FirebaseDatabase.instance
  //     .ref(
  //         'https://dummy-814b8-default-rtdb.asia-southeast1.firebasedatabase.app/')
  //     .ref;

  final databaseRef =
      FirebaseDatabase.instance.ref('Post'); //created a table or node
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(children: [
          SizedBox(
            height: 30,
          ),
          TextFormField(
            maxLines: 4, // for input space or lines in text form field
            controller: postController,
            decoration: InputDecoration(
                hintText: 'What is in your mind ?',
                border: OutlineInputBorder()),
          ),
          SizedBox(
            height: 30,
          ),
          RoundButton(
              title: 'Add',
              loading: loading,
              onTap: () {
                setState(() {
                  loading = true;
                });
                String id = DateTime.now()
                    .millisecondsSinceEpoch
                    .toString(); //millisecond to make changes fast
                databaseRef.child(id).set({
                  // new child is created with unique id
                  'title': postController.text.toString(),
                  'id': id, //same ids to make it easy to update
                }).then((value) {
                  Utils().toastMessage('Post added');
                  setState(() {
                    loading = false;
                  });
                }).onError((error, stackTrace) {
                  Utils().toastMessage(error.toString());
                  setState(() {
                    loading = false;
                  });
                });
              })
        ]),
      ),
    );
  }
}
