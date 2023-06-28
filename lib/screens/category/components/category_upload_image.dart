import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'dart:html' as html;
import '../../../constants.dart';

class UploadImage extends StatefulWidget {
  const UploadImage({super.key});

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {

  List<int>? _selectedFile;
  Uint8List? _bytesData = categoryController.bytesData;

  startwebFilePicker() async{
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.multiple = false;
    uploadInput.draggable = true;
    uploadInput.click();

    uploadInput.onChange.listen((event) {
      final files = uploadInput.files;
      final file = files![0];
      final reader = html.FileReader();
      categoryController.filename = basename(file.name);

      reader.onLoadEnd.listen((event) {
        setState(() {
          _bytesData = Base64Decoder().convert(reader.result.toString().split(',').last);
          _selectedFile = _bytesData;
          categoryController.bytesData = _bytesData;
          categoryController.selectedFile = _selectedFile;
        });
      });
      reader.readAsDataUrl(file);
     });
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Container(
              width: 120,
              child: Container(
                height: 120,
                width: 200,
                color: Colors.blue,
                child: _bytesData != null
                    ? Image.memory(_bytesData!)
                    : const SizedBox(),
              )),
        ),
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Container(
            width: 150,
            child:  MaterialButton(
              color: Colors.blue,
              elevation: 8,
              highlightElevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8)
              ),
              textColor: Colors.white,
              child: Text("Chọn Ảnh"),
              onPressed: () {
                startwebFilePicker();
              },
            ),
          ),
        )
      ],
    );
  }
}