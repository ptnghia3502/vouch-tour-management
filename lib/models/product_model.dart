import 'package:admin/models/product_image_modal.dart';
import 'package:admin/models/supplier_model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'category_model.dart';

class Product {
  String id;
  String productName;
  int resellPrice;
  int retailPrice;
  String description;
  String status;
  List<ProductImage> images;
  Supplier supplier;
  Category category;

  Product({
    required this.id,
    required this.productName,
    required this.resellPrice,
    required this.retailPrice,
    required this.description,
    required this.status,
    required this.images,
    required this.supplier,
    required this.category,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    var imagesList = json['images'] as List<dynamic>;
    List<ProductImage> images =
        imagesList.map((image) => ProductImage.fromJson(image)).toList();
    final supplierJson = json['supplier'];
    final categoryJson = json['category'];

    return Product(
      id: json['id'],
      productName: json['productName'],
      resellPrice: json['resellPrice'],
      retailPrice: json['retailPrice'],
      description: json['description'],
      status: json['status'],
      images: images,
      supplier: Supplier.fromJson(supplierJson),
      category: Category.fromJson(categoryJson),
    );
  }
}

class ProductList extends StatelessWidget {
  final List<Product> products;

  ProductList({required this.products});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return InkWell(
          onTap: () {
            showProductImages(context, product);
          },
          child: ListTile(
            title: Text(product.productName),
            subtitle: Text(product.description),
            // Hiển thị hình ảnh đầu tiên của sản phẩm
            leading: Image.network(product.images[0].fileURL),
          ),
        );
      },
    );
  }

  void showProductImages(BuildContext context, Product product) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(product.productName),
          content: Column(
            children: product.images
                .map((image) => Image.network(image.fileURL))
                .toList(),
          ),
        );
      },
    );
  }
}
