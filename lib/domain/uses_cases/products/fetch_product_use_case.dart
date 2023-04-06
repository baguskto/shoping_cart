import 'package:filter_price_product/domain/repositories/product_repository.dart';

import '../../../data/models/product_model.dart';

class FetchProductsUseCase {
  final ProductRepository productRepository;

  FetchProductsUseCase(this.productRepository);

  Future<List<ProductModel>> call() async {
    return await productRepository.fetchProducts();
  }
}
