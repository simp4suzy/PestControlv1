// lib/models/category.dart
class Category {
  final String id;
  final String name;
  final String description;
  final String iconPath;

  Category({
    required this.id,
    required this.name,
    required this.description,
    required this.iconPath,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      iconPath: json['iconPath'],
    );
  }
}