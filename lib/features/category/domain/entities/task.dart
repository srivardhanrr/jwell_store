import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final String id;
  final String name;
  final String image;
  const Task({required this.id, required this.name, required this.image});

  Task copyWith({String? id, String? name, String? image}) {
    return Task(
        id: id ?? this.id, name: name ?? this.name, image: image ?? this.image);
  }

  @override
  List<Object?> get props => [id];
}
