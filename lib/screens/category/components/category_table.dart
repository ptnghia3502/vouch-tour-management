import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../constants.dart';

class CategoryTable extends StatelessWidget {
  CategoryTable({
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
                          "Ảnh",
                          style: TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(247, 119, 200, 240)),
                        ),
                      ),
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
                          "Tên Thể Loại",
                          style: TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(247, 119, 200, 240)),
                        ),
                      ),
                      DataColumn(
                          label: Text(
                        "Xóa",
                        style: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(247, 119, 200, 240)),
                      )),
                    ],
                    rows: categoryController.foundCategoryList.map((data) {
                      return DataRow(
                        cells: [
                          DataCell(
                            Align(
                              alignment: Alignment.center,
                              child: CachedNetworkImage(
                                imageUrl: data.url,
                                placeholder: (context, url) =>
                                    new CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    new Icon(Icons.error),
                              ),
                            ),
                          ),
                          DataCell(Text(
                            data.id,
                          )),
                          DataCell(Text(data.categoryName)),
          
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
                                            categoryController
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
                                                await categoryController
                                                    .deleteCategory(data.id);

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
          )
        ],
      ),
    );
  }
}
