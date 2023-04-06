class CartItemModel {
  CartItemModel({
    required this.id,
    required this.title,
    required this.price,
    required this.stock,
    required this.thumbnail,
    required this.totalItem,
    required this.totalPrice,
  });

  int id;
  String title;
  int price;
  int stock;
  String thumbnail;
  int? totalItem;
  int? totalPrice;

  factory CartItemModel.fromJson(Map<String, dynamic> map) => CartItemModel(
        id: map["id"],
        title: map["title"],
        price: map["price"],
        stock: map["stock"],
        thumbnail: map["thumbnail"],
        totalItem: map["total_item"] ?? 0,
        totalPrice: map["total_price"] ?? map["price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price,
        "stock": stock,
        "thumbnail": thumbnail,
        "total_item": totalItem ?? 0,
        "total_price": totalPrice ?? price,
      };
}
