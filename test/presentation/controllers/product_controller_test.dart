import 'package:filter_price_product/data/models/product_model.dart';
import 'package:filter_price_product/domain/uses_cases/cart/add_cart_use_case.dart';
import 'package:filter_price_product/domain/uses_cases/products/fetch_product_use_case.dart';
import 'package:filter_price_product/domain/uses_cases/products/filter_products_use_case.dart';
import 'package:filter_price_product/presentation/controllers/products_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFetchProductsUseCase extends Mock implements FetchProductsUseCase {}

class MockAddCartUseCase extends Mock implements AddCartUseCase {}

class MockFilterProductsUseCase extends Mock implements FilterProductsUseCase {}

void main() {
  late ProductController productController;
  late FetchProductsUseCase fetchProductsUseCase;
  late AddCartUseCase addCartUseCase;
  late FilterProductsUseCase filterProductsUseCase;

  setUp(() {
    // TestWidgetsFlutterBinding.ensureInitialized();
    fetchProductsUseCase = MockFetchProductsUseCase();
    addCartUseCase = MockAddCartUseCase();
    filterProductsUseCase = MockFilterProductsUseCase();
    productController = ProductController(
      fetchProductsUseCase,
      addCartUseCase,
      filterProductsUseCase,
    );
  });

  group('ProductController', () {
    final product1 = ProductModel(
      id: 1,
      title: 'Product 1',
      description: 'This is product 1',
      price: 100,
      discountPercentage: 0.1,
      rating: 4.5,
      stock: 10,
      brand: 'Brand A',
      category: 'Category A',
      thumbnail: 'https://example.com/product1.jpg',
    );
    final product2 = ProductModel(
      id: 2,
      title: 'Product 2',
      description: 'This is product 2',
      price: 200,
      discountPercentage: 0.2,
      rating: 4.0,
      stock: 20,
      brand: 'Brand B',
      category: 'Category B',
      thumbnail: 'https://example.com/product2.jpg',
    );
    final products = [product1, product2];

    test('fetchProducts() should populate showProducts and allProducts',
        () async {
      when(() => fetchProductsUseCase.call()).thenAnswer((_) async => products);

      await productController.fetchProducts();

      expect(productController.showProducts, products);
      expect(productController.allProducts, products);
    });

    test('filterWithMinimumPrice() should filter products by minimum price',
        () {
      final filteredProducts = [product2];

      when(() => filterProductsUseCase.call(
          products: products,
          minPrice: '150',
          maxPrice: '')).thenReturn(filteredProducts);

      productController.allProducts.addAll(products);
      productController.showProducts.addAll(products);
      productController.filterWithMinimumPrice('150', '');

      expect(productController.showProducts, filteredProducts);
    });

    test('resetFilter() should reset showProducts to allProducts', () {
      productController.allProducts.addAll(products);
      productController.showProducts.addAll([product1]);
      productController.resetFilter();

      expect(productController.showProducts, products);
    });

    test('addToCart() should call AddCartUseCase', () {
      productController.addToCart(product1);

      verify(() => addCartUseCase.call(product: product1)).called(1);
    });
  });
}
