import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

import '../resources/auth_methods.dart';
import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsive_layout_screen.dart';
import '../responsive/web_screen_layout.dart';
import '../utils/colors.dart';
import '../utils/utils.dart';
import '../widgets/text_field_input.dart';
import 'login_screen.dart';

class DiagnosisScreen extends StatefulWidget {
  const DiagnosisScreen({super.key});

  @override
  State<DiagnosisScreen> createState() => _DiagnosisScreenState();
}

class _DiagnosisScreenState extends State<DiagnosisScreen> {
  _DiagnosisScreenState() {
    _selec = _mantenimientos[0];
  }

  final TextEditingController _kmController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();
  final _mantenimientos = [
    "mantenimiento de 5000km",
    "mantenimiento de 10000km",
    "mantenimiento de 15000km",
    "mantenimiento de 20000km",
    "mantenimiento de 25000km"
  ];
  final _mensaje = ["Selecione el mantenimiento a realizar", "0", "1"];
  String? _selec = "";

  Uint8List? _image;
  bool _isLoading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _kmController.dispose();
  }

  void navigateToback() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rellene el siguiente formulario"),
      ),
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.symmetric(horizontal: 32),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            Text("Kilometraje"),
            const SizedBox(
              height: 20,
            ),
            TextFieldInput(
              hindText: 'ingrese el kilometraje',
              textInputType: TextInputType.text,
              textEditingController: _kmController,
            ),
            const SizedBox(
              height: 30,
            ),
            Text("Diagnostico"),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: TextField(
                controller: _descripcionController,
                decoration: const InputDecoration(
                    hintText: 'Ingrese su diagnostico',
                    border: OutlineInputBorder()),
                maxLines: 8,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Text("Seleccione el mantenimineto a realizar"),
            const SizedBox(
              height: 20,
            ),
            DropdownButtonFormField(
              value: _selec,
              items: _mantenimientos
                  .map((e) => DropdownMenuItem(
                        child: Text(e),
                        value: e,
                      ))
                  .toList(),
              onChanged: (val) {
                setState(() {
                  _selec = val as String;
                });
              },
              icon: const Icon(Icons.arrow_drop_down_circle),
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.add_moderator)),
            ),
            const SizedBox(
              height: 24,
            ),
            Flexible(
              child: Container(),
              flex: 4,
            ),
            Row(
              children: [
                InkWell(
                  onTap: navigateToback,
                  child: Container(
                    child: _isLoading
                        ? Center(
                            child: CircularProgressIndicator(
                              color: primaryColor,
                            ),
                          )
                        : const Text('Continuar'),
                    width: 120,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: const ShapeDecoration(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4))),
                      color: Colors.green,
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.all(30)),
                InkWell(
                  onTap: navigateToback,
                  child: Container(
                    child: _isLoading
                        ? Center(
                            child: CircularProgressIndicator(
                              color: primaryColor,
                            ),
                          )
                        : const Text('Cancelar'),
                    width: 120,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: const ShapeDecoration(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4))),
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
            Flexible(
              child: Container(),
              flex: 2,
            ),
          ],
        ),
      )),
    );
  }
}
