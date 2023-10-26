class TaskModel {
  String? id;
  String name;
  String image;

  TaskModel({this.id, required this.name, required this.image});

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['\$id'] as String?,
      name: map['name'] as String,
      image: map['image'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'image': image};
  }
}
