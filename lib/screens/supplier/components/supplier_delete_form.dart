import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../constants.dart';

// ignore: must_be_immutable
class DeleteSupplierForm extends StatelessWidget {
  String id;
  DeleteSupplierForm({
    Key? key,
    required this.id
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Container(
        width: 500,
        color: secondaryColor,
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Container(
                width: 400,
                child: Text('Bạn có muốn xóa không?'),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    supplierController.clearTextController();
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Không',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    // Handle delete button press
                    bool isDeleted =
                        await supplierController.deleteSupplier(id);

                    if (isDeleted) {
                      // Xử lý khi xóa thành công
                      Fluttertoast.showToast(
                        msg: 'Xóa thành công',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 10,
                        backgroundColor: Colors.green,
                        textColor: Colors.white,
                      );
                    } else {
                      // Xử lý khi xóa thất bại
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
                    'Có',
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