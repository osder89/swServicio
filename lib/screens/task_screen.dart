import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:screen_protector/screen_protector.dart';
import 'package:swdeservicio/screens/add_task.dart';
import 'package:swdeservicio/screens/replacement_screen.dart';
import 'package:swdeservicio/widgets/detalle_card.dart';

import '../utils/colors.dart';
import '../widgets/detalle_task.dart';
import '../widgets/post_card.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBar,
        centerTitle: true,
        title: Text('Tareas'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AddtaskScreen()));
            },
            icon: Icon(
              Icons.add_chart_sharp,
              size: 40,
            ),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('tarea').snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) =>
                  TaskCard(snap: snapshot.data!.docs[index].data()));
        },
      ),
    );
  }
}
