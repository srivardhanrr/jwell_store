import 'package:flutter/material.dart';

import '../../domain/entities/product.dart';

class TaskScreen extends StatelessWidget {
  static String get routePath => "/task";
  final Product task;
  const TaskScreen({
    Key? key,
    required this.task,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(task.name),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(children: [
          Text(
            task.category,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.black54,
                ),
          ),
        ]),
      ),
    );
  }
}
