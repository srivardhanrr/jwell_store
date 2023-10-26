import 'dart:developer';

import 'package:appwrite/appwrite.dart';
import 'package:core/core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:jwell_store/config/constants.dart';
import 'package:jwell_store/features/products/data/models/product_model.dart';

import '../../../../config/client.dart';

abstract class ProductsRemoteDataSource implements LocalDataSource {
  Future<List<ProductModel>> getProducts();
}

class ProductsLocalDataSourceImpl extends ProductsRemoteDataSource {
  final Databases databases;

  ProductsLocalDataSourceImpl(this.databases);

  @override
  Future<List<ProductModel>> getProducts() async {
    try {
      var tasks = await databases.listDocuments(
        collectionId: productsCollectionId,
        databaseId: databaseId,
      );
      log("tasks: ${tasks.documents}");

      return tasks.documents.map((e) {
        log("e.data: ${e.data}");
        return ProductModel.fromMap(e.data);
      }).toList();
    } catch (e) {
      log("$e");
      throw CacheException();
    }
  }

  @override
  Future<void> clear() async {
    try {
      //await databases.
    } catch (e) {
      log("$e");
      throw CacheException();
    }
  }
}

final tasksBoxProvider =
    FutureProvider.autoDispose<Box<ProductModel>>((ref) async {
  Box<ProductModel> box = await Hive.openBox("tasks");
  ref.onDispose(() {
    box.close();
    log("tasksBoxProvider disposed");
  });
  return box;
});

final productsLocalDataSourceProvider =
    Provider.autoDispose<ProductsRemoteDataSource>((ref) {
  return ProductsLocalDataSourceImpl(ref.watch(databasesProvider));
});
