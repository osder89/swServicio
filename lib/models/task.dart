import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Task {
  final String taskId;
  final String name;
  final double price;
  final String description;
  final String replaId;

  const Task({
    required this.taskId,
    required this.name,
    required this.price,
    required this.replaId,
    required this.description,
  });

  Map<String, dynamic> toJson() => {
        "taskId": taskId,
        "name": name,
        "price": price,
        "replaId": replaId,
        "description": description,
      };

  static Task fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Task(
      taskId: snapshot['taskId'],
      name: snapshot['name'],
      price: snapshot['price'],
      replaId: snapshot['replaId'],
      description: snapshot['description'],
    );
  }
}
