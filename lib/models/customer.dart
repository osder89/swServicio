import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Customer {
  final String name;
  final String lastname;
  final String customeruid;
  final String email;
  final int ci;
  final String photoUrl;
  final int telephone;

  const Customer({
    required this.name,
    required this.lastname,
    required this.customeruid,
    required this.email,
    required this.ci,
    required this.photoUrl,
    required this.telephone,
  });

  Map<String, dynamic> toJson() => {
        "name": name,
        "lastname": lastname,
        "customeruid": customeruid,
        "email": email,
        "ci": ci,
        "photoUrl": photoUrl,
        "telephone": telephone,
      };

  static Customer fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Customer(
        name: snapshot['name'],
        lastname: snapshot['lastname'],
        customeruid: snapshot['customeruid'],
        email: snapshot['email'],
        ci: snapshot['ci'],
        photoUrl: snapshot['photoUrl'],
        telephone: snapshot['telephone']);
  }
}
