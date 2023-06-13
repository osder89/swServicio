import 'dart:ffi';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:swdeservicio/models/customer.dart';
import 'package:swdeservicio/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';
import '../models/event.dart';
import '../models/replacement.dart';

class ReplacementMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //upload post
  Future<String> addReplacement(
    String name,
    String description,
    double price,
    int cantidad,
    String make,
    Uint8List file,
  ) async {
    String res = "Some error occurred";
    try {
      String photoUrl = await StorageMethods()
          .uploadImageToStorage('replacementImg', file, true);
      String replacementuid = const Uuid().v1();
      Replacement post = Replacement(
        name: name,
        description: description,
        replaId: replacementuid,
        make: make,
        price: price,
        photourl: photoUrl,
      );
      _firestore.collection('repuesto').doc(replacementuid).set(post.toJson());
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
