import 'package:filter_price_product/presentation/bindings/cart_binding.dart';
import 'package:filter_price_product/presentation/bindings/products_binding.dart';
import 'package:get/get.dart';

import '../../presentation/pages/pages.dart';
import 'routes.dart';

class Nav {
  static List<GetPage> routes = [
    GetPage(
      name: Routes.PRODUCTS,
      page: () =>  const ProductsPage(),
      binding: ProductsBinding(),
    ),
    GetPage(
      name: Routes.CART,
      page: () => const CartPage(),
      binding: CartBinding(),
    ),
  ];
}
