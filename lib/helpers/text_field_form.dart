import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TextFieldForFroms extends StatelessWidget {
  String label;
  String validationResult;
  IconData icondata;
  TextEditingController textEditingController;
  TextFieldForFroms({
    super.key,
    required this.label,
    required this.validationResult,
    required this.textEditingController,
    required this.icondata,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Container(
        width: 400,
        child: TextFormField(
          controller: this.textEditingController,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: this.label,
            icon: Icon(this.icondata),
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return this.validationResult;
            }
            return null;
          },
        ),
      ),
    );
  }
}