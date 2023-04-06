import 'package:filter_price_product/data/models/product_model.dart';
import 'package:filter_price_product/domain/uses_cases/cart/add_cart_use_case.dart';
import 'package:filter_price_product/domain/uses_cases/products/fetch_product_use_case.dart';
import 'package:filter_price_product/domain/uses_cases/products/filter_products_use_case.dart';
import 'package:filter_price_product/presentation/navigation/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  final FetchProductsUseCase _fetchProductsUseCase;
  final AddCartUseCase _addCartUseCase;
  final FilterProductsUseCase _filterProductsUseCase;

  final showProducts = <ProductModel>[].obs;
  final allProducts = <ProductModel>[].obs;

  final minPriceTEController = TextEditingController();
  final maxPriceTEController = TextEditingController();
  final titleKey = GlobalKey<FormState>();

  ProductController(
    this._fetchProductsUseCase,
    this._addCartUseCase,
    this._filterProductsUseCase,
  );

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    final products = await _fetchProductsUseCase.call();
    showProducts.assignAll(products);
    allProducts.assignAll(products);
  }

  void filterWithMinimumPrice(String minPrice, String maxPrice) {
    final filteredProducts = _filterProductsUseCase.call(
      products: allProducts,
      minPrice: minPrice,
      maxPrice: maxPrice,
    );
    showProducts.assignAll(filteredProducts);
  }

  void resetFilter() {
    showProducts.assignAll(allProducts);
    clearTextForm();
  }

  void goToCart() {
    Get.toNamed(Routes.CART);
  }

  void addToCart(ProductModel product) {
    _addCartUseCase.call(product: product);
  }

  void clearTextForm() {
    maxPriceTEController.clear();
    minPriceTEController.clear();
  }

  void closeFilterDialog() {
    Get.back();
  }
}
