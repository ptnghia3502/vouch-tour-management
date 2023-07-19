import 'package:admin/screens/supplier/components/supplier_detail_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants.dart';
import 'supplier_delete_form.dart';

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
        border: Border.all(color: Colors.grey, width: 1.0),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
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
                        onSort: (columnIndex, _) =>
                            {supplierController.sortList(columnIndex)},
                        label: Text(
                          "Email",
                          style: TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(247, 119, 200, 240)),
                        ),
                      ),
                      DataColumn(
                        onSort: (columnIndex, _) =>
                            {supplierController.sortList(columnIndex)},
                        label: Text(
                          "Tên",
                          style: TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(247, 119, 200, 240)),
                        ),
                      ),
                      DataColumn(
                          onSort: (columnIndex, _) =>
                              {supplierController.sortList(columnIndex)},
                          label: Text(
                            "Địa Chỉ",
                            style: TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(247, 119, 200, 240)),
                          )),
                      DataColumn(
                          label: Text(
                        "Số Điện Thoại",
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
                    rows: supplierController.paginatedSupplier.map((data) {
                      return DataRow(
                        cells: [
                          DataCell(Text(data.email!)),
                          DataCell(Text(data.supplierName!)),
                          DataCell(Text(data.address!)),
                          DataCell(Text(data.phoneNumber!)),
                          //delete
                          DataCell(ElevatedButton(
                            onPressed: () {
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
                                            child: DeleteSupplierForm(
                                                id: data.id)),
                                      ),
                                    );
                                  });
                            },
                            child: Text('Xóa'),
                          )),
                        ],
                        onLongPress: () => {
                          supplierController.clearTextController(),
                          supplierController.getSupplierById(data.id),
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
                                    child: Text('CHI TIẾT',
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.white)),
                                  ),
                                  content: Container(
                                    width: 700,
                                    child: Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: DetailSupplierForm()),
                                  ),
                                );
                              })
                        },
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
