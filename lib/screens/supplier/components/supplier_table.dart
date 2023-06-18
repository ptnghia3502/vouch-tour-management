import 'package:admin/controllers/supplier_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants.dart';

class SupplierTable extends StatelessWidget {
  final SupplierController supplierController = Get.put(SupplierController());
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
                      label: Text("Id",
                      style: TextStyle(fontSize: 16, 
                              color: Color.fromARGB(247, 119, 200, 240)
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text("Email",
                      style: TextStyle(fontSize: 16, 
                              color: Color.fromARGB(247, 119, 200, 240)
                        ),                                            
                      ),
                    ),
                    DataColumn(
                      label: Text("Supplier Name",
                      style: TextStyle(fontSize: 16, 
                              color: Color.fromARGB(247, 119, 200, 240)
                        ),                      
                      ),
                    ),
                    DataColumn(
                      label: Text("Address",
                      style: TextStyle(fontSize: 16, 
                              color: Color.fromARGB(247, 119, 200, 240)
                        ),                      
                      )
                    ),
                    DataColumn(
                      label: Text("Phone Number",
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
                  rows: supplierController.supplierList.map((data) {
                    return DataRow(
                      cells: [
                        DataCell(Text(data.id,)),
                        DataCell(Text(data.email)),
                        DataCell(Text(data.supplierName)),
                        DataCell(Text(data.address)),
                        DataCell(Text(data.phoneNumber)),
                        DataCell(Text(data.adminId))
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