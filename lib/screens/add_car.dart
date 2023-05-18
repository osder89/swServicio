import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:swdeservicio/resources/customer_methods.dart';

//import '../models/event.data.dart';
import '../providers/user_provider.dart';
import '../resources/auth_methods.dart';
import '../resources/car_methods.dart';
import '../resources/firestore_methods.dart';
import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsive_layout_screen.dart';
import '../responsive/web_screen_layout.dart';
import '../utils/colors.dart';
import '../utils/utils.dart';
import '../widgets/text_field_input.dart';
import 'login_screen.dart';

class AddCar extends StatefulWidget {
  const AddCar({super.key});

  @override
  State<AddCar> createState() => _AddCarState();
}

class _AddCarState extends State<AddCar> {
  final TextEditingController _placaController = TextEditingController();
  final TextEditingController _modeloController = TextEditingController();
  final TextEditingController _kilometrajecontroller = TextEditingController();
  final TextEditingController _yearController = TextEditingController();

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
      String res = await CarMethods().addCar(
        _placaController.text,
        _modeloController.text,
        int.parse(_yearController.text),
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
    _placaController.dispose();
    _kilometrajecontroller.dispose();
    _modeloController.dispose();
    _yearController.dispose();
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
              hindText: 'Enter the plate  ',
              textInputType: TextInputType.text,
              textEditingController: _placaController,
            ),
            const SizedBox(
              height: 24,
            ),
            TextFieldInput(
              hindText: 'Enter a model',
              textInputType: TextInputType.text,
              textEditingController: _modeloController,
            ),
            const SizedBox(
              height: 24,
            ),
            TextFieldInput(
              hindText: 'Enter a year',
              textInputType: TextInputType.text,
              textEditingController: _yearController,
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
                    : const Text('add car'),
                width: double.infinity,
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
