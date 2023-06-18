import 'package:admin/controllers/tourguide_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants.dart';

class TourGuideTable extends StatelessWidget {
  final TourGuideController tourguideController = Get.put(TourGuideController());
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
                      label: Text("Id",
                      style: TextStyle(fontSize: 16, 
                              color: Color.fromARGB(247, 119, 200, 240)
                        ),                       
                      ),
                    ),
                    DataColumn(
                      label: Text("Name",
                      style: TextStyle(fontSize: 16, 
                              color: Color.fromARGB(247, 119, 200, 240)
                        ),                       
                      ),
                    ),
                    DataColumn(
                      label: Text("Sex",
                      style: TextStyle(fontSize: 16, 
                              color: Color.fromARGB(247, 119, 200, 240)
                        ),                       
                      ),
                    ),
                    DataColumn(
                      label: Text("Phone Number",
                      style: TextStyle(fontSize: 16, 
                              color: Color.fromARGB(247, 119, 200, 240)
                        ),                       
                      )
                    ),                   
                    DataColumn(
                      label: Text("Email",
                      style: TextStyle(fontSize: 16, 
                              color: Color.fromARGB(247, 119, 200, 240)
                        ),                       
                      ),
                    ),
                    DataColumn(
                      label: Text("Status",
                      style: TextStyle(fontSize: 16, 
                              color: Color.fromARGB(247, 119, 200, 240)
                        ),                       
                      )
                    ),
                    DataColumn(
                      label: Text("Address",
                      style: TextStyle(fontSize: 16, 
                              color: Color.fromARGB(247, 119, 200, 240)
                        ),                       
                      )
                    ),
                    DataColumn(
                      label: Text("Admin Id",
                      style: TextStyle(fontSize: 16, 
                              color: Color.fromARGB(247, 119, 200, 240)
                        ),                       
                      )
                    ),
                  ],
                  rows: tourguideController.tourguideList.map((data) {
                    return DataRow(
                      cells: [
                        DataCell(Text(data.id)),
                        DataCell(Text(data.name)),
                        DataCell(Text(data.sex.toString())),
                        DataCell(Text(data.phoneNumber)),
                        DataCell(Text(data.email)),
                        DataCell(Text(data.status)),
                        DataCell(Text(data.address)),
                        DataCell(Text(data.adminId)),
                      ],
                    );
                  }).toList()
              ),
            ),),
          )
        ],
      ),
    );
  }
}