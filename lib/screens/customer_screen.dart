import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:swdeservicio/screens/profile_screen.dart';

import '../utils/colors.dart';
import '../utils/global_variables.dart';
import 'add_Customer.dart';

class CustomerScreen extends StatefulWidget {
  const CustomerScreen({Key? key}) : super(key: key);

  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
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
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => AddCustomer()));
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
                const InputDecoration(labelText: 'Search for a customer...'),
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
                  .collection('customer')
                  .where(
                    'name',
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
                                ['customeruid'],
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
                          (snapshot.data! as dynamic).docs[index]['name'],
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
                  .collection('customer')
                  .where(
                    'name',
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
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                            (snapshot.data! as dynamic).docs[index]['photoUrl'],
                          ),
                          radius: 30,
                        ),
                        title: Text(
                          ' ${(snapshot.data! as dynamic).docs[index]['name']}  ${(snapshot.data! as dynamic).docs[index]['lastname']} ',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
