import 'package:flutter/material.dart';

import 'category_list_view.dart';
import 'home/presentation/widgets/greetings_view.dart';

class ItemScreen extends StatelessWidget {
  final String categoryId;
  const ItemScreen({super.key, required this.categoryId});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const GreetingsView(),
          Expanded(
              child: CategoryItemsListView(
            categoryId: categoryId,
          )),
        ],
      ),
    );
  }
}
