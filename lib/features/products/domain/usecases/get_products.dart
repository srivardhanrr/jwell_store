import 'package:core/core.dart';
import 'package:dartz/dartz.dart' hide Task;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/products_repository_impl.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class GetProducts extends NoParamsUseCase<List<Product>> {
  ProductsRepository repository;

  GetProducts({
    required this.repository,
  });

  @override
  Future<Either<Failure, List<Product>>> call() {
    return repository.getProducts();
  }
}

final getTasksUseCaseProvider = Provider.autoDispose<GetProducts>((ref) {
  final repository = ref.watch(productsRepositoryProvider);
  return GetProducts(repository: repository);
});
