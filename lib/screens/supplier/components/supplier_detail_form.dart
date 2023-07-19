import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../constants.dart';
import '../../../helpers/text_field_form.dart';
// import 'package:intl/intl.dart';
class DetailSupplierForm extends StatefulWidget {
  const DetailSupplierForm({super.key});

  @override
  State<DetailSupplierForm> createState() => _DetailSupplierFormState();
}

class _DetailSupplierFormState extends State<DetailSupplierForm> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        width: 500,
        color: secondaryColor,
        child: Column(
          children: <Widget>[
            TextFieldDetailForFroms(
              label: 'Id',
              validationResult: 'Id không được bỏ trống',
              icondata: Icons.code,
              textEditingController:
                  supplierController.supplierIdTextController,
            ),            
            TextFieldDetailForFroms(
              label: 'Tên',
              validationResult: 'Tên không được bỏ trống',
              icondata: Icons.message,
              textEditingController:
                  supplierController.supplierNameTextController,
            ),
            TextFieldDetailForFroms(
              label: 'Email',
              validationResult: 'Email không được bỏ trống',
              icondata: Icons.email,
              textEditingController:
                  supplierController.supplierEmailTextController,
            ),
            TextFieldDetailForFroms(
              label: 'Địa chỉ',
              validationResult: 'Địa chỉ không được bỏ trống',
              icondata: Icons.home,
              textEditingController:
                  supplierController.supplierAdressTextController,
            ),
            TextFieldDetailForFroms(
                label: 'Số điện thoại',
                validationResult: 'Số điện thoại không được bỏ trống',
                textEditingController:
                  supplierController.supplierPhoneNumberTextController,
                icondata: Icons.phone),
                     
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () => {
                    supplierController.clearTextController(),
                    Navigator.pop(context)
                  },
                  child: Text(
                    'Hủy',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}