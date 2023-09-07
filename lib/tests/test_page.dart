import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:ui' as ui;

class ScannerPage extends StatefulWidget {
  @override
  _ScannerPageState createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  File? _image;
  final pdf = pw.Document();
  GlobalKey containerKey = GlobalKey();
  Future<void> _pickImage() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: ImageSource.camera);

    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  /// capturer le container en IMAGE
  Future<Uint8List> captureContainer() async {
    try {
      // Find the RenderRepaintBoundary for the given GlobalKey
      RenderRepaintBoundary boundary = containerKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;

      // Capture the image
      ui.Image image = await boundary.toImage(
          pixelRatio: 3.0); // Adjust pixelRatio as needed

      // Convert the image to bytes
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List uint8List = byteData!.buffer.asUint8List();

      return uint8List;
    } catch (e) {
      print('Error capturing container: $e');
      return Uint8List(0);
    }
  }

  Future<void> _generatePdf() async {
    Uint8List imageBytes = await captureContainer();
    if (imageBytes.isNotEmpty) {
      pdf.addPage(pw.Page(build: (pw.Context context) {
        final image = pw.MemoryImage(imageBytes);
        return pw.Image(image);
      }));
      final directory = await getApplicationDocumentsDirectory();
      final pdfPath = File('${directory.path}/example.pdf');
      await pdfPath.writeAsBytes(await pdf.save());

      // Envoyer le PDF, par exemple via un package de partage
      // ou une API de messagerie
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scanner et enregistrer en PDF'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RepaintBoundary(
              key: containerKey,
              child: Container(
                height: 300,
                color: Colors.orange,
                child: Center(
                  child: Text('HELLO WORLD'),
                ),
              ),
            ),
            _image == null
                ? Text('Aucune image sélectionnée')
                : Image.file(_image!),
            ElevatedButton(
              onPressed: captureContainer,
              child: Text('Scanner une image'),
            ),
            ElevatedButton(
              onPressed: _generatePdf,
              child: Text('Enregistrer en PDF'),
            ),
          ],
        ),
      ),
    );
  }
}
