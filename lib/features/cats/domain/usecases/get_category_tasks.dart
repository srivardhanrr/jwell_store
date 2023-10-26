import 'package:core/core.dart';
import 'package:dartz/dartz.dart' hide Task;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/tasks_repository_impl.dart';
import '../entities/task.dart';
import '../repositories/task_repository.dart';

class GetCategoryTaskParams {
  String categoryId;
  GetCategoryTaskParams({
    required this.categoryId,
  });
}

class GetCategoryTasks extends UseCase<void, GetCategoryTaskParams> {
  TasksRepository repository;

  GetCategoryTasks({
    required this.repository,
  });

  @override
  Future<Either<Failure, List<Task>>> call(GetCategoryTaskParams params) {
    return repository.getCategoryTasks(params.categoryId);
  }
}

final getCategoryTasksUseCaseProvider = Provider<GetCategoryTasks>((ref) {
  final repository = ref.read(tasksRepositoryProvider);
  return GetCategoryTasks(repository: repository);
});
