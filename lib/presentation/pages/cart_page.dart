import 'package:filter_price_product/domain/core/helpers/currency_helper.dart';
import 'package:filter_price_product/presentation/controllers/cart_controller.dart';
import 'package:filter_price_product/presentation/widgets/cart_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../domain/core/constants/content_constant.dart';

class CartPage extends GetView<CartController> {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Your Cart'),
          centerTitle: false,
        ),
        body: _body(),
        persistentFooterButtons: [_bottom()]);
  }

  Widget _bottom() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Obx(
          () => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Total : ${controller.totalPrice.value.toRupiah()}',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          ),
        ),
        Container(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {},
            child: Text('Checkout'),
          ),
        )
      ],
    );
  }

  Widget _body() {
    return Obx(
      () => controller.cart.isNotEmpty
          ? ListView.builder(
              itemCount: controller.cart.length,
              itemBuilder: (context, index) {
                return CartItemWidget(index: index);
              },
            )
          : _emptyWidget(),
    );
  }

  Widget _emptyWidget() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
              padding: const EdgeInsets.all(12.0),
              child: IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(
                  Icons.add_shopping_cart_outlined,
                ),
              )),
          const Text(ContentConstants.cartEmpty)
        ],
      ),
    );
  }
}
