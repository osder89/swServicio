import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paypal/flutter_paypal.dart';
import 'package:intl/intl.dart';

import '../screens/cardData_screen.dart';
import '../utils/colors.dart';

class TaskCard extends StatelessWidget {
  final snap;
  const TaskCard({super.key, required this.snap});

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
              horizontal: 16,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 120,
                  padding: const EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 66, 63, 63),
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            offset: Offset(0, 5),
                            blurRadius: 10)
                      ]),
                  child: RichText(
                    text: TextSpan(
                        style: const TextStyle(
                            color: secondaryColor, fontSize: 18),
                        children: [
                          TextSpan(
                            text: 'Nombre:  ' + snap['name'] + '\n',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: secondaryColor),
                          ),
                          TextSpan(
                            text:
                                'Descripcion:   ' ' ${snap['description']} \n',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: secondaryColor),
                          ),
                          TextSpan(
                            text: snap['repuesto'],
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: secondaryColor),
                          ),
                          TextSpan(
                            text: 'Precio:  ' + snap['price'].toString(),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: secondaryColor),
                          ),
                        ]),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
