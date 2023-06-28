import 'package:admin/responsive.dart';
import 'package:admin/screens/supplier/components/supplier_create_form.dart';
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
                              child: CreateSupplierForm()),
                        ),
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

