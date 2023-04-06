import 'package:filter_price_product/domain/repositories/cart_repository.dart';

import '../../../data/models/cart_item_model.dart';


class GetCartUseCase {
  final CartRepository _repository;

  GetCartUseCase(this._repository);

  List<CartItemModel> call() {
    return _repository.getCart();
  }
}