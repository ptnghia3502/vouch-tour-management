import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../constants.dart';
import '../../../helpers/text_field_form.dart';
class CreateSupplierForm extends StatefulWidget {
  const CreateSupplierForm({super.key});

  @override
  State<CreateSupplierForm> createState() => _CreateSupplierFormState();
}

class _CreateSupplierFormState extends State<CreateSupplierForm> {
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
            TextFieldForEmail(
                label: 'Email',
                validationResult: 'Email không được bỏ trống',
                textEditingController:
                    supplierController.supplierEmailTextController,
                icondata: Icons.email),
            TextFieldForFroms(
                label: 'Tên',
                validationResult: 'Tên không được bỏ trống',
                textEditingController:
                    supplierController.supplierNameTextController,
                icondata: Icons.message),
            TextFieldForFroms(
                label: 'Địa chỉ',
                validationResult: 'Địa chỉ không được bỏ trống',
                textEditingController:
                    supplierController.supplierAdressTextController,
                icondata: Icons.home),
            TextFieldForPhoneNumber(
                label: 'Số điện thoại',
                validationResult: 'Số điện thoại không được bỏ trống',
                textEditingController:
                    supplierController.supplierPhoneNumberTextController,
                icondata: Icons.phone),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Hủy',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      // Handle delete button press
                      bool isInserted =
                          await supplierController.insertSupplier();
                      if (isInserted) {
                        Fluttertoast.showToast(
                          msg: 'Thêm mới thành công',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 10,
                          backgroundColor: Colors.green,
                          textColor: Colors.white,
                        );
                        Navigator.pop(context);
                      }
                    }
                  },
                  child: Text(
                    'Gửi',
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
