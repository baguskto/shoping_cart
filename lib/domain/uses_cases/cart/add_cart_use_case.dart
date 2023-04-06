import 'package:filter_price_product/data/models/product_model.dart';
import 'package:filter_price_product/domain/core/utils/snackbar_util.dart';
import 'package:filter_price_product/domain/repositories/cart_repository.dart';

import '../../../data/models/cart_item_model.dart';


class AddCartUseCase {
  final CartRepository _repository;

  AddCartUseCase(this._repository);

  void call({
    required ProductModel product,
  }) {
    if (product.stock == 0) {
      SnackbarUtil.showWarning(message: 'Product out of stock');
      return;
    }
    List<CartItemModel> cart = _repository.getCart();

    int? existingCartItemIndex =
        cart.indexWhere((item) => item.id == product.id);

    if (existingCartItemIndex != -1) {
      CartItemModel updatedCartItem = CartItemModel(
        id: cart[existingCartItemIndex].id,
        title: cart[existingCartItemIndex].title,
        price: cart[existingCartItemIndex].price,
        stock: cart[existingCartItemIndex].stock,
        thumbnail: cart[existingCartItemIndex].thumbnail,
        totalItem: cart[existingCartItemIndex].totalItem! + 1,
        totalPrice: cart[existingCartItemIndex].totalPrice! + product.price,
      );

      cart[existingCartItemIndex] = updatedCartItem;
    } else {
      CartItemModel _cart = CartItemModel(
        id: product.id,
        title: product.title,
        price: product.price,
        stock: product.stock,
        thumbnail: product.thumbnail,
        totalItem: 1,
        totalPrice: product.price,
      );
      cart.add(_cart);
    }

    _repository.saveCart(cart);
    SnackbarUtil.showSuccess(message: 'Item added to cart');
  }
}
