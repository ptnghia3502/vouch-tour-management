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


class TextFieldForPhoneNumber extends StatelessWidget {
  String label;
  String validationResult;
  IconData icondata;
  TextEditingController textEditingController;
  TextFieldForPhoneNumber({
    super.key,
    required this.label,
    required this.validationResult,
    required this.icondata,
    required this.textEditingController
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
            String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
            RegExp regExp = RegExp(pattern);
            if (!regExp.hasMatch(value)){
              return 'Số điện thoại không đúng!';
            }
            return null;
          },
        ),
      ),
    );
  }
}

class TextFieldForEmail extends StatelessWidget {
  String label;
  String validationResult;
  IconData icondata;
  TextEditingController textEditingController;
  TextFieldForEmail({
    super.key,
    required this.label,
    required this.validationResult,
    required this.icondata,
    required this.textEditingController
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
            String pattern =
                r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$'; // Basic email pattern
            RegExp regExp = RegExp(pattern);
            if (!regExp.hasMatch(value)){
              return 'Email không hợp lệ!';
            }
            return null;
          },
        ),
      ),
    );
  }
}

class TextFieldDetailForFroms extends StatelessWidget {
  String label;
  String validationResult;
  IconData icondata;
  TextEditingController textEditingController;
  TextFieldDetailForFroms({
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
          style: TextStyle(color: Colors.white),
          enabled: false,
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