class Category {
  String id;
  String categoryName;
  String fileName;
  String url;
  Category({
    required this.id,
    required this.categoryName,
    required this.fileName,
    required this.url
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
