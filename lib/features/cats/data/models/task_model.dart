class TaskModel {
  String? id;
  String name;
  String category;
  List imageUrl;

  TaskModel({
    this.id,
    required this.name,
    required this.category,
    required this.imageUrl,
  });

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['\$id'] as String?,
      name: map['name'] as String,
      category: map['category']['name'] as String,
      imageUrl: map['imageUrl'] as List,
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'category': category, 'imageUrl': imageUrl};
  }
}
