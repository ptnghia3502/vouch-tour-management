class Category {
  String id;
  String categoryName;
  String image;
  String url;
  Category({
    required this.id,
    required this.categoryName,
    required this.image,
    required this.url
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    final String image =
        'lib/assets/images/${json["categoryName"].toLowerCase()}_image.png';
    return Category(
      id: json['id'],
      categoryName: json['categoryName'],
      image: image,
      url: json['url']
    );
  }
}
