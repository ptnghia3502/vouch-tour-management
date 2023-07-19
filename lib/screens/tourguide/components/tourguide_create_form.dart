import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import '../../../constants.dart';
import '../../../helpers/text_field_form.dart';
// import 'package:intl/intl.dart';
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
            TextFieldForEmail(
              label: 'Email',
              validationResult: 'Email không được bỏ trống',
              icondata: Icons.email,
              textEditingController:
                  tourGuideController.tourguideEmailTextController,
            ),
            BirthDay(),
            TextFieldForFroms(
              label: 'Địa chỉ',
              validationResult: 'Địa chỉ không được bỏ trống',
              icondata: Icons.home,
              textEditingController:
                  tourGuideController.tourguideAddressTextController,
            ),
            TextFieldForPhoneNumber(
                label: 'Số điện thoại',
                validationResult: 'Số điện thoại không được bỏ trống',
                textEditingController:
                    tourGuideController.tourguidePhoneNumerTextController,
                icondata: Icons.phone),
            Gender(),
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

class Gender extends StatefulWidget {
  const Gender({super.key});

  @override
  State<Gender> createState() => _GenderState();
}

class _GenderState extends State<Gender> {
  List<String> _gender = ['Nam', 'Nữ'];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Container(
          width: 400,
          child: DropdownButtonFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Giới tính',
              icon: Icon(Icons.male),
            ),
            hint: Text('Nam'),
            value: tourGuideController.selectGender,
            onChanged: (newValue) {
              setState(() {
                tourGuideController.selectGender = newValue as String;
              });
            },
            items: _gender.map((gender) {
              return DropdownMenuItem(
                child: new Text(gender),
                value: gender,
              );
            }).toList(),
          )),
    );
  }
}

class BirthDay extends StatefulWidget {
  const BirthDay({super.key});

  @override
  State<BirthDay> createState() => _BirthDayState();
}

class _BirthDayState extends State<BirthDay> {
  DateTime? date = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Container(
        width: 400,
        child: TextFormField(
          controller: tourGuideController.tourguideBirthDayTextController,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Ngày sinh",
            icon: Icon(Icons.calendar_month),
          ),
          onTap: () async {
            date = DateTime(1900);
            FocusScope.of(context).requestFocus(new FocusNode());
            date = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
            );
            String formateDate = DateFormat('yyy-MM-dd').format(date!);
            tourGuideController.tourguideBirthDayTextController.text = formateDate;
                
          },
          validator: (value) {
            if (value!.isEmpty) {
              return "Ngày sinh không được bỏ trống";
            }
            return null;
          },
        ),
      ),
    );
  }
}
