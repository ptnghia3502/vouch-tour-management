import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../constants.dart';
import '../../../helpers/text_field_form.dart';
// import 'package:intl/intl.dart';
class DetailTourGuideForm extends StatefulWidget {
  const DetailTourGuideForm({super.key});

  @override
  State<DetailTourGuideForm> createState() => _DetailTourGuideFormFormState();
}

class _DetailTourGuideFormFormState extends State<DetailTourGuideForm> {
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
                  tourGuideController.tourguideIdTextController,
            ),            
            TextFieldDetailForFroms(
              label: 'Tên',
              validationResult: 'Tên không được bỏ trống',
              icondata: Icons.message,
              textEditingController:
                  tourGuideController.tourguideNameTextController,
            ),
            TextFieldDetailForFroms(
              label: 'Email',
              validationResult: 'Email không được bỏ trống',
              icondata: Icons.email,
              textEditingController:
                  tourGuideController.tourguideEmailTextController,
            ),
            TextFieldDetailForFroms(
              label: 'Địa chỉ',
              validationResult: 'Địa chỉ không được bỏ trống',
              icondata: Icons.home,
              textEditingController:
                  tourGuideController.tourguideAddressTextController,
            ),
            TextFieldDetailForFroms(
                label: 'Số điện thoại',
                validationResult: 'Số điện thoại không được bỏ trống',
                textEditingController:
                    tourGuideController.tourguidePhoneNumerTextController,
                icondata: Icons.phone),
            TextFieldDetailForFroms(
                label: 'Giới tính',
                validationResult: 'Giới tính không được bỏ trống',
                textEditingController:
                    tourGuideController.tourguideSexTextController,
                icondata: Icons.male),
            TextFieldDetailForFroms(
                label: 'AdminId',
                validationResult: 'AdminId không được bỏ trống',
                textEditingController:
                    tourGuideController.tourguideAdminIdTextController,
                icondata: Icons.admin_panel_settings),    
            TextFieldDetailForFroms(
                label: 'Trạng thái',
                validationResult: 'Trạng thái không được bỏ trống',
                textEditingController:
                    tourGuideController.tourguideStatusTextController,
                icondata: Icons.place),                            
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () => {
                    tourGuideController.clearTextController(),
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
  // var myFormat = DateFormat('d-MM-yyyy');
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
    );
  }
}
