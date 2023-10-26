class ProductModel {
  String? id;
  String name;
  String category;
  List<Uri> imageUrl;
  double price;

  ProductModel({
    this.id,
    required this.name,
    required this.category,
    required this.imageUrl,
    required this.price,
  });

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['\$id'] as String?,
      name: map['name'] as String,
      category: map['category'] as String,
      imageUrl: map['imageUrl'] as List<Uri>,
      price: map['price'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'price': price,
      'imageUrl': imageUrl
    };
  }
}
