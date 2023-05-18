/*import 'dart:html';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class StorageDownloader extends StatefulWidget {
  final String filename;

  StorageDownloader({required this.filename});

  @override
  _StorageDownloaderState createState() => _StorageDownloaderState();
}

class _StorageDownloaderState extends State<StorageDownloader> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: Text('Descargar archivo'),
        onPressed: () async {
          // Obtenemos la referencia al archivo que queremos descargar
          final ref = FirebaseStorage.instance.ref().child(widget.filename);

          // Obtenemos la ruta temporal en el dispositivo donde se almacenará el archivo
          final dir = await getTemporaryDirectory();
          final file = File('${widget.filename}/${dir.path}');

          // Descargamos el archivo y lo almacenamos en la ruta temporal
          await ref.writeToFile(file);

          // Imprimimos la ruta donde se ha guardado el archivo
          print('Archivo descargado en: ${file.path}');
        },
      ),
    );
  }
}*/
