import 'package:filter_price_product/domain/repositories/cart_repository.dart';

import '../../../data/models/cart_item_model.dart';

class SaveCartUseCase {
  final CartRepository _repository;

  SaveCartUseCase(this._repository);

  Future<void> call(List<CartItemModel> cart) {
    return _repository.saveCart(cart);
  }
}
