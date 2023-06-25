import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../constants.dart';

class SupplierTable extends StatelessWidget {
  SupplierTable({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              child: Obx(
                () => DataTable(
                    dividerThickness: 1.0,
                    columnSpacing: defaultPadding,
                    // minWidth: 600,
                    columns: [
                      DataColumn(
                        label: Text(
                          "Id",
                          style: TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(247, 119, 200, 240)),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          "Email",
                          style: TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(247, 119, 200, 240)),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          "Tên",
                          style: TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(247, 119, 200, 240)),
                        ),
                      ),
                      DataColumn(
                          label: Text(
                        "Địa chỉ",
                        style: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(247, 119, 200, 240)),
                      )),
                      DataColumn(
                          label: Text(
                        "Số điện thoại",
                        style: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(247, 119, 200, 240)),
                      )),
                      DataColumn(
                          label: Text(
                        "Xóa",
                        style: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(247, 119, 200, 240)),
                      )),
                    ],
                    rows: supplierController.currentItems.map((data) {
                      return DataRow(
                        cells: [
                          DataCell(Text(
                            data.id,
                            style: TextStyle(overflow: TextOverflow.ellipsis),
                          )),
                          DataCell(Text(data.email)),
                          DataCell(Text(data.supplierName)),
                          DataCell(Text(data.address)),
                          DataCell(Text(data.phoneNumber)),

                          //delete
                          DataCell(ElevatedButton(
                            onPressed: () {
                              supplierController.fetchSupplierById(data.id);

                              //popups
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      backgroundColor: bgColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      scrollable: true,
                                      title: Center(
                                        child: Text('XÁC NHẬN XÓA',
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white)),
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
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.all(10.0),
                                                    child: Container(
                                                      width: 400,
                                                      child: Text(
                                                          'Bạn có muốn xóa không?'),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      actions: [
                                        ElevatedButton(
                                          onPressed: () {
                                            supplierController
                                                .clearTextController();
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            'Không',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                        ElevatedButton(
                                          onPressed: () async {
                                            // Handle delete button press
                                            bool isDeleted =
                                                await supplierController
                                                    .deleteSupplier(data.id);

                                            if (isDeleted) {
                                              // Xử lý khi xóa thành công
                                              Fluttertoast.showToast(
                                                msg:
                                                    'Xóa thành công',
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
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    );
                                  });
                            },
                            child: Text('Xóa'),
                          )),
                        ],
                      );
                    }).toList()),
              ),
            ),
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  supplierController.previousPage();
                },
                child: Text('Trước'),
              ),
              SizedBox(width: 16), // Add some spacing between the buttons
              ElevatedButton(
                onPressed: () {
                  supplierController.nextPage();
                },
                child: Text('Sau'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
