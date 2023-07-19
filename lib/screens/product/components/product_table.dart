import 'package:admin/screens/product/components/product_detail_form.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants.dart';

class ProductTable extends StatelessWidget {
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
          border: Border.all(
          color: Colors.grey,
          width: 1.0
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
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
                        onSort: (columnIndex, _) =>
                            {productController.sortList(columnIndex)},
                        label: Text(
                          "Tên Sản Phẩm",
                          style: TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(247, 119, 200, 240)),
                        ),
                      ),
                      DataColumn(
                        onSort: (columnIndex, _) =>
                            {productController.sortList(columnIndex)},
                        label: Text(
                          "Giá Bán Lại",
                          style: TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(247, 119, 200, 240)),
                        ),
                      ),
                      DataColumn(
                          onSort: (columnIndex, _) =>
                              {productController.sortList(columnIndex)},
                          label: Text(
                            "Giá Bán Lẻ",
                            style: TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(247, 119, 200, 240)),
                          )),
                      DataColumn(
                          label: Text(
                        "Mô Tả",
                        style: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(247, 119, 200, 240)),
                      )),
                      DataColumn(
                          label: Text(
                        "Nhà Cung Cấp",
                        style: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(247, 119, 200, 240)),
                      )),
                      DataColumn(
                          label: Text(
                        "Loại Sản Phẩm",
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
                    ],
                    rows: productController.paginatedProduct.map((data) {
                      return DataRow(
                        cells: [
                          DataCell(
                            Align(
                              alignment: Alignment.center,
                              child: CachedNetworkImage(
                                imageUrl: data.images[0].fileURL,
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
                          ),
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
                          DataCell(Text(data.supplier.supplierName!)),
                          DataCell(Text(data.category.categoryName!)),
                          DataCell(
                            Text(data.status == 'Active' ? 'Hoạt động' : 'Không hoạt động',
                            style: TextStyle(color: Colors.green),)
                          ),                          
                        ],
                        onLongPress: () => {
                          productController.getProductById(data.id),
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
                                        child: DetailProductForm()),
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
                  productController.previousPage();
                },
                child: Text('Trước'),
              ),
              SizedBox(width: 16), // Add some spacing between the buttons
              ElevatedButton(
                onPressed: () {
                  productController.nextPage();
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
