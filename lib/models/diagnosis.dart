import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Diagnosis {
  final String diagnosisId;
  final String carId;
  final String description;
  final datePublished;
  final String uid;

  const Diagnosis({
    required this.diagnosisId,
    required this.carId,
    required this.description,
    required this.datePublished,
    required this.uid,
  });

  Map<String, dynamic> toJson() => {
        "diagnosisId": diagnosisId,
        "carId": carId,
        "description": description,
        "datePublished": datePublished,
        "uid": uid,
      };

  static Diagnosis fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Diagnosis(
      uid: snapshot['uid'],
      description: snapshot['description'],
      datePublished: snapshot['datePublished'],
      diagnosisId: snapshot['diagnosisId'],
      carId: snapshot['carId'],
    );
  }
}
