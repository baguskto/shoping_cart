// class User {
//   final int id;
//   final String name;
//   final String email;
//
//   User({
//     required this.id,
//     required this.name,
//     required this.email,
//   });
// }

class Products {
  Products({
    required this.products,
    required this.total,
    required this.skip,
    required this.limit,
  });

  List<Product> products;
  int total;
  int skip;
  int limit;
}

class Product {
  Product({
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
    required this.images,
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
  List<String> images;
}
