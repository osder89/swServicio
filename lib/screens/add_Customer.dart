import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:swdeservicio/resources/customer_methods.dart';

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

class AddCustomer extends StatefulWidget {
  const AddCustomer({super.key});

  @override
  State<AddCustomer> createState() => _AddCustomerState();
}

class _AddCustomerState extends State<AddCustomer> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _ciController = TextEditingController();
  final TextEditingController _telephoneController = TextEditingController();
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
      String res = await CustomerMethods().addCustomer(
        _nameController.text,
        _lastnameController.text,
        _emailController.text,
        int.parse(
          _telephoneController.text,
        ),
        int.parse(_telephoneController.text),
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
    _ciController.dispose();
    _emailController.dispose();
    _lastnameController.dispose();
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
              hindText: 'Introducir nombre',
              textInputType: TextInputType.text,
              textEditingController: _nameController,
            ),
            const SizedBox(
              height: 24,
            ),
            TextFieldInput(
              hindText: 'Introducir apellido',
              textInputType: TextInputType.text,
              textEditingController: _lastnameController,
            ),
            const SizedBox(
              height: 24,
            ),
            TextFieldInput(
              hindText: 'Introducir ci',
              textInputType: TextInputType.text,
              textEditingController: _ciController,
            ),
            const SizedBox(
              height: 24,
            ),
            TextFieldInput(
              hindText: 'Introducir correo',
              textInputType: TextInputType.text,
              textEditingController: _emailController,
            ),
            const SizedBox(
              height: 24,
            ),
            TextFieldInput(
              hindText: 'Numero de telefono',
              textInputType: TextInputType.text,
              textEditingController: _telephoneController,
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
                    : const Text('Resgistrar cliente'),
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
