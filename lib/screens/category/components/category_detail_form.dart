import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../helpers/text_field_form.dart';
// import 'package:intl/intl.dart';
class DetailCategoryForm extends StatefulWidget {
  const DetailCategoryForm({super.key});

  @override
  State<DetailCategoryForm> createState() => _DetailCategoryFormState();
}

class _DetailCategoryFormState extends State<DetailCategoryForm> {
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
                  categoryController.categoryIdTextContoller,
            ),            
            TextFieldDetailForFroms(
              label: 'Tên',
              validationResult: 'Tên không được bỏ trống',
              icondata: Icons.message,
              textEditingController:
                  categoryController.categoryNameTextController,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () => {
                    categoryController.clearTextController(),
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
