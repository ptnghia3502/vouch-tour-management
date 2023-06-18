import 'package:admin/controllers/category_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants.dart';

class CategoryTable extends StatelessWidget {
  final CategoryController categoryController = Get.put(CategoryController());
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
                      label: Text("Image",
                      style: TextStyle(fontSize: 16, 
                              color: Color.fromARGB(247, 119, 200, 240)
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text("Id",
                      style: TextStyle(fontSize: 16, 
                              color: Color.fromARGB(247, 119, 200, 240)
                        ),                                            
                      ),
                    ),
                    DataColumn(
                      label: Text("Category Name",
                      style: TextStyle(fontSize: 16, 
                              color: Color.fromARGB(247, 119, 200, 240)
                        ),                      
                      ),
                    ),

                  ],
                  rows: categoryController.categoryList.map((data) {
                    return DataRow(
                      cells: [
                        DataCell(
                          Container(
                            width: 50,
                            height: 50,
                            child: Image.network('${data.url}'),
                          )
                        ),
                        DataCell(Text(data.id,)),
                        DataCell(Text(data.categoryName)),
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