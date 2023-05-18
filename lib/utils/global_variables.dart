import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:swdeservicio/screens/car_screen.dart';
import 'package:swdeservicio/screens/staff_screend.dart';

//import 'package:swfotografia/screens/home_Screen.dart';

import '../screens/add_post_screen.dart';
import '../screens/feed_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/customer_screen.dart';
import '../screens/shipment_screen.dart';

const webScreenSize = 600;

List<Widget> HomeScreenItems = [
  const FeedScreen(),
  const CustomerScreen(),
  const CarScreen(),
  const GroupScreen(),
  ProfileScreen(
    uid: FirebaseAuth.instance.currentUser!.uid,
  ),
];
