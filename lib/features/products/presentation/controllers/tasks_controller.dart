import 'package:riverpod/riverpod.dart';

import '../../domain/domain.dart';
import '../states/tasks_state.dart';

class TasksController extends StateNotifier<TasksState> {
  final GetProducts getTasksUseCase;
  TasksController({
    required this.getTasksUseCase,
  }) : super(TasksInitial()) {
    getTasks();
  }

  Future<void> getTasks() async {
    state = TasksLoading(state.tasks);

    var response = await getTasksUseCase();

    response.fold((failure) {
      state = TasksFailed(failure);
    }, (tasks) {
      if (tasks.isEmpty) {
        state = TasksEmpty();
        return;
      }
      state = TasksData(tasks);
    });
  }

  final tasksProvider =
      StateNotifierProvider.autoDispose<TasksController, TasksState>((ref) {
    GetProducts getTasksUseCase = ref.watch(getTasksUseCaseProvider);
    return TasksController(
      getTasksUseCase: getTasksUseCase,
    );
  });
}
