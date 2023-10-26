import 'package:core/core.dart';
import 'package:dartz/dartz.dart' hide Task;

import '../entities/product.dart';

abstract class ProductsRepository {
  Future<Either<Failure, List<Product>>> getProducts();
}
