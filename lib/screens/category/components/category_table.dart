import 'package:admin/screens/category/components/category_delete_form.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../constants.dart';
import 'category_upload_image.dart';

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
          border: Border.all(
          color: Colors.grey,
          width: 1.0
        ),
      ),
      child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
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
                        label: Text(
                          "Ảnh",
                          style: TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(247, 119, 200, 240)),
                        ),
                      ),
                      // DataColumn(
                      //   onSort: (columnIndex, _) => {
                      //     categoryController.sortList(columnIndex)
                      //   },
                      //   label: Text(
                      //     "Id",
                      //     style: TextStyle(
                      //         fontSize: 16,
                      //         color: Color.fromARGB(247, 119, 200, 240)),
                      //   ),
                      // ),
                      DataColumn(
                        
                        onSort: (columnIndex, _) =>
                            {categoryController.sortList(columnIndex)},
                        label: Text(
                          "Tên Thể Loại",
                          style: TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(247, 119, 200, 240)),
                        ),
                      ),
                      DataColumn(
                          label: Text(
                        "Chỉnh Sửa",
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
                    rows: categoryController.paginatedCategory.map((data) {
                      return DataRow(
                        cells: [
                          DataCell(
                           Container(
                            width: null,
                            child:  Align(
                              alignment: Alignment.center,
                              child: CachedNetworkImage(
                                imageUrl: data.url,
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                        colorFilter: ColorFilter.mode(
                                            Colors.transparent,
                                            BlendMode.colorBurn)),
                                  ),
                                ),
                                placeholder: (context, url) =>
                                    new CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    new Icon(Icons.error),
                              ),
                            ),
                           )
                          ),
                          // DataCell(Text(
                          //   data.id,
                          // )),
                          DataCell(Text(data.categoryName)),
                          //update
                          DataCell(ElevatedButton(
                            onPressed: () {
                              categoryController.getCategoryById(data.id);
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
                                        child: Text('CHỈNH SỬA',
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
                                                  TextFieldForFroms(
                                                      label: 'Tên Thể Loại',
                                                      validationResult:
                                                          'Tên thể loại không được bỏ trống',
                                                      textEditingController:
                                                          categoryController
                                                              .categoryNameTextController,
                                                      icondata: Icons.message),
                                                  UploadImage(),
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
                                            'Hủy',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                        ElevatedButton(
                                          onPressed: () async {
                                            // Handle delete button press
                                            bool isUpdated =
                                                await categoryController
                                                    .updateCategory(data.id);

                                            if (isUpdated) {
                                              // Xử lý khi xóa thành công
                                              Fluttertoast.showToast(
                                                msg: 'Chỉnh sửa thành công',
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
                                            'Gửi',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    );
                                  });
                            },
                            child: Text('Chỉnh sửa'),
                          )),
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
                                            child: DeleteCategoryForm(
                                                id: data.id)),
                                      ),
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
                  categoryController.previousPage();
                },
                child: Text('Trước'),
              ),
              SizedBox(width: 16), // Add some spacing between the buttons
              ElevatedButton(
                onPressed: () {
                  categoryController.nextPage();
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
