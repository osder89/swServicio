import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:screen_protector/screen_protector.dart';

class PreventScreend extends StatefulWidget {
  const PreventScreend({super.key});

  @override
  State<PreventScreend> createState() => _PreventScreendState();
}

class _PreventScreendState extends State<PreventScreend> {
  @override
  void initState() async {
    await ScreenProtector.protectDataLeakageOn();
    super.initState();
  }

  @override
  void dispose() async {
    await ScreenProtector.protectDataLeakageOff();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('hollaa'),
    );
  }
}
