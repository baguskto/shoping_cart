import 'package:filter_price_product/data/models/product_model.dart';
import 'package:filter_price_product/data/services/local/cart_service.dart';
import 'package:filter_price_product/domain/repositories/cart_repository.dart';

import '../models/cart_item_model.dart';


class CartRepositoryImpl implements CartRepository {
  final CartService _cartService;

  CartRepositoryImpl(this._cartService);

  @override
  List<CartItemModel> getCart() {
    return _cartService.getCart();
  }

  @override
  Future<void> saveCart(List<CartItemModel> cart) {
    return _cartService.saveCart(cart);
  }

  @override
  Future<void> deleteItemCart(int productId) {
    return _cartService.deleteItemCart(productId);
  }
}
