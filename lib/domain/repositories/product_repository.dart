import 'package:filter_price_product/data/models/products_model.dart';

import '../../data/models/product_model.dart';

abstract class ProductRepository {
  Future<List<ProductModel>> fetchProducts();
}