import 'package:admin/models/supplier_model.dart';
import 'category_model.dart';

class Product {
  String id;
  String productName;
  double resellPrice;
  double retailPrice;
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

  factory Product.fromJsonId(Map<String, dynamic> json, Map<String, dynamic> jsonSupp,
    Map<String, dynamic> jsonCate
  ) {
    var imagesList = json['images'] as List<dynamic>;
    List<ProductImage> images =
        imagesList.map((image) => ProductImage.fromJson(image)).toList();

    return Product(
      id: json['id'],
      productName: json['productName'],
      resellPrice: json['resellPrice'],
      retailPrice: json['retailPrice'],
      description: json['description'],
      status: json['status'],
      images: images,
      supplier: Supplier.fromJson(jsonSupp),
      category: Category.fromJson(jsonSupp),
    );
  }
}

class ProductImage {
  String fileURL;
  String fileName;

  ProductImage({
    required this.fileURL,
    required this.fileName,
  });

  factory ProductImage.fromJson(Map<String, dynamic> json) {
    return ProductImage(
      fileURL: json['fileURL'],
      fileName: json['fileName'],
    );
  }
}
