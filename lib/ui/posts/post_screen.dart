import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_project/ui/auth/login_screen.dart';
import 'package:firebase_project/ui/posts/add_posts.dart';
import 'package:firebase_project/utils/utils.dart';
import 'package:flutter/material.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref('Post');
  final searchFilter = TextEditingController();
  final editController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ref.onValue.listen((event) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, //to remove back arrow from app bar
        centerTitle: true,
        title: const Text('Post'),
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: TextFormField(
            controller: searchFilter,
            decoration: InputDecoration(
              hintText: 'Search',
              border: OutlineInputBorder(),
            ),
            onChanged: (String value) {
              //changes made in search field reflected here
              setState(() {});
            },
          ),
        ),
        // Expanded(
        //     child: StreamBuilder(
        //   stream: ref.onValue,
        //   builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
        //     if (!snapshot.hasData) {
        //       return CircularProgressIndicator();
        //     } else {
        //       Map<dynamic, dynamic> map =
        //           snapshot.data!.snapshot.value as dynamic;
        //       List<dynamic> list = [];
        //       list.clear();
        //       list =
        //           map.values.toList(); //now values are stored in dynamic list
        //       return ListView.builder(
        //           itemCount: snapshot.data!.snapshot.children.length,
        //           itemBuilder: (context, index) {
        //             return ListTile(
        //               title: Text(list[index]['title']),
        //               subtitle: Text(list[index]['id']),
        //             );
        //           });
        //     }
        //   },
        // )),
        Expanded(
          child: FirebaseAnimatedList(
              query: ref,
              defaultChild: Text('Loading'),
              itemBuilder: (context, snapshot, animation, index) {
                final title = snapshot.child('title').value.toString();
                if (searchFilter.text.isEmpty) {
                  return ListTile(
                    title: Text(snapshot.child('title').value.toString()),
                    subtitle: Text(
                        snapshot.child('id').value.toString()), //to show id
                    trailing: PopupMenuButton(
                      icon: Icon(Icons.more_vert),
                      itemBuilder: (context) => [
                        PopupMenuItem(
                            value: 1, //value of child
                            child: ListTile(
                              onTap: () {
                                Navigator.pop(context);
                                showMyDialog(
                                    title,
                                    snapshot
                                        .child('id')
                                        .value
                                        .toString()); //pop-up after clicking edit button
                              },
                              leading: Icon(Icons.edit),
                              title: Text(
                                  'Edit'), //displays edit button in search list
                            )),
                        PopupMenuItem(
                            value: 1, //value of child
                            child: ListTile(
                              onTap: () {
                                Navigator.pop(
                                    context); //to close the delete pop-up after deleting value from list
                                ref
                                    .child(
                                        snapshot.child('id').value.toString())
                                    .remove();
                              },
                              leading: Icon(Icons.delete_outline),
                              title: Text(
                                  'Delete'), //displays edit button in search list
                            ))
                      ],
                    ),
                  );
                } else if (title
                    .toLowerCase()
                    .contains(searchFilter.text.toLowerCase().toLowerCase())) {
                  return ListTile(
                    //the search field shows search list just below search field
                    title: Text(snapshot.child('title').value.toString()),
                    subtitle: Text(
                        snapshot.child('id').value.toString()), //to show id
                  );
                } else {
                  return Container();
                }
              }),
        ),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddPostScreen()));
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
                  ref.child(id).update({
                    'title': editController.text.toLowerCase()
                  }).then((value) {
                    Utils().toastMessage('Post Udate');
                  }).onError((error, stackTrace) {
                    Utils().toastMessage(error.toString());
                  });
                },
                child: Text('Update')),
          ],
        );
      },
    );
  }
}
// in some cases we cannot use FirebaseAnimatedList, instead we use StreamBuilder