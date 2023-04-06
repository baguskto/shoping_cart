import 'package:cached_network_image/cached_network_image.dart';
import 'package:filter_price_product/data/models/product_model.dart';
import 'package:filter_price_product/domain/core/helpers/currency_helper.dart';
import 'package:filter_price_product/presentation/controllers/products_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletons/skeletons.dart';

import '../../domain/core/constants/button_constants.dart';
import '../../domain/core/constants/content_constant.dart';

class ProductsPage extends GetView<ProductController> {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Products'),
        centerTitle: false,
        actions: [
          IconButton(
              onPressed: () => _showAddTodoDialog(),
              icon: const Icon(Icons.filter_alt_rounded)),
          IconButton(
              onPressed: () => controller.goToCart(),
              icon: const Icon(Icons.shopping_cart_rounded)),
        ],
      ),
      body: Obx(
        () => controller.showProducts.isEmpty
            ? SkeletonListView()
            : ListView.builder(
                itemCount: controller.showProducts.length,
                itemBuilder: (context, index) {
                  final product = controller.showProducts[index];
                  return _productItemWidget(product);
                },
              ),
      ),
    );
  }

  Widget _productItemWidget(ProductModel product) {
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
                        style: const TextStyle(fontWeight: FontWeight.bold),
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
                          ElevatedButton(
                              onPressed: () => controller.addToCart(product),
                              child: const Text('Add to cart'))
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
  }

  void _showAddTodoDialog() {
    Get.dialog(
      AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(ContentConstants.filterTitle),
            IconButton(
                onPressed: () => controller.closeFilterDialog(),
                icon: const Icon(Icons.close))
          ],
        ),
        content: SizedBox(
          height: Get.height / 3,
          child: Form(
              key: controller.titleKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: controller.minPriceTEController,
                    keyboardType: TextInputType.number,
                    maxLines: 1,
                    decoration: const InputDecoration(
                        hintText: ContentConstants.minPriceHint,
                        labelText: 'Terendah',
                        border: OutlineInputBorder(),
                        prefixText: 'Rp '),
                    // validator: (v) => controller.emptyValidator(v!),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: controller.maxPriceTEController,
                    keyboardType: TextInputType.number,
                    maxLines: 1,
                    decoration: const InputDecoration(
                      hintText: ContentConstants.maxPriceHint,
                      labelText: 'Tertinggi',
                      border: OutlineInputBorder(),
                      prefixText: 'Rp ',
                    ),
                  ),
                ],
              )),
        ),
        actions: [
          TextButton(
            onPressed: () {
              controller.filterWithMinimumPrice(
                controller.minPriceTEController.text,
                controller.maxPriceTEController.text,
              );
              Get.back();
            },
            child: const Text(ButtonConstants.show),
          ),
          TextButton(
            onPressed: () {
              controller.resetFilter();
              Get.back();
            },
            child: const Text(ButtonConstants.reset),
          ),
        ],
      ),
    );
  }
}
