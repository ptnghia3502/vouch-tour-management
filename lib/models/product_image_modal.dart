class ProductImage {
  String id;
  String fileURL;
  String fileName;
  String productId;

  ProductImage({
    required this.id,
    required this.fileURL,
    required this.fileName,
    required this.productId,
  });

  factory ProductImage.fromJson(Map<String, dynamic> json) {
    return ProductImage(
      id: json['id'],
      fileURL: json['fileURL'],
      fileName: json['fileName'],
      productId: json['productId'],
    );
  }
}
