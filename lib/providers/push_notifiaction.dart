import 'package:firebase_messaging/firebase_messaging.dart';

class PushProvider {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  initNotifications() {
    _firebaseMessaging.requestPermission();

    _firebaseMessaging.getToken().then((token) {
      print(token);
    });
  }
}
