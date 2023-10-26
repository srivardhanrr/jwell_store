import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final String id;
  final String name;
  final String category;
  final List imageUrl;
  const Task({
    required this.id,
    required this.name,
    required this.category,
    required this.imageUrl,
  });

  Task copyWith({
    String? id,
    String? name,
    String? category,
    List? imageUrl,
  }) {
    return Task(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  @override
  List<Object?> get props => [id];
}
