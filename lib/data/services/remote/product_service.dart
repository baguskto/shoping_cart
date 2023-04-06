import 'package:dio/dio.dart';
import 'package:filter_price_product/data/models/product_model.dart';

import 'package:filter_price_product/data/models/products_model.dart';
import 'package:filter_price_product/domain/core/exceptions/default.exception.dart';
import 'package:logger/logger.dart';

class ProductService {
  final Dio _dio = Dio();

  Future<List<ProductModel>> fetchProducts() async {
    try {
      final response = await _dio.get('https://dummyjson.com/products');
      final productsResponseModel =
          ProductsModel.fromJson(response.data as Map<String, dynamic>);
      return productsResponseModel.products;
    } on DioError catch (e) {
      DefaultException();
      Logger().d(e);
      return [];
    }
  }
}
