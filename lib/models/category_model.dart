class Category {
  String id;
  String? categoryName;
  String? fileName;
  String? url;
  Category({
    required this.id,
     this.categoryName,
     this.fileName,
     this.url
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      categoryName: json['categoryName'],
      fileName: json['fileName'],
      url: json['url']
    );
  }
}
