import '../../../data/models/cart_item_model.dart';
import '../../../data/models/product_model.dart';
import '../../repositories/cart_repository.dart';

class DeleteItemCartUseCase {
  final CartRepository _repository;

  DeleteItemCartUseCase(this._repository);

  void call({
    required int productId,
  }) {
    List<CartItemModel> cart = _repository.getCart();
    cart.removeWhere((product) => product.id == productId);
    _repository.saveCart(cart);
  }
}
