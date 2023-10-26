import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String id;
  final String name;
  final String category;
  final double price;
  const Product({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required List<Uri> imageUrl,
  });

  Product copyWith({
    String? id,
    String? title,
    String? description,
    bool? isDone,
  }) {
    return Product(
      id: id ?? this.id,
      name: name,
      category: category,
      price: price,
      imageUrl: [],
    );
  }

  @override
  List<Object?> get props => [id];
}
