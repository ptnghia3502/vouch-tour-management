import 'dart:convert';

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

  startwebFilePicker() async{
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.multiple = false;
    uploadInput.draggable = true;
    uploadInput.click();

    uploadInput.onChange.listen((event) {
      final files = uploadInput.files;
      final file = files![0];
      final reader = html.FileReader();
      productsupplierController.filename = basename(file.name);

      reader.onLoadEnd.listen((event) {
        setState(() {
          productsupplierController.bytesData = Base64Decoder().convert(reader.result.toString().split(',').last);
          productsupplierController.selectedFile = productsupplierController.bytesData;

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
                child: productsupplierController.bytesData != null
                    ? Image.memory(productsupplierController.bytesData!)
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