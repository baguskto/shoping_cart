import 'package:cached_network_image/cached_network_image.dart';
import 'package:filter_price_product/domain/core/helpers/currency_helper.dart';
import 'package:filter_price_product/presentation/controllers/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletons/skeletons.dart';

class CartItemWidget extends GetWidget<CartController> {
  final int index;

  const CartItemWidget({required this.index, super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final product = controller.cart[index];
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          child: Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            height: 120,
            width: Get.width - 32,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: CachedNetworkImage(
                      width: 100,
                      height: 100,
                      imageUrl: product.thumbnail,
                      fit: BoxFit.cover,
                      placeholder: (_, __) => SkeletonAvatar(),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.title,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          product.price.toRupiah(),
                        ),
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                                onPressed: () => controller.incrementItemCart(
                                    product.id, product.price),
                                icon: const Icon(Icons.add_box_rounded)),
                            Container(
                              color: Colors.black,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 5.0, vertical: 1.0),
                                child: Text(
                                  product.totalItem.toString(),
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            IconButton(
                                onPressed: () => controller.decrementItemCart(
                                    product.id, product.price),
                                icon:
                                    const Icon(Icons.indeterminate_check_box)),
                            IconButton(
                                onPressed: () =>
                                    controller.deleteItemCart(product.id),
                                icon: const Icon(
                                  Icons.delete_rounded,
                                  color: Colors.red,
                                ))
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
