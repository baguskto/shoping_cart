import '../../../data/models/cart_item_model.dart';
import '../../repositories/cart_repository.dart';

class DecrementItemCartUseCase {
  final CartRepository _repository;

  DecrementItemCartUseCase(this._repository);

  void call({
    required int productId,
    required int itemPrice,
  }) {
    List<CartItemModel> cart = _repository.getCart();
    int? existingCartItemIndex =
        cart.indexWhere((item) => item.id == productId);

    if (existingCartItemIndex != -1) {
      CartItemModel updatedCartItem = CartItemModel(
        id: cart[existingCartItemIndex].id,
        title: cart[existingCartItemIndex].title,
        price: cart[existingCartItemIndex].price,
        stock: cart[existingCartItemIndex].stock,
        thumbnail: cart[existingCartItemIndex].thumbnail,
        totalItem: cart[existingCartItemIndex].totalItem! - 1,
        totalPrice: cart[existingCartItemIndex].totalPrice! - itemPrice,
      );

      if (updatedCartItem.totalItem == 0) {
        cart.removeAt(existingCartItemIndex);
      } else {
        cart[existingCartItemIndex] = updatedCartItem;
      }
    }

    _repository.saveCart(cart);
  }
}
