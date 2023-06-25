import 'package:admin/responsive.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../constants.dart';

class SupplierHeaderTable extends StatelessWidget {
  const SupplierHeaderTable({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Danh sách các nhà cung cấp",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: Colors.lightBlue, fontSize: 22),
            ),
            ElevatedButton.icon(
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  horizontal: defaultPadding * 1.5,
                  vertical:
                      defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                ),
              ),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: bgColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        scrollable: true,
                        title: Center(
                          child: Text('TẠO MỚI NHÀ CUNG CẤP',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white)),
                        ),
                        content: Container(
                          width: 700,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Form(
                              child: Container(
                                width: 500,
                                color: secondaryColor,
                                child: Column(
                                  children: <Widget>[
                                    TextFieldForFroms(
                                        label: 'Email',
                                        validationResult:
                                            'Email không được bỏ trống',
                                        textEditingController:
                                            supplierController
                                                .supplierEmailTextController,
                                        icondata: Icons.email),
                                    TextFieldForFroms(
                                        label: 'Tên',
                                        validationResult:
                                            'Tên không được bỏ trống',
                                        textEditingController:
                                            supplierController
                                                .supplierNameTextController,
                                        icondata: Icons.message),
                                    TextFieldForFroms(
                                        label: 'Địa chỉ',
                                        validationResult:
                                            'Địa chỉ không được bỏ trống',
                                        textEditingController:
                                            supplierController
                                                .supplierAdressTextController,
                                        icondata: Icons.home),
                                    TextFieldForFroms(
                                        label: 'Số điện thoại',
                                        validationResult:
                                            'Số điện thoại không được bỏ trống',
                                        textEditingController: supplierController
                                            .supplierPhoneNumberTextController,
                                        icondata: Icons.phone),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        actions: [
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text(
                              'Hủy',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () async {
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
                              } else {
                                Fluttertoast.showToast(
                                  msg: 'Có lỗi rồi!',
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 10,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                );
                              }
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Gửi',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      );
                    });
              },
              icon: Icon(Icons.add),
              label: Text("Tạo mới nhà cung cấp"),
            ),
          ],
        ),
      ],
    );
  }
}

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
