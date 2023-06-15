import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:screen_protector/screen_protector.dart';
import 'package:swdeservicio/screens/replacement_screen.dart';
import 'package:swdeservicio/screens/task_screen.dart';
import 'package:swdeservicio/widgets/detalle_card.dart';

import '../utils/colors.dart';
import '../widgets/post_card.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBar,
        centerTitle: true,
        title: Text('Detalle del Mantenimiento'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ReplacementScreen()));
            },
            icon: Icon(
              Icons.build_circle_sharp,
              size: 40,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => TaskScreen()));
            },
            icon: Icon(
              Icons.assignment,
              size: 40,
            ),
          )
        ],
        //('Datalle del mantenimiento')
        //Image.asset('assets/imagen.png'),
        /*actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.messenger_outline))
        ],*/
      ),
      body: ListView.builder(
          itemBuilder: (BuildContext context, int index) => Detallecard()
          
          ),
    );
  }
}
