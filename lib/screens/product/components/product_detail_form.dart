import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../helpers/text_field_form.dart';
// import 'package:intl/intl.dart';
class DetailProductForm extends StatefulWidget {
  const DetailProductForm({super.key});

  @override
  State<DetailProductForm> createState() => _DetailProductFormState();
}

class _DetailProductFormState extends State<DetailProductForm> {
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
                  productController.productIdTextController,
            ),            
            TextFieldDetailForFroms(
              label: 'Tên',
              validationResult: 'Tên không được bỏ trống',
              icondata: Icons.message,
              textEditingController:
                  productController.productNameTextController,
            ),
            TextFieldDetailForFroms(
              label: 'Giá bán lại',
              validationResult: 'Giá bán lại không được bỏ trống',
              icondata: Icons.currency_exchange,
              textEditingController:
                  productController.productResellTextController
            ),
            TextFieldDetailForFroms(
              label: 'Giá bán lẻ',
              validationResult: 'Góa bán lẻ không được bỏ trống',
              icondata: Icons.money,
              textEditingController:
                  productController.productRetailTextController,
            ),
            TextFieldDetailForFroms(
                label: 'Mô tả',
                validationResult: 'Mô tả không được bỏ trống',
                textEditingController:
                    productController.productDescriptionTextController,
                icondata: Icons.description),
            TextFieldDetailForFroms(
                label: 'Nhà cung cấp',
                validationResult: 'Nhà cung cấp không được bỏ trống',
                textEditingController:
                    productController.productSupplierTextController,
                icondata: Icons.support),
            TextFieldDetailForFroms(
                label: 'Loại sản phẩm',
                validationResult: 'Loại sản phẩm không được bỏ trống',
                textEditingController:
                    productController.productCategoryTextController,
                icondata: Icons.category),    
            TextFieldDetailForFroms(
                label: 'Trạng thái',
                validationResult: 'Trạng thái không được bỏ trống',
                textEditingController:
                    productController.productStatusTextController,
                icondata: Icons.place),                            
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () => {
                    productController.clearTextController(),
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
