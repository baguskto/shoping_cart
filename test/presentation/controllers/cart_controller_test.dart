import 'package:filter_price_product/data/models/cart_item_model.dart';
import 'package:filter_price_product/domain/uses_cases/cart/cart_decrement_use_case.dart';
import 'package:filter_price_product/domain/uses_cases/cart/cart_increment_use_case.dart';
import 'package:filter_price_product/domain/uses_cases/cart/delete_item_cart_use_case.dart';
import 'package:filter_price_product/domain/uses_cases/cart/get_cart_use_case.dart';
import 'package:filter_price_product/presentation/controllers/cart_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetCartUseCase extends Mock implements GetCartUseCase {}

class MockDeleteItemCartUseCase extends Mock implements DeleteItemCartUseCase {}

class MockIncrementItemCartUseCase extends Mock
    implements IncrementItemCartUseCase {}

class MockDecrementItemCartUseCase extends Mock
    implements DecrementItemCartUseCase {}

void main() {
  late MockGetCartUseCase mockGetCartUseCase;
  late MockDeleteItemCartUseCase mockDeleteItemCartUseCase;
  late MockIncrementItemCartUseCase mockIncrementItemCartUseCase;
  late MockDecrementItemCartUseCase mockDecrementItemCartUseCase;

  late CartController cartController;

  setUp(() {
    mockGetCartUseCase = MockGetCartUseCase();
    mockDeleteItemCartUseCase = MockDeleteItemCartUseCase();
    mockIncrementItemCartUseCase = MockIncrementItemCartUseCase();
    mockDecrementItemCartUseCase = MockDecrementItemCartUseCase();

    cartController = CartController(
      mockGetCartUseCase,
      mockDeleteItemCartUseCase,
      mockIncrementItemCartUseCase,
      mockDecrementItemCartUseCase,
    );
  });

  final cartItems = [
    CartItemModel(
      id: 1,
      title: 'Item 1',
      price: 100,
      stock: 10,
      thumbnail: 'thumbnail1.png',
      totalItem: 2,
      totalPrice: 200,
    ),
    CartItemModel(
      id: 2,
      title: 'Item 2',
      price: 200,
      stock: 5,
      thumbnail: 'thumbnail2.png',
      totalItem: 1,
      totalPrice: 200,
    ),
  ];

  test('readCartStorage should update the cart items', () {
    when(() => mockGetCartUseCase.call()).thenReturn(cartItems);

    cartController.readCartStorage();

    expect(cartController.cart, cartItems);
  });

  test('sumCartItemPrice should return the sum of all cart item prices', () {
    final expectedSum =
        cartItems.fold<int>(0, (sum, item) => sum + item.totalPrice!);

    cartController.cart.value = cartItems;

    final sum = cartController.sumCartItemPrice();

    expect(sum, expectedSum);
  });

  test('showTotalPrice should update the total price', () {
    final expectedTotalPrice =
        cartItems.fold<int>(0, (sum, item) => sum + item.totalPrice!);

    cartController.cart.value = cartItems;

    cartController.showTotalPrice();

    expect(cartController.totalPrice.value, expectedTotalPrice);
  });

  test(
      'deleteItemCart should call the deleteItemCartUseCase and update the cart items and total price',
      () {
    final productId = 1;

    when(() => mockDeleteItemCartUseCase.call(productId: productId))
        .thenReturn(true);
    when(() => mockGetCartUseCase.call()).thenReturn([
      cartItems[1],
    ]);
    final expectedTotalPrice = cartItems[1].price;

    cartController.cart.value = cartItems;
    cartController.totalPrice.value = cartController.sumCartItemPrice();

    cartController.deleteItemCart(productId);

    verify(() => mockDeleteItemCartUseCase.call(productId: productId))
        .called(1);
    expect(cartController.cart, [cartItems[1]]);
    expect(cartController.totalPrice.value, expectedTotalPrice);
  });

  test(
      'incrementItemCart should call the incrementItemCartUseCase and update the cart items and total price',
      () {
    final productId = 1;
    final itemPrice = 100;
    when(() => mockIncrementItemCartUseCase.call(
        productId: productId, itemPrice: itemPrice)).thenReturn(true);
    when(() => mockGetCartUseCase.call()).thenReturn([
      CartItemModel(
        id: 1,
        title: 'Item 1',
        price: 100,
        stock: 10,
        thumbnail: 'thumbnail1.png',
        totalItem: 3,
        totalPrice: 300,
      ),
      CartItemModel(
        id: 2,
        title: 'Item 2',
        price: 200,
        stock: 5,
        thumbnail: 'thumbnail2.png',
        totalItem: 1,
        totalPrice: 200,
      ),
    ]);

    final expectedTotalPrice = 500;

    cartController.cart.value = cartItems;
    cartController.totalPrice.value = cartController.sumCartItemPrice();

    cartController.incrementItemCart(productId, itemPrice);

    verify(() => mockIncrementItemCartUseCase.call(
        productId: productId, itemPrice: itemPrice)).called(1);
    expect(cartController.cart.length, cartItems.length);
    expect(cartController.totalPrice.value, expectedTotalPrice);
  });

  test(
      'decrementItemCart should call the decrementItemCartUseCase and update the cart items and total price',
      () {
    final productId = 1;
    final itemPrice = 100;

    when(() => mockDecrementItemCartUseCase.call(
        productId: productId, itemPrice: itemPrice)).thenReturn(true);
    when(() => mockGetCartUseCase.call()).thenReturn([
      CartItemModel(
        id: 1,
        title: 'Item 1',
        price: 100,
        stock: 10,
        thumbnail: 'thumbnail1.png',
        totalItem: 1,
        totalPrice: 100,
      ),
      CartItemModel(
        id: 2,
        title: 'Item 2',
        price: 200,
        stock: 5,
        thumbnail: 'thumbnail2.png',
        totalItem: 1,
        totalPrice: 200,
      ),
    ]);

    final expectedTotalPrice = 300;

    cartController.cart.value = cartItems;
    cartController.totalPrice.value = cartController.sumCartItemPrice();

    cartController.decrementItemCart(productId, itemPrice);

    verify(() => mockDecrementItemCartUseCase.call(
        productId: productId, itemPrice: itemPrice)).called(1);
    expect(cartController.cart.length, cartItems.length);
    expect(cartController.totalPrice.value, expectedTotalPrice);
  });
}
