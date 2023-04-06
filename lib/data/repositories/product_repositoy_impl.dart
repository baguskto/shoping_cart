import 'package:filter_price_product/data/models/product_model.dart';
import 'package:filter_price_product/data/services/remote/product_service.dart';
import 'package:filter_price_product/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductService productRemoteService;

  ProductRepositoryImpl(this.productRemoteService);

  @override
  Future<List<ProductModel>> fetchProducts() async {
    return await productRemoteService.fetchProducts();
  }
}
