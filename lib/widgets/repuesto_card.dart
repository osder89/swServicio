import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paypal/flutter_paypal.dart';
import 'package:intl/intl.dart';
import '../screens/cardData_screen.dart';
import '../utils/colors.dart';

class RespuestoCard extends StatelessWidget {
  final snap;
  const RespuestoCard({super.key, required this.snap});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: mobileBackgroundColor,
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Column(
        // header
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 4,
              horizontal: 16,
            ).copyWith(right: 0),
            child: Row(
              children: [],
            ),
          ),
          // imagen
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              width: double.infinity,
              height: 120,
              decoration: _buildDecoration(),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Detalle del repuesto',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                      maxLines: 1,
                    ),
                    Text(
                      'nombre:    ' + snap['name'],
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                    Text(
                      'descripcion:    ' + ' ${snap['description']}',
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                    Text(
                      'precio:    ' + snap['price'].toString(),
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                    Text(
                      'marca:    ' + snap['make'],
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                  ]),
            ),
          ),
          SizedBox(
            height: 300,
            width: 300,
            child: Image.network(
              snap['photourl'],
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}

BoxDecoration _buildDecoration() => BoxDecoration(
    color: Colors.grey[500],
    borderRadius: BorderRadius.only(
        bottomRight: Radius.circular(25), topLeft: Radius.circular(25)));
