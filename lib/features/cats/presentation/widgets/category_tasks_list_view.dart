import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jwell_store/features/cats/presentation/widgets/cat_view.dart';
import 'package:jwell_store/widgets/empty_view.dart';
import 'package:jwell_store/widgets/error_view.dart';

import '../../../../utils/failure.dart';
import '../../../category/presentation/controllers/task_controller.dart';
import '../../../category/presentation/states/task_state.dart';
import '../../tasks.dart';

class TasksCategoryListView extends ConsumerStatefulWidget {
  final String categoryId;
  const TasksCategoryListView({Key? key, required this.categoryId})
      : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TasksListViewState();
}

class _TasksListViewState extends ConsumerState<TasksCategoryListView> {
  @override
  Widget build(BuildContext context) {
    var state = ref.watch(tasksProvider);

    ref.listen(tasksProvider, (previous, next) {
      if (next is TaskDeleted || next is TaskUpdated) {
        ref.read(tasksProvider.notifier).getCategoryTasks(widget.categoryId);
      }
    });

    ref.listen(taskProvider, (previous, next) {
      if (next is TaskAdded) {
        ref.read(tasksProvider.notifier).getTasks();
      }
    });

    if (state is TasksLoading && state.tasks.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (state is TasksFailed) {
      return ErrorView(message: mapFailureToMessage(context, state.failure));
    }

    if (state is TasksEmpty) {
      return const EmptyView(
        message: "No tasks added",
      );
    }

    if (state is TasksData || state.tasks.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 10,
        ),
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: state.tasks.length,
          itemBuilder: (context, index) {
            var task = state.tasks[index];
            return CatView(task: task);
          },
        ),
      );
    }

    return Container();
  }
}
