import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:swdeservicio/models/customer.dart';
import 'package:swdeservicio/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';
import '../models/car.dart';
import '../models/event.dart';

class CarMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //upload post
  Future<String> addCar(
    String placa,
    String modelo,
    //String uidCustomer,

    int year,
    Uint8List file,
  ) async {
    String res = "Some error occurred";
    try {
      String photoUrl =
          await StorageMethods().uploadImageToStorage('profCar', file, true);
      String caruid = const Uuid().v1();
      Car post = Car(
          placa: placa,
          modelo: modelo,
          caruid: caruid,
          //uidCustomer: uidCustomer,
          kilometraje: 0,
          photoUrl: photoUrl,
          year: year);
      _firestore.collection('car').doc(caruid).set(post.toJson());
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
