import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:swdeservicio/screens/add_car.dart';
import 'package:swdeservicio/screens/profile_car.dart';
import 'package:swdeservicio/screens/profile_screen.dart';

import '../utils/colors.dart';
import '../utils/global_variables.dart';
import 'add_Customer.dart';

class CarScreen extends StatefulWidget {
  const CarScreen({Key? key}) : super(key: key);

  @override
  State<CarScreen> createState() => _CarScreenState();
}

class _CarScreenState extends State<CarScreen> {
  final TextEditingController _placaControler = TextEditingController();

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
                  .push(MaterialPageRoute(builder: (context) => AddCar()));
            },
            icon: Icon(
              Icons.add_box,
              size: 30,
            ),
          )
        ],
        title: Form(
          child: TextFormField(
            controller: _placaControler,
            decoration:
                const InputDecoration(labelText: 'Search for a vehicle...'),
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
                  .collection('car')
                  .where(
                    'placa',
                    isGreaterThanOrEqualTo: _placaControler.text,
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
                          builder: (context) => ProfileCarScreen(
                            uid: (snapshot.data! as dynamic).docs[index]
                                ['caruid'],
                          ),
                        ),
                      ),
                      child: ListTile(
                        title: Text(
                          (snapshot.data! as dynamic).docs[index]['placa'],
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
                  .collection('car')
                  .where(
                    'placa',
                    isGreaterThanOrEqualTo: _placaControler.text,
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
                          builder: (context) => ProfileCarScreen(
                            uid: (snapshot.data! as dynamic).docs[index]
                                ['caruid'],
                          ),
                        ),
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                            (snapshot.data! as dynamic).docs[index]['photoUrl'],
                          ),
                          radius: 30,
                        ),
                        title: Text(
                          (snapshot.data! as dynamic).docs[index]['placa'],
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
