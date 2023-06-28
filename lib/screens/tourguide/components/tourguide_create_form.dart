import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../constants.dart';
import '../../../helpers/text_field_form.dart';


class CreateTourGuideForm extends StatefulWidget {
  const CreateTourGuideForm({super.key});

  @override
  State<CreateTourGuideForm> createState() => _CreateTourGuideFormState();
}

class _CreateTourGuideFormState extends State<CreateTourGuideForm> {
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
            TextFieldForFroms(
              label: 'Tên',
              validationResult: 'Tên không được bỏ trống',
              icondata: Icons.message,
              textEditingController:
                  tourGuideController.tourguideNameTextController,
            ),
            TextFieldForFroms(
              label: 'Email',
              validationResult: 'Email không được bỏ trống',
              icondata: Icons.message,
              textEditingController:
                  tourGuideController.tourguideEmailTextController,
            ),
            TextFieldForFroms(
              label: 'Địa chỉ',
              validationResult: 'Địa chỉ không được bỏ trống',
              icondata: Icons.home,
              textEditingController:
                  tourGuideController.tourguideAddressTextController,
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Container(
                width: 400,
                child: TextFormField(
                  controller:
                      tourGuideController.tourguideBirthDayTextController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Ngày sinh",
                    icon: Icon(Icons.calendar_month),
                  ),
                  onTap: () async {
                    DateTime? date = DateTime(1900);
                    FocusScope.of(context).requestFocus(new FocusNode());
                    date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now());
                    tourGuideController.tourguideBirthDayTextController.text =
                        date!.toIso8601String();
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Ngày sinh không được bỏ trống";
                    }
                    return null;
                  },
                ),
              ),
            ),
            TextFieldForFroms(
                label: 'Số điện thoại',
                validationResult: 'Số điện thoại không được bỏ trống',
                textEditingController:
                    tourGuideController.tourguidePhoneNumerTextController,
                icondata: Icons.phone),
            TextFieldForFroms(
                label: 'Giới tính',
                validationResult: 'Giới tính không được bỏ trống',
                textEditingController:
                    tourGuideController.tourguideSexTextController,
                icondata: Icons.face),
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
                          await tourGuideController.insertTourGuide();

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