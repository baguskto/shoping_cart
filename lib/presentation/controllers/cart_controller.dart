import 'package:filter_price_product/domain/uses_cases/cart/cart_decrement_use_case.dart';
import 'package:get/get.dart';

import '../../data/models/cart_item_model.dart';
import '../../domain/uses_cases/cart/cart_increment_use_case.dart';
import '../../domain/uses_cases/cart/delete_item_cart_use_case.dart';
import '../../domain/uses_cases/cart/get_cart_use_case.dart';

class CartController extends GetxController {
  final cart = <CartItemModel>[].obs;
  RxInt totalPrice = 0.obs;

  final GetCartUseCase _getCartUseCase;
  final DeleteItemCartUseCase _deleteItemCartUseCase;
  final IncrementItemCartUseCase _incrementItemCartUseCase;
  final DecrementItemCartUseCase _decrementItemCartUseCase;

  CartController(
    this._getCartUseCase,
    this._deleteItemCartUseCase,
    this._incrementItemCartUseCase,
    this._decrementItemCartUseCase,
  );

  @override
  Future<void> onInit() async {
    super.onInit();
    readCartStorage();
    showTotalPrice();
  }

  void readCartStorage() {
    cart.value = _getCartUseCase.call();
  }

  int sumCartItemPrice() {
    return cart.fold<int>(0, (sum, item) => sum + item.totalPrice!);
  }

  showTotalPrice() {
    totalPrice.value = sumCartItemPrice();
  }

  void deleteItemCart(int productId) {
    _deleteItemCartUseCase.call(productId: productId);
    readCartStorage();
    showTotalPrice();
    cart.refresh();
  }

  void incrementItemCart(int productId, int itemPrice) {
    _incrementItemCartUseCase.call(productId: productId, itemPrice: itemPrice);
    readCartStorage();
    showTotalPrice();
    cart.refresh();
  }

  void decrementItemCart(int productId, int itemPrice) {
    _decrementItemCartUseCase.call(productId: productId, itemPrice: itemPrice);
    readCartStorage();
    showTotalPrice();
    cart.refresh();
  }
}
