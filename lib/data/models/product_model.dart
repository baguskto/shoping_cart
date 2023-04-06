class ProductModel {
  ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.brand,
    required this.category,
    required this.thumbnail,
  });

  int id;
  String title;
  String description;
  int price;
  double discountPercentage;
  double rating;
  int stock;
  String brand;
  String category;
  String thumbnail;

  factory ProductModel.fromJson(Map<String, dynamic> map) => ProductModel(
        id: map["id"],
        title: map["title"],
        description: map["description"],
        price: map["price"],
        discountPercentage: map["discountPercentage"]?.toDouble(),
        rating: map["rating"]?.toDouble(),
        stock: map["stock"],
        brand: map["brand"],
        category: map["category"],
        thumbnail: map["thumbnail"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "price": price,
        "discountPercentage": discountPercentage,
        "rating": rating,
        "stock": stock,
        "brand": brand,
        "category": category,
        "thumbnail": thumbnail,
      };
}
