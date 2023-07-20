import 'package:admin/screens/product_supplier/components/product_supplier_create_form.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../constants.dart';
import '../../../helpers/text_field_form.dart';
import '../../../models/category_model.dart';
import 'product_supplier_upload_image.dart';
class UpdateProductForm extends StatefulWidget {
  String id;
  UpdateProductForm({
    Key? key,
    required this.id
  });

  @override
  State<UpdateProductForm> createState() => _UpdateProductFormState(id: id);
}

class _UpdateProductFormState extends State<UpdateProductForm> {
  String? id;
  final _formKey = GlobalKey<FormState>();
  _UpdateProductFormState({
    required this.id
  });
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        width: 500,
        color: secondaryColor,
        child: Column(
          children: <Widget>[
            TextFieldForFroms(
                label: 'Tên Sản Phẩm',
                validationResult: 'Tên thể loại không được bỏ trống',
                textEditingController:
                    productsupplierController.productNameTextController,
                icondata: Icons.message),
            TextFieldForFroms(
                label: 'Giá Bán Lại',
                validationResult: 'Giá bán lại không được bỏ trống',
                textEditingController:
                    productsupplierController.productResellTextController,
                icondata: Icons.price_change),
            TextFieldForFroms(
                label: 'Giá Bán Lẻ',
                validationResult: 'Giá bán lẻ không được bỏ trống',
                textEditingController:
                    productsupplierController.productRetailTextController,
                icondata: Icons.price_change),
            TextFieldForFroms(
                label: 'Mô Tả',
                validationResult: 'Mô Tả không được bỏ trống',
                textEditingController:
                    productsupplierController.productDescriptionTextController,
                icondata: Icons.description),
 
            UploadImage(),    
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          await productsupplierController.updateProduct(id!);

                      if (isInserted) {
                        Fluttertoast.showToast(
                          msg: 'Chỉnh sửa thành công',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 10,
                          backgroundColor: Colors.green,
                          textColor: Colors.white,
                        );
                        Navigator.pop(context);
                      }else{
                        Fluttertoast.showToast(
                          msg: 'Có lỗi rồi!',
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

