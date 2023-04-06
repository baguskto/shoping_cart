
import '../../data/models/cart_item_model.dart';


abstract class CartRepository {
  List<CartItemModel> getCart();

  Future<void> saveCart(List<CartItemModel> cart);

  Future<void> deleteItemCart(int productId);
}
