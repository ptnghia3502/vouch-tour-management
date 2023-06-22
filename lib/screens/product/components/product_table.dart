import 'package:admin/controllers/product_controller.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../constants.dart';

class ProductTable extends StatelessWidget {
  final ProductController productController = Get.put(ProductController());
  ProductTable({
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
                          "Product Name",
                          style: TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(247, 119, 200, 240)),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          "Resell Price",
                          style: TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(247, 119, 200, 240)),
                        ),
                      ),
                      DataColumn(
                          label: Text(
                        "Retail Price",
                        style: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(247, 119, 200, 240)),
                      )),
                      DataColumn(
                          label: Text(
                        "Description",
                        style: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(247, 119, 200, 240)),
                      )),
                      DataColumn(
                          label: Text(
                        "Status",
                        style: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(247, 119, 200, 240)),
                      )),
                      DataColumn(
                          label: Text(
                        "Suppiler Name",
                        style: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(247, 119, 200, 240)),
                      )),
                      DataColumn(
                          label: Text(
                        "Category Name",
                        style: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(247, 119, 200, 240)),
                      )),
                      DataColumn(
                          label: Text(
                        "Delete",
                        style: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(247, 119, 200, 240)),
                      )),
                      DataColumn(
                          label: Text(
                        "Update",
                        style: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(247, 119, 200, 240)),
                      )),
                    ],
                    rows: productController.productList.map((data) {
                      return DataRow(
                        cells: [
                          DataCell(Text(
                            data.id,
                          )),
                          DataCell(Text(data.productName)),
                          DataCell(Text(data.resellPrice.toString())),
                          DataCell(Text(data.retailPrice.toString())),
                          DataCell(ConstrainedBox(
                            constraints: BoxConstraints(
                                maxWidth: 250, maxHeight: double.infinity),
                            child: Text(
                              data.description,
                              style: TextStyle(overflow: TextOverflow.visible),
                              softWrap: true, //tự động xuống hàng
                            ),
                          )),
                          DataCell(Text(data.status)),
                          DataCell(Text(data.supplier.supplierName)),
                          DataCell(Text(data.category.categoryName)),
                          DataCell(ElevatedButton(
                            onPressed: () async {
                              // Handle delete button press
                              bool isDeleted =
                                  await productController.DeleteProduct(
                                      data.id);
                              if (isDeleted) {
                                // Xử lý khi xóa thành công
                                Fluttertoast.showToast(
                                  msg: 'Product deleted successfully',
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 10,
                                  backgroundColor: Colors.green,
                                  textColor: Colors.white,
                                );
                              } else {
                                // Xử lý khi xóa thất bại
                                Fluttertoast.showToast(
                                  msg: 'Failed to delete product',
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 10,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                );
                              }
                            },
                            child: Text('Delete'),
                          )),
                          DataCell(ElevatedButton(
                            onPressed: () {
                              // Handle delete button press
                            },
                            child: Text('Update'),
                          )),
                        ],
                      );
                    }).toList()),
              ),
            ),
          )
        ],
      ),
    );
  }
}
