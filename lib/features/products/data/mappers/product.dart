import 'package:jwell_store/features/products/data/data.dart';

import '../../domain/entities/product.dart';

extension ExpenseModelExtension on ProductModel {
  Product toEntity() => Product(
        id: id!,
        name: name,
        category: category,
        price: price,
        imageUrl: imageUrl,
      );
}

extension ExpenseEntityExtension on Product {
  ProductModel toModel() => ProductModel(
        id: id,
        name: name,
        category: category,
        price: price,
        imageUrl: [],
      );
}
