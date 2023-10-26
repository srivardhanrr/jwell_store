import '../../domain/entities/task.dart';
import '../models/task_model.dart';

extension ExpenseModelExtension on TaskModel {
  Task toEntity() => Task(
        id: id!,
        name: name,
        imageUrl: imageUrl,
        category: category,
      );
}

extension ExpenseEntityExtension on Task {
  TaskModel toModel() => TaskModel(
        id: id,
        name: name,
        category: category,
        imageUrl: imageUrl,
      );
}
