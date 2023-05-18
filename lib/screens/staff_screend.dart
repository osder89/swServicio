import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:swdeservicio/screens/profile_screen.dart';
import 'package:swdeservicio/screens/signup_screen.dart';

import '../utils/colors.dart';
import '../utils/global_variables.dart';
import 'add_Customer.dart';

class GroupScreen extends StatefulWidget {
  const GroupScreen({super.key});

  @override
  State<GroupScreen> createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  final TextEditingController searchController = TextEditingController();
  bool isShowUsers = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: mobileBackgroundColor,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SignupScreen()));
              },
              icon: Icon(
                Icons.add_box,
                size: 30,
              ),
            )
          ],
          title: Form(
            child: TextFormField(
              controller: searchController,
              decoration:
                  const InputDecoration(labelText: 'Search for a users...'),
              onFieldSubmitted: (String _) {
                setState(() {
                  isShowUsers = true;
                });
                print(_);
              },
            ),
          ),
        ),
        body: isShowUsers
            ? FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection('users')
                    .where(
                      'username',
                      isGreaterThanOrEqualTo: searchController.text,
                    )
                    .get(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView.builder(
                    itemCount: (snapshot.data! as dynamic).docs.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ProfileScreen(
                              uid: (snapshot.data! as dynamic).docs[index]
                                  ['uid'],
                            ),
                          ),
                        ),
                        child: ListTile(
                          // leading: CircleAvatar(
                          //   backgroundImage: NetworkImage(
                          //     (snapshot.data! as dynamic).docs[index]['photoUrl'],
                          //   ),
                          //   radius: 16,
                          // ),
                          title: Text(
                            (snapshot.data! as dynamic).docs[index]['username'],
                          ),
                        ),
                      );
                    },
                  );
                },
              )
            //: Text('post')
            : FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection('users')
                    .where(
                      'username',
                      isGreaterThanOrEqualTo: searchController.text,
                    )
                    .get(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView.builder(
                    itemCount: (snapshot.data! as dynamic).docs.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ProfileScreen(
                              uid: (snapshot.data! as dynamic).docs[index]
                                  ['uid'],
                            ),
                          ),
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                              (snapshot.data! as dynamic).docs[index]
                                  ['photoUrl'],
                            ),
                            radius: 25,
                          ),
                          title: Text(
                            (snapshot.data! as dynamic).docs[index]['username'],
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      );
                    },
                  );
                },
              ));
  }
}
