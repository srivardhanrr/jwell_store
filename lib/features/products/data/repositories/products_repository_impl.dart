import 'dart:developer';

import 'package:core/core.dart';
import 'package:dartz/dartz.dart' hide Task;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jwell_store/features/products/data/data.dart';

import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';

class ProductsRepositoryImpl extends ProductsRepository {
  final ProductsRemoteDataSource localDataSource;

  ProductsRepositoryImpl({
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<Product>>> getProducts() async {
    try {
      var productModels = await localDataSource.getProducts();
      var tasks = productModels.map((e) => e.toEntity()).toList();
      return Right(tasks);
    } catch (e) {
      log("$e");
      return Left(CacheFailure());
    }
  }
}

final productsRepositoryProvider =
    Provider.autoDispose<ProductsRepository>((ref) {
  final productsLocalDataSource = ref.watch(productsLocalDataSourceProvider);
  return ProductsRepositoryImpl(localDataSource: productsLocalDataSource);
});
