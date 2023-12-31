import 'dart:developer';

import 'package:core/core.dart';
import 'package:dartz/dartz.dart' hide Task;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jwell_store/features/cats/tasks.dart';

class TasksRepositoryImpl extends TasksRepository {
  final TasksRemoteDataSource localDataSource;

  TasksRepositoryImpl({
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, Unit>> updateTask(Task task) async {
    try {
      await localDataSource.updateTask(task.toModel());
      return const Right(unit);
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> createTask(
      String title, String description) async {
    try {
      await localDataSource.addTask(title, description);
      return const Right(unit);
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<Task>>> getTasks() async {
    try {
      var taskModels = await localDataSource.getTasks();
      var tasks = taskModels.map((e) => e.toEntity()).toList();
      return Right(tasks);
    } catch (e) {
      log("$e");
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<Task>>> getCategoryTasks(
      String categoryId) async {
    try {
      var taskModels = await localDataSource.getCategoryTasks(categoryId);
      var tasks = taskModels.map((e) => e.toEntity()).toList();
      return Right(tasks);
    } catch (e) {
      log("$e");
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteTask(Task task) async {
    try {
      await localDataSource.deleteTask(task.toModel());
      return const Right(unit);
    } catch (e) {
      return Left(CacheFailure());
    }
  }
}

final tasksRepositoryProvider = Provider.autoDispose<TasksRepository>((ref) {
  final tasksLocalDataSource = ref.watch(tasksLocalDataSourceProvider);
  return TasksRepositoryImpl(localDataSource: tasksLocalDataSource);
});
