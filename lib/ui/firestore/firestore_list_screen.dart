import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_project/ui/firestore/add_firestore_data.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project/ui/auth/login_screen.dart';
import 'package:firebase_project/utils/utils.dart';

class FireStoreScreen extends StatefulWidget {
  const FireStoreScreen({super.key});

  @override
  State<FireStoreScreen> createState() => _FireStoreScreenState();
}

class _FireStoreScreenState extends State<FireStoreScreen> {
  final auth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance.collection('users').snapshots();
  final editController = TextEditingController();
  CollectionReference ref = FirebaseFirestore.instance.collection('users');
  // final ref1 = FirebaseFirestore.instance.collection('users');
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, //to remove back arrow from app bar
        centerTitle: true,
        title: const Text('FireStore'),
        actions: [
          IconButton(
            onPressed: () {
              auth.signOut().then((value) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()));
              }).onError((error, stackTrace) {
                Utils().toastMessage(error.toString());
              });
            },
            icon:
                const Icon(Icons.logout_outlined), // logout button and process
          ),
          const SizedBox(
            width: 10,
          )
        ],
      ),
      body: Column(children: [
        SizedBox(
          height: 10,
        ),
        StreamBuilder<QuerySnapshot>(
            stream: fireStore,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting)
                return CircularProgressIndicator();
              if (snapshot.hasError) return Text('Some Error');
              return Expanded(
                  child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () {
                            ref
                                .doc(
                                    snapshot.data!.docs[index]['id'].toString())
                                .update({'title': 'holla'}).then((value) {
                              Utils().toastMessage('Updated');
                            }).onError((error, stackTrace) {
                              Utils().toastMessage(error.toString());
                            });
                            ref
                                .doc(
                                    snapshot.data!.docs[index]['id'].toString())
                                .delete();
                          },
                          title: Text(
                              snapshot.data!.docs[index]['title'].toString()),
                          subtitle:
                              Text(snapshot.data!.docs[index]['id'].toString()),
                        );
                      }));
            }),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddFirestoreDataSreen()));
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> showMyDialog(String title, String id) async {
    editController.text = title;
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Update'),
          content: Container(
            child: TextField(
              controller: editController,
              decoration: InputDecoration(hintText: 'Edit'),
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel')),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Update')),
          ],
        );
      },
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:firebase_database/ui/firebase_animated_list.dart';
// import 'package:firebase_project/ui/auth/login_screen.dart';
// import 'package:firebase_project/ui/posts/add_posts.dart';
// import 'package:firebase_project/utils/utils.dart';

// class FireStoreScreen extends StatefulWidget {
//   const FireStoreScreen({super.key});

//   @override
//   State<FireStoreScreen> createState() => _FireStoreScreenState();
// }

// class _FireStoreScreenState extends State<FireStoreScreen> {
//   final auth = FirebaseAuth.instance;

//   final editController = TextEditingController();
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false, //to remove back arrow from app bar
//         centerTitle: true,
//         title: const Text('Post'),
//         actions: [
//           IconButton(
//             onPressed: () {
//               auth.signOut().then((value) {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => const LoginScreen()));
//               }).onError((error, stackTrace) {
//                 Utils().toastMessage(error.toString());
//               });
//             },
//             icon:
//                 const Icon(Icons.logout_outlined), // logout button and process
//           ),
//           const SizedBox(
//             width: 10,
//           )
//         ],
//       ),
//       body: Column(children: [
//         SizedBox(
//           height: 10,
//         ),
//         Expanded(
//             child: ListView.builder(
//                 itemCount: 10,
//                 itemBuilder: (context, index) {
//                   return ListTile(
//                     title: Text('rr'),
//                   );
//                 })),
//       ]),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.push(context,
//               MaterialPageRoute(builder: (context) => AddPostScreen()));
//         },
//         child: Icon(Icons.add),
//       ),
//     );
//   }

//   Future<void> showMyDialog(String title, String id) async {
//     editController.text = title;
//     return showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Update'),
//           content: Container(
//             child: TextField(
//               controller: editController,
//               decoration: InputDecoration(hintText: 'Edit'),
//             ),
//           ),
//           actions: [
//             TextButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 child: Text('Cancel')),
//             TextButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 child: Text('Update')),
//           ],
//         );
//       },
//     );
//   }
// }
