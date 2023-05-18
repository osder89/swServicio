import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:swdeservicio/models/customer.dart';
import 'package:swdeservicio/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';
import '../models/event.dart';

class CustomerMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //upload post
  Future<String> addCustomer(
    String name,
    String lastname,
    String email,
    int ci,
    int telephone,
    Uint8List file,
  ) async {
    String res = "Some error occurred";
    try {
      String photoUrl = await StorageMethods()
          .uploadImageToStorage('profCustomer', file, true);
      String customeruid = const Uuid().v1();
      Customer post = Customer(
          name: name,
          lastname: lastname,
          customeruid: customeruid,
          email: email,
          ci: ci,
          photoUrl: photoUrl,
          telephone: telephone);
      _firestore.collection('customer').doc(customeruid).set(post.toJson());
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
