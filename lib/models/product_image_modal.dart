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
