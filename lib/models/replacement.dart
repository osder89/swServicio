import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Replacement {
  final String name;
  final String description;
  final String replaId;
  final String make;
  final String photourl;
  final double price;

  const Replacement({
    required this.name,
    required this.description,
    required this.replaId,
    required this.price,
    required this.photourl,
    required this.make,
  });

  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "replaId": replaId,
        "price": price,
        "photourl": photourl,
        "make": make,
      };

  static Replacement fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Replacement(
      name: snapshot['name'],
      description: snapshot['description'],
      replaId: snapshot['replaId'],
      price: snapshot['price'],
      photourl: snapshot['photourl'],
      make: snapshot['make'],
    );
  }
}
