import 'package:admin/screens/tourguide/components/tourguide_detail_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants.dart';
import 'tourguide_delete_form.dart';

class TourGuideTable extends StatelessWidget {
  TourGuideTable({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Colors.grey, width: 1.0),
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
                            {tourGuideController.sortList(columnIndex)},
                        label: Text(
                          "Tên",
                          style: TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(247, 119, 200, 240)),
                        ),
                      ),
                      DataColumn(
                        onSort: (columnIndex, _) =>
                            {tourGuideController.sortList(columnIndex)},
                        label: Text(
                          "Giới tính",
                          style: TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(247, 119, 200, 240)),
                        ),
                      ),
                      DataColumn(
                          label: Text(
                        "Số điện thoại",
                        style: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(247, 119, 200, 240)),
                      )),
                      DataColumn(
                        onSort: (columnIndex, _) =>
                            {tourGuideController.sortList(columnIndex)},
                        label: Text(
                          "Email",
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
                        "Trạng Thái",
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
                    rows: tourGuideController.paginatedTourGuide.map((data) {
                      return DataRow(
                        cells: [
                          DataCell(Text(data.name)),
                          DataCell(Text(data.sex == 0 ? 'Nam' : 'Nữ')),
                          DataCell(Text(data.phoneNumber)),
                          DataCell(Text(data.email)),
                          DataCell(Text(data.address)),
                          DataCell(
                            Text(data.status == 'Active'
                              ? 'Hoạt động'
                              : 'Ngưng hoạt động',
                              style: TextStyle(
                                color: Colors.green
                              ),  
                              ),
                            ),
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
                                            child: DeleteTourGuideForm(
                                                id: data.id)),
                                      ),
                                    );
                                  });
                            },
                            child: Text('Xóa'),
                          )),
                        ],
                        onLongPress: () => {
                          tourGuideController.clearTextController(),
                          tourGuideController.getTourGuideById(data.id),
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
                                        child: DetailTourGuideForm()),
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
                  tourGuideController.previousPage();
                },
                child: Text('Trước'),
              ),
              SizedBox(width: 16), // Add some spacing between the buttons
              ElevatedButton(
                onPressed: () {
                  tourGuideController.nextPage();
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
