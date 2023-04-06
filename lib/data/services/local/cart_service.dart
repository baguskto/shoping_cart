import 'package:filter_price_product/data/models/product_model.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../domain/core/constants/constants.dart';
import '../../models/cart_item_model.dart';

class CartService {
  final GetStorage _box;

  CartService(this._box);

  Future<void> saveCart(List<CartItemModel> cart) async {
    await _box.write(
      StorageConstants.taskKey,
      cart.map((product) => product.toJson()).toList(),
    );
  }

  List<CartItemModel> getCart() {
    List<dynamic> storedCart =
        _box.read<List<dynamic>>(StorageConstants.taskKey) ?? [];

    return storedCart
        .map((e) => CartItemModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }



  Future<void> deleteItemCart(int productId) async {
    List<CartItemModel> cart = getCart();
    cart.removeWhere((product) => product.id == productId);
    await saveCart(cart);
  }

}
