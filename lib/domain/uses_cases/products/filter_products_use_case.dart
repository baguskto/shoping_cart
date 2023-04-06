import '../../../data/models/product_model.dart';

class FilterProductsUseCase {
  List<ProductModel> call(
      {required List<ProductModel> products,
      required String minPrice,
      required String maxPrice}) {
    int? convertedMinPrice = minPrice.isNotEmpty ? int.parse(minPrice) : null;
    int? convertedMaxPrice = maxPrice.isNotEmpty ? int.parse(maxPrice) : null;

    return products.where((product) {
      if (convertedMinPrice != null && convertedMaxPrice != null) {
        return product.price >= convertedMinPrice &&
            product.price <= convertedMaxPrice;
      } else if (convertedMinPrice != null) {
        return product.price >= convertedMinPrice;
      } else if (convertedMaxPrice != null) {
        return product.price <= convertedMaxPrice;
      } else {
        return true;
      }
    }).toList();
  }
}
