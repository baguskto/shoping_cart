import 'package:filter_price_product/data/repositories/cart_repository_impl.dart';
import 'package:filter_price_product/data/services/local/cart_service.dart';
import 'package:filter_price_product/domain/repositories/cart_repository.dart';
import 'package:filter_price_product/domain/uses_cases/cart/cart_decrement_use_case.dart';
import 'package:filter_price_product/domain/uses_cases/cart/cart_increment_use_case.dart';
import 'package:filter_price_product/domain/uses_cases/cart/save_cart_use_case.dart';
import 'package:filter_price_product/presentation/controllers/cart_controller.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../domain/uses_cases/cart/delete_item_cart_use_case.dart';
import '../../domain/uses_cases/cart/get_cart_use_case.dart';

class CartBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CartService>(() => CartService(Get.find<GetStorage>()));
    Get.lazyPut<CartRepository>(
        () => CartRepositoryImpl(Get.find<CartService>()));
    Get.lazyPut<GetCartUseCase>(
        () => GetCartUseCase(Get.find<CartRepository>()));
    Get.lazyPut<SaveCartUseCase>(
        () => SaveCartUseCase(Get.find<CartRepository>()));
    Get.lazyPut<DeleteItemCartUseCase>(
        () => DeleteItemCartUseCase(Get.find<CartRepository>()));
    Get.lazyPut<DecrementItemCartUseCase>(
        () => DecrementItemCartUseCase(Get.find<CartRepository>()));
    Get.lazyPut<IncrementItemCartUseCase>(
        () => IncrementItemCartUseCase(Get.find<CartRepository>()));

    Get.lazyPut<CartController>(() => CartController(
          Get.find<GetCartUseCase>(),
          Get.find<DeleteItemCartUseCase>(),
          Get.find<IncrementItemCartUseCase>(),
          Get.find<DecrementItemCartUseCase>(),
        ));
  }
}
