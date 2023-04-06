import 'package:filter_price_product/data/repositories/product_repositoy_impl.dart';
import 'package:filter_price_product/data/services/remote/product_service.dart';
import 'package:filter_price_product/domain/repositories/product_repository.dart';
import 'package:filter_price_product/domain/uses_cases/products/fetch_product_use_case.dart';
import 'package:filter_price_product/domain/uses_cases/products/filter_products_use_case.dart';
import 'package:filter_price_product/presentation/controllers/products_controller.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../data/repositories/cart_repository_impl.dart';
import '../../data/services/local/cart_service.dart';
import '../../domain/repositories/cart_repository.dart';
import '../../domain/uses_cases/cart/add_cart_use_case.dart';

class ProductsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductService>(() => ProductService());
    Get.lazyPut<ProductRepository>(
        () => ProductRepositoryImpl(Get.find<ProductService>()));
    Get.lazyPut<FetchProductsUseCase>(
        () => FetchProductsUseCase(Get.find<ProductRepository>()));
    Get.lazyPut<CartService>(() => CartService(Get.find<GetStorage>()));
    Get.lazyPut<CartRepository>(
        () => CartRepositoryImpl(Get.find<CartService>()));
    Get.lazyPut<AddCartUseCase>(
        () => AddCartUseCase(Get.find<CartRepository>()));
    Get.lazyPut<FilterProductsUseCase>(() => FilterProductsUseCase());

    Get.lazyPut<ProductController>(() => ProductController(
          Get.find<FetchProductsUseCase>(),
          Get.find<AddCartUseCase>(),
          Get.find<FilterProductsUseCase>(),
        ));
  }
}
