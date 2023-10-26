import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:jwell_store/config/constants.dart';
import 'package:jwell_store/features/cats/data/models/task_model.dart';
import 'package:jwell_store/features/item_view.dart';

class CategoryItemsListView extends StatefulWidget {
  final String categoryId;
  const CategoryItemsListView({Key? key, required this.categoryId})
      : super(key: key);

  @override
  State<CategoryItemsListView> createState() => _CategoryItemsListViewState();
}

class _CategoryItemsListViewState extends State<CategoryItemsListView> {
  List products = [];

  Future<void> loadProducts() async {
    Client client = Client();
    client.setEndpoint(apiUrl).setProject(projectUrl);
    Databases databases = Databases(client);
    var tasks = await databases.listDocuments(
      collectionId: productsCollectionId,
      databaseId: databaseId,
      queries: [
        Query.equal('category', [widget.categoryId]),
      ],
    );
    var ta = tasks.documents.map((e) {
      return TaskModel.fromMap(e.data);
    }).toList();
    setState(() {
      products = ta;
    });
  }

  @override
  void initState() {
    super.initState();
    loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 10,
      ),
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: products.length,
        itemBuilder: (context, index) {
          var task = products[index];
          return ItemView(task: task);
        },
      ),
    );
  }
}
