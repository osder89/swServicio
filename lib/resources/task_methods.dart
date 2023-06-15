import 'dart:ffi';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:swdeservicio/models/customer.dart';
import 'package:swdeservicio/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';
import '../models/event.dart';
import '../models/replacement.dart';
import '../models/task.dart';

class TaskMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //upload post
  Future<String> addTask(
    String name,
    String description,
    double price,
    String repuestoId,
  ) async {
    String res = "Some error occurred";
    try {
      String taskId = const Uuid().v1();
      Task post = Task(
        name: name,
        description: description,
        replaId: repuestoId,
        price: price,
        taskId: taskId,
      );
      _firestore.collection('tarea').doc(taskId).set(post.toJson());
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
