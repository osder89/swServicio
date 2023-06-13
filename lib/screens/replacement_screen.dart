import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:screen_protector/screen_protector.dart';
import 'package:swdeservicio/screens/add_replacement.dart';
import 'package:swdeservicio/widgets/repuesto_card.dart';

import '../utils/colors.dart';

class ReplacementScreen extends StatelessWidget {
  const ReplacementScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBar,
        centerTitle: true,
        title: Text('Repuestos'),
        titleTextStyle: TextStyle(
          fontSize: 30,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AddReplacement()));
            },
            icon: Icon(
              Icons.add_box_outlined,
              size: 40,
            ),
          )
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('repuesto').snapshots(),
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
                  RespuestoCard(snap: snapshot.data!.docs[index].data()));
        },
      ),
    );
  }
}
