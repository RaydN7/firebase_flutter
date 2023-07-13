import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_project/widgets/round_button.dart';
import 'package:flutter/material.dart';
import '../../utils/utils.dart';

class AddFirestoreDataSreen extends StatefulWidget {
  const AddFirestoreDataSreen({super.key});

  @override
  State<AddFirestoreDataSreen> createState() => _AddFirestoreDataSreenState();
}

class _AddFirestoreDataSreenState extends State<AddFirestoreDataSreen> {
  final postController = TextEditingController();
  bool loading = false;
  final fireStore = FirebaseFirestore.instance
      .collection('users'); //to make a new collection just change 'users'
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
        title: Text('Add firestore data'),
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
                String id = DateTime.fromMillisecondsSinceEpoch
                    .toString(); //for generating our own keys
                fireStore.doc(id).set({
                  'title': postController.text.toString(),
                  'id': id,
                  //create document
                }).then((value) {
                  setState(() {
                    loading = false;
                  });
                  Utils().toastMessage('post added');
                }).onError((error, stackTrace) {
                  setState(() {
                    loading = false;
                  });
                  Utils().toastMessage(error.toString());
                });
              })
        ]),
      ),
    );
  }
}
