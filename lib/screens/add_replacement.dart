import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:swdeservicio/resources/customer_methods.dart';
import 'package:swdeservicio/resources/replacement_methods.dart';

//import '../models/event.data.dart';
import '../providers/user_provider.dart';
import '../resources/auth_methods.dart';
import '../resources/firestore_methods.dart';
import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsive_layout_screen.dart';
import '../responsive/web_screen_layout.dart';
import '../utils/colors.dart';
import '../utils/utils.dart';
import '../widgets/text_field_input.dart';
import 'login_screen.dart';

class AddReplacement extends StatefulWidget {
  const AddReplacement({super.key});

  @override
  State<AddReplacement> createState() => _AddReplacementState();
}

class _AddReplacementState extends State<AddReplacement> {
  _AddReplacementState() {
    _selec = _marcas[0];
  }
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();
  final TextEditingController _precioController = TextEditingController();
  final TextEditingController _cantidadController = TextEditingController();
  final TextEditingController _marcaController = TextEditingController();
  final _marcas = ["Ingrese la marca", "Susuki", "toyota", "Honda", "Jeep"];
  String? _selec = "";
  Uint8List? _image;
  bool _isLoading = false;

  void selectImage() async {
    Uint8List imag = await pickImage(ImageSource.gallery);
    setState(() {
      _image = imag;
    });
  }

  Future<void> newEvent() async {
    setState(() {
      _isLoading = true;
    });
    try {
      String res = await ReplacementMethods().addReplacement(
        _nameController.text,
        _descripcionController.text,
        double.parse(
          _precioController.text,
        ),
        int.parse(_cantidadController.text),
        _marcaController.text,
        _image!,
      );
      if (res == "success") {
        setState(() {
          _isLoading = false;
        });
        showSnackBar('Create!', context);
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => const ResponsiveLayout(
                webScreenLayout: WebScreenLayout(),
                mobileScreenLayout: MobileScreenLayout())));
      } else {
        setState(() {
          _isLoading = false;
        });
        showSnackBar(res, context);
      }
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //final Event event = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.symmetric(horizontal: 32),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: Container(),
              flex: 2,
            ),
            //Image.asset('assets/imagen.png'),
            Stack(
              children: [
                _image != null
                    ? CircleAvatar(
                        radius: 64,
                        backgroundImage: MemoryImage(_image!),
                      )
                    : CircleAvatar(
                        radius: 64,
                        backgroundImage: const NetworkImage(
                            'https://t4.ftcdn.net/jpg/00/64/67/63/360_F_64676383_LdbmhiNM6Ypzb3FM4PPuFP9rHe7ri8Ju.webp'),
                      ),
                Positioned(
                  bottom: -10,
                  left: 80,
                  child: IconButton(
                    onPressed: selectImage,
                    icon: Icon(Icons.add_a_photo),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 64,
            ),
            TextFieldInput(
              hindText: 'Ingrese el nombre  ',
              textInputType: TextInputType.text,
              textEditingController: _nameController,
            ),
            const SizedBox(
              height: 24,
            ),
            // DropdownButtonFormField(
            //   value: _selec,
            //   items: _marcas
            //       .map((e) => DropdownMenuItem(
            //             child: Text(e),
            //             value: e,
            //           ))
            //       .toList(),
            //   onChanged: (val) {
            //     setState(() {
            //       _selec = val as String;
            //     });
            //   },
            //   icon: const Icon(Icons.arrow_drop_down_circle),
            //   decoration: InputDecoration(
            //     border: OutlineInputBorder(),
            //     //prefixIcon: Icon(Icons.add_moderator)
            //   ),
            // ),
            TextFieldInput(
              hindText: 'Ingrese la marca',
              textInputType: TextInputType.text,
              textEditingController: _marcaController,
            ),
            const SizedBox(
              height: 24,
            ),
            TextFieldInput(
              hindText: 'Ingrese una descripcion',
              textInputType: TextInputType.text,
              textEditingController: _descripcionController,
            ),
            const SizedBox(
              height: 24,
            ),
            TextFieldInput(
              hindText: 'Ingrese el precio',
              textInputType: TextInputType.text,
              textEditingController: _precioController,
            ),
            const SizedBox(
              height: 24,
            ),
            TextFieldInput(
              hindText: 'Ingrese la cantidad',
              textInputType: TextInputType.text,
              textEditingController: _cantidadController,
            ),

            const SizedBox(
              height: 24,
            ),
            const SizedBox(
              height: 24,
            ),
            InkWell(
              onTap: newEvent,
              child: Container(
                child: _isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        ),
                      )
                    : const Text('Continuar'),
                width: 100,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: const ShapeDecoration(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4))),
                  color: blueColor,
                ),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Flexible(
              child: Container(),
              flex: 2,
            ),
          ],
        ),
      )),
    );
    ;
  }
}
