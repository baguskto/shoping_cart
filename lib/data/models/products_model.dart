import 'dart:convert';

import 'package:filter_price_product/data/models/product_model.dart';

ProductsModel productsModelFromJson(String str) =>
    ProductsModel.fromJson(json.decode(str));

String productsModelToJson(ProductsModel data) => json.encode(data.toJson());

class ProductsModel {
  ProductsModel({
    required this.products,
    required this.total,
    required this.skip,
    required this.limit,
  });

  List<ProductModel> products;
  int total;
  int skip;
  int limit;

  factory ProductsModel.fromJson(Map<String, dynamic> json) => ProductsModel(
        products: List<ProductModel>.from(
            json["products"].map((x) => ProductModel.fromJson(x))),
        total: json["total"],
        skip: json["skip"],
        limit: json["limit"],
      );

  Map<String, dynamic> toJson() => {
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
        "total": total,
        "skip": skip,
        "limit": limit,
      };
}
